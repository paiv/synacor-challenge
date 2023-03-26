#!/usr/bin/env python
import io
import pathlib
import re
import readline
import string
import struct
import sys


MachineTextColor = '\x1b[95m'


class MachineImage:
    def __init__(self, raw):
        self.raw = raw
        self.reset()

    def reset(self):
        n = len(self.raw) // 2
        self.mem = list(struct.unpack(f'<{n}h', self.raw))
        self.reg = [0] * 8
        self.stack = list()
        self.ip = 0
        self.in_queue = list()

    def dump_mem(self, fp):
        n = len(self.mem)
        raw = struct.pack(f'<{n}h', *self.mem)
        fp.write(raw)

    def write(self, fp):
        so = io.BytesIO()
        def write_list(fp, a):
            n = len(a)
            fp.write(struct.pack('<I', n*2))
            fp.write(struct.pack(f'<{n}h', *a))
        write_list(so, [self.ip] + self.reg)
        write_list(so, self.mem)
        write_list(so, self.stack)
        data = so.getvalue()
        fp.write(b'SNCR' + data)

    def load(fp):
        def read_int(fp):
            x, = struct.unpack('<I', fp.read(4))
            return x
        def read_list(fp):
            n = read_int(fp)
            return struct.unpack(f'<{n//2}h', fp.read(n))
        magic = fp.read(4)
        assert magic == b'SNCR'
        ip,*reg = read_list(fp)
        n = read_int(fp)
        raw = fp.read(n)
        stack = read_list(fp)
        im = MachineImage(raw)
        im.ip = ip
        im.reg = list(reg)
        im.stack = list(stack)
        return im


class TextPrinter:
    def __init__(self):
        self.is_relaxed = True
        self.color_start = MachineTextColor
        self.color_end = '\x1b[0m'
        self.output_started = False

    def print_char(self, c):
        if self.is_relaxed:
            if c == '\n':
                s = (self.color_end + c) if self.output_started else c
                self.output_started = False
            else:
                s = c if self.output_started else (self.color_start + c)
                self.output_started = True
            print(s, end='')
        else:
            print(self.color_start + c + self.color_end, end='', flush=True)

    def flush(self):
        if self.is_relaxed and self.output_started:
            print(self.color_end, flush=True)
        

class Machine:
    def __init__(self, image):
        self.image = image
        self.s_halt = False
        self.s_break = False
        self.is_disassemble = True
        self.printer = TextPrinter()
        self.breakpoints = list()
        self.callstack = [self.image.ip]
        self._op_size = [1, 3, 2, 2, 4, 4, 2, 3, 3, 4, 4, 4, 4, 4, 3, 3, 3, 2, 1, 2, 2, 1]
        
    def load(fp):
        raw = fp.read()
        image = MachineImage(raw)
        return Machine(image)

    @property
    def is_halted(self):
        return self.s_halt

    def run(self, break_next=False):
        self.printer.is_relaxed = not self.is_disassemble
        self.s_break = break_next
        try:
            self._runloop()
        except KeyboardInterrupt:
            pass
        if self.is_disassemble:
            self.disassemble()

    def run_next(self):
        self.run(break_next=True)

    def run_step(self):
        im = self.image
        op = im.mem[im.ip]
        if op == 17: # call
            addr = im.ip + self._op_size[op]
            self.add_breakpoint(addr)
            self.run()
        else:
            self.run(break_next=True)

    def run_stepout(self):
        if not self.callstack:
            return
        im = self.image
        addr = self.callstack[-1]
        op = im.mem[addr]
        addr += self._op_size[op]
        self.add_breakpoint(addr)
        self.run()

    def disassemble(self, addr=None, lines=5):
        im = self.image
        if addr is None:
            addr = im.ip
        s = vm_disasm(im, addr=addr, lines=lines)
        print(f'\n{s}', file=sys.stderr)
        
    def _runloop(self):
        im = self.image
        mb = len(im.mem)

        def rval(i):
            if i in self.breakpoints:
                self.s_break = True
            r = im.mem[i]
            if r >= 0:
                return r
            if r < -0x7ff8:
                return im.reg[r + 0x8000]
            self.s_halt = True

        def lval(i, x):
            r = im.mem[i]
            if r >= 0:
                im.mem[r] = x
                if r in self.breakpoints:
                    self.s_break = True
            elif r < -0x7ff8:
                im.reg[r + 0x8000] = x
            else:
                self.s_halt = True

        while (0 <= im.ip < mb) and not self.s_halt:
            op = im.mem[im.ip]

            match op:
                case 0:
                    self.s_halt = True

                case 1:
                    if (b := rval(im.ip+2)) is not None:
                        lval(im.ip+1, b)
                        im.ip += 3

                case 2:
                    if (a := rval(im.ip+1)) is not None:
                        im.stack.append(a)
                        im.ip += 2

                case 3:
                    if im.stack:
                        x = im.stack.pop()
                        lval(im.ip+1, x)
                        im.ip += 2
                    else:
                        self.s_halt = True
                        
                case 4:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, 1 if b == c else 0)
                        im.ip += 4
                        
                case 5:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, 1 if b > c else 0)
                        im.ip += 4
                        
                case 6:
                    if (a := rval(im.ip+1)) is not None:
                        im.ip = a

                case 7:
                    a = rval(im.ip+1)
                    b = rval(im.ip+2)
                    if not ((a is None) or (b is None)):
                        if a:
                            im.ip = b
                        else:
                            im.ip += 3
                            
                case 8:
                    a = rval(im.ip+1)
                    b = rval(im.ip+2)
                    if not ((a is None) or (b is None)):
                        if not a:
                            im.ip = b
                        else:
                            im.ip += 3

                case 9:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, (b + c) % 0x8000 )
                        im.ip += 4

                case 10:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, (b * c) % 0x8000)
                        im.ip += 4
                        
                case 11:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, (b % c))
                        im.ip += 4
                        
                case 12:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, b & c)
                        im.ip += 4
                        
                case 13:
                    b = rval(im.ip+2)
                    c = rval(im.ip+3)
                    if not ((b is None) or (c is None)):
                        lval(im.ip+1, b | c)
                        im.ip += 4
                        
                case 14:
                    b = rval(im.ip+2)
                    if (b is not None):
                        lval(im.ip+1, ~b % 0x8000)
                        im.ip += 3

                case 15:
                    b = rval(im.ip+2)
                    if (b is not None):
                        if b in self.breakpoints:
                            self.s_break = True
                        b = im.mem[b]
                        lval(im.ip+1, b)
                        im.ip += 3

                case 16:
                    a = rval(im.ip+1)
                    b = rval(im.ip+2)
                    if not ((a is None) or (b is None)):
                        if a in self.breakpoints:
                            self.s_break = True
                        im.mem[a] = b
                        im.ip += 3

                case 17:
                    a = rval(im.ip+1)
                    if (a is not None):
                        im.stack.append(im.ip+2)
                        self.callstack.append(im.ip)
                        im.ip = a

                case 18:
                    if im.stack:
                        a = im.stack.pop()
                        if self.callstack:
                            self.callstack.pop()
                        im.ip = a
                    else:
                        self.s_halt = True
                        
                case 19:
                    if (c := rval(im.ip+1)) is not None:
                        self.printer.print_char(chr(c))
                        im.ip += 2

                case 20:
                    try:
                        while not im.in_queue:
                            s = input('> ')
                            if s:
                                im.in_queue.extend('\n' + s[::-1])
                        if im.in_queue:
                            c = im.in_queue.pop()
                            lval(im.ip+1, ord(c))
                            im.ip += 2
                    except EOFError:
                        self.s_halt=True

                case 21:
                    im.ip += 1

                case _:
                    self.printer.flush()
                    raise Exception((f'{im.ip:04x}: {op:02x}'))
                
            if self.s_break:
                break

            if (0 <= im.ip < mb) and not self.s_halt:
                op = im.mem[im.ip]
                if self.breakpoints:
                    rda = range(im.ip, im.ip + self._op_size[op])
                    if any(p in rda for p in self.breakpoints):
                        break
                
        if im.ip >= mb:
            self.s_halt = True
        self.printer.flush()

    def reset(self):
        self.image.reset()
        self.s_halt = False
        self.s_break = False

    def dump_mem(self, fn):
        with open(fn, 'wb') as fp:
            self.image.dump_mem(fp)
        print(f'\n{fn!r} dumped', file=sys.stderr)
    
    def write_save(self, fn):
        fn = pathlib.Path(fn)
        fn.parent.mkdir(parents=True, exist_ok=True)
        with open(fn, 'wb') as fp:
            self.image.write(fp)
        print(f'\n{fn!s} saved', file=sys.stderr)

    def read_save(self, fn):
        if fn.is_file():
            with open(fn, 'rb') as fp:
                self.image = MachineImage.load(fp)
                self.s_halt = False
                self.s_break = False
            print(f'\n{fn!s} loaded', file=sys.stderr)
        else:
            print(f'\n{fn!s} not found', file=sys.stderr)
            
    def find(self, s):
        mem = self.image.mem
        q = list(s)
        start = 0
        while start < len(mem):
            b = mem[start:start+len(s)]
            if b == q:
                addr = start
                start += len(s)
                print(mem_dump(mem, addr, addr+16), end='\n\n', file=sys.stderr)
            else:
                start += 1
                
    def add_breakpoint(self, addr=None):
        if addr is None:
            addr = self.image.ip
        self.breakpoints = [x for x in self.breakpoints if x != addr]
        self.breakpoints.append(addr)
        
    def remove_breakpoint(self, addr=None):
        if addr is None:
            addr = self.image.ip
        self.breakpoints = [x for x in self.breakpoints if x != addr]
        
    def list_breakpoints(self):
        so = '\n'.join(f' - {x:04x}' for x in self.breakpoints)
        print(so, file=sys.stderr)

    def print_callstack(self):
        so = '\n'.join(f' - {vm_disasm(self.image, x)}' for x in self.callstack)
        print(so, file=sys.stderr)

    def print_stack(self):
        so = mem_dump(self.image.stack)
        print(so, file=sys.stderr)
        
    def print_memory(self, addr, columns=16, lines=5):
        stop = addr + columns * lines
        so = mem_dump(self.image.mem, addr, stop, columns)
        print(so, file=sys.stderr)
        
    def print_registers(self):
        so = mem_dump(self.image.reg)
        print(so, file=sys.stderr)

    def write_mem(self, addr, values):
        mem = self.image.mem
        for x in values:
            if 0 <= addr < len(mem):
                mem[addr] = x
            addr += 1

    def write_reg(self, reg, value):
        regs = self.image.reg
        if isinstance(reg, str) and reg.startswith('r'):
            reg = int(reg[1:], 16)
        if 0 <= reg < len(regs):
            regs[reg] = value


def _hex_maketrans():
    abc = set((string.ascii_letters + string.digits + string.punctuation).encode('ascii'))
    a = bytes(range(256))
    b = bytes(x if x in abc else ord('.') for x in range(256))
    return bytes.maketrans(a, b)
_hextr = _hex_maketrans()


def hexdump(data, start=None, stop=None, columns=16, ascii=True):
    so = list()
    if start is None:
        start = 0
    if stop is None:
        stop = len(data)
    for r in range(start, stop, columns):
        s = data[r:r+columns]
        q = f'{r:04x}: ' + ' '.join(f'{x:02x}' for x in s)
        if ascii:
            ws = '   ' * (columns - len(s)) + '  '
            q += ws + ''.join(s.translate(_hextr).decode('ascii'))
        so.append(q)
    return '\n'.join(so)


def mem_dump(data, start=None, stop=None, columns=16, ascii=True):
    so = list()
    if start is None:
        start = 0
    if stop is None:
        stop = len(data)
    for r in range(start, stop, columns):
        s = data[r:r+columns]
        q = f'{r:04x}: ' + ' '.join(f'{(x+0x8000)%0x8000:04x}' for x in s)
        if ascii:
            ws = '     ' * (columns - len(s)) + '  '
            q += ws + ''.join((chr(x) if x in range(32,127) else '.') for x in s)
        so.append(q)
    return '\n'.join(so)


def vm_disasm(image, addr=None, lines=1):
    if addr is None:
        addr = image.ip
    if not lines:
        lines = 1
    mem = image.mem
    reg = image.reg
    ip = addr
    def rval(i):
        r = mem[i]
        if r >= 0:
            return f'{r:04x}'
        if r < -0x7ff8:
            return f'r{r + 0x8000}'
        return f'(invalid value {r:02x})'
    def lval(i):
        r = mem[i]
        if r >= 0:
            return f'{r:04x}'
        if r < -0x7ff8:
            return f'r{r + 0x8000}'
        return f'(invalid value {r:02x})'

    so = list()
    for _ in range(lines):
        sip = f'{ip:04x}'
        match (op := mem[ip]):
            case 0:
                so.append(f'{sip}: halt')
                ip += 1
            case 1:
                a,b = lval(ip+1), rval(ip+2)
                so.append(f'{sip}: set {a} {b}')
                ip += 3
            case 2:
                a = rval(ip+1)
                so.append(f'{sip}: push {a}')
                ip += 2
            case 3:
                a = lval(ip+1)
                so.append(f'{sip}: pop {a}')
                ip += 2
            case 4:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: eq {a} {b} {c}')
                ip += 4
            case 5:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: gt {a} {b} {c}')
                ip += 4
            case 6:
                a = lval(ip+1)
                so.append(f'{sip}: jmp {a}')
                ip += 2
            case 7:
                a,b = rval(ip+1), lval(ip+2)
                so.append(f'{sip}: jt {a} {b}')
                ip += 3
            case 8:
                a,b = rval(ip+1), lval(ip+2)
                so.append(f'{sip}: jf {a} {b}')
                ip += 3
            case 9:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: add {a} {b} {c}')
                ip += 4
            case 10:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: mult {a} {b} {c}')
                ip += 4
            case 11:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: mod {a} {b} {c}')
                ip += 4
            case 12:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: and {a} {b} {c}')
                ip += 4
            case 13:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                so.append(f'{sip}: or {a} {b} {c}')
                ip += 4
            case 14:
                a,b = lval(ip+1), rval(ip+2)
                so.append(f'{sip}: not {a} {b}')
                ip += 3
            case 15:
                a,b = lval(ip+1), lval(ip+2)
                so.append(f'{sip}: rmem {a} {b}')
                ip += 3
            case 16:
                a,b = lval(ip+1), rval(ip+2)
                so.append(f'{sip}: wmem {a} {b}')
                ip += 3
            case 17:
                a = lval(ip+1)
                so.append(f'{sip}: call {a}')
                ip += 2
            case 18:
                so.append(f'{sip}: ret')
                ip += 1
            case 19:
                a = rval(ip+1)
                if isinstance(a, int) and (32 <= a < 127 or a == 10):
                    a = repr(chr(a))
                so.append(f'{sip}: out {a}')
                ip += 2
            case 20:
                a = lval(ip+1)
                so.append(f'{sip}: in {a}')
                ip += 2
            case 21:
                so.append(f'{sip}: noop')
                ip += 1
            case _:
                # raise Exception((f'{sip}: {op:02x}'))
                so.append(f'{sip}: ?? ({op:04x})')
                ip += 1
    return '\n'.join(so)


class Ida:
    def __init__(self, machine):
        self.vm = machine
        self.s_quit = False
        self._history = list()

    def interact(self):
        try:
            while not self.s_quit:
                command = input(': ')
                self._history.append(command)
                self._process_command(command)
        except EOFError:
            pass

    def _process_command(self, command):
        if command.isspace():
            return
        if not command:
            self._history.pop()
            if self._history and (prev := self._history[-1]):
                self._process_command(prev)
            return

        def parse_int(s):
            try:
                return int(s, 16)
            except ValueError as err:
                print(err, file=sys.stderr)
        
        op,*args = command.split()
        match op.lower():
            case 'run' | 'c':
                self.vm.run()
            case 'next' | 'n':
                self.vm.run_next()
            case 'step' | 's':
                self.vm.run_step()
            case 'finish' | 'fin':
                self.vm.run_step_out()
            case 'write' | 'w':
                if len(args) > 1:
                    t = args[0]
                    xs = [parse_int(s) for s in args[1:]]
                    if all(x is not None for x in xs):
                        if t.lower().startswith('r'):
                            self.vm.write_reg(t.lower(), xs[-1])
                        elif (addr := parse_int(t)) is not None:
                            self.vm.write_mem(addr, xs)
            case 'dump':
                fn = args[0] if args else 'dump.bin'
                self.vm.dump_mem(fn)
            case 'reset':
                self.vm.reset()
            case 'quit' | 'exit':
                self.s_quit = True
            case 'save':
                fn = args[0] if args else 'save000'
                fn = pathlib.Path('saves') / fn
                self.vm.write_save(fn)
            case 'load':
                fn = args[0] if args else 'save000'
                fn = pathlib.Path('saves') / fn
                self.vm.read_save(fn)
            case 'find':
                _,*ps = re.findall(r'^\s*find\b\s*|.+$', command)
                if ps and (s := ps[0]):
                    try:
                        if s[0] in '\'"':
                            s = eval(s, dict())
                    except:
                        return
                    if isinstance(s, str):
                        s = s.encode()
                    if isinstance(s, bytes):
                        self.vm.find(s)
            case 'b':
                if args:
                    if (addr := parse_int(args[0])):
                        self.vm.add_breakpoint(addr)
                else:
                    self.vm.add_breakpoint()
            case 'bl':
                self.vm.list_breakpoints()
            case 'bd':
                if args:
                    if (addr := parse_int(args[0])):
                        self.vm.remove_breakpoint(addr)
                else:
                    self.vm.remove_breakpoint()
            case 'bt':
                self.vm.print_callstack()
            case 'stack':
                self.vm.print_stack()
            case 'mem':
                if args and (addr := parse_int(args[0])) is not None:
                    self.vm.print_memory(addr)
            case 'regs':
                self.vm.print_registers()
            case 'disasm' | 'dis':
                lines = parse_int(args[-1]) if len(args) > 1 else 5
                if args:
                    if (addr := parse_int(args[0])) is not None:
                        self.vm.disassemble(addr, lines=lines)
                else:
                    self.vm.disassemble(lines=lines)
            case _:
                usage = """Debugger commands:
reset
        restart the executable
c, run
        continue execution
s, step
        step over calls
n, next
        next instruction
fin, finish
        step out
dis [addr] [lines]
        disassemble
dump [file]
        dump memory to file
save [file]
        save state
load [file]
        load save
find [text]
        search for text
b [addr]
        add exec/memory breakpoint
bl
        list breakpoints
bd [addr]
        remove breakpoint
bt
        print call stack
stack
        show stack
mem [addr]
        show memory
w, write [addr|reg] [value]
        write to memory or register
regs
        show registers
quit
        exit debugger
help
        this help screen                    
"""
                print(usage)
        

def main(image):
    with open(image, 'rb') as fp:
        vm = Machine.load(fp)
    dis = Ida(vm)
    dis.interact()


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('image', type=pathlib.Path, help='binary image of the challenge virtual machine')
    args = parser.parse_args()
    main(image=args.image)