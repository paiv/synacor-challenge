#!/usr/bin/env python
import io
import pathlib
import readline
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
        self.is_disassemble = False
        self.printer = TextPrinter()
        
    @property
    def is_halted(self):
        return self.s_halt

    def run(self):
        im = self.image
        mb = len(im.mem)
        self.printer.is_relaxed = not self.is_disassemble

        def rval(i):
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
            elif r < -0x7ff8:
                im.reg[r + 0x8000] = x
            else:
                self.s_halt = True

        while 0 <= im.ip < mb and not self.s_halt:
            if self.is_disassemble:
                s = vm_disasm(im, addr=im.ip)
                print(f'\n{im.ip:04x}: {s}', file=sys.stderr)
            
            match (op := im.mem[im.ip]):
                
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
                        b = im.mem[b]
                        lval(im.ip+1, b)
                        im.ip += 3

                case 16:
                    a = rval(im.ip+1)
                    b = rval(im.ip+2)
                    if not ((a is None) or (b is None)):
                        im.mem[a] = b
                        im.ip += 3

                case 17:
                    a = rval(im.ip+1)
                    if (a is not None):
                        im.stack.append(im.ip+2)
                        im.ip = a

                case 18:
                    if im.stack:
                        a = im.stack.pop()
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
                            if s.startswith(':'):
                                self.handle_vm_command(s)
                                return
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

        if im.ip >= mb:
            self.s_halt = True
        self.printer.flush()

    def reset(self):
        self.image.reset()

    def handle_vm_command(self, command):
        op,*args = command.split()
        match op.lower():
            case ':help':
                usage = """VM commands
:dump [file]
        dump memory to file
:reset
        reload the machine
:save [file]
        save state
:load [file]
        load save
:quit
        exit the session
:help
        this help
""".rstrip('\n')
                print(usage, file=sys.stderr)
            case ':dump':
                fn = args[0] if args else 'dump.bin'
                with open(fn, 'wb') as fp:
                    self.image.dump_mem(fp)
                    print(f'\n{fn!r} dumped', file=sys.stderr)
            case ':quit':
                self.s_halt = True
            case ':reset':
                self.reset()
            case ':save':
                fn = args[0] if args else 'save000'
                fn = pathlib.Path('saves') / fn
                fn.parent.mkdir(parents=True, exist_ok=True)
                with open(fn, 'wb') as fp:
                    self.image.write(fp)
                    print(f'\n{fn!s} saved', file=sys.stderr)
            case ':load':
                fn = args[0] if args else 'save000'
                fn = pathlib.Path('saves') / fn
                if fn.is_file():
                    with open(fn, 'rb') as fp:
                        self.image = MachineImage.load(fp)
                    print(f'\n{fn!s} loaded', file=sys.stderr)
                else:
                    print(f'\n{fn!s} not found', file=sys.stderr)
            case _:
                self.handle_vm_command(':help')


def vm_load(fp):
    raw = fp.read()
    image = MachineImage(raw)
    vm = Machine(image)
    return vm


def vm_disasm(image, addr=None):
    if addr is None:
        addr = image.ip
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

    match (op := mem[ip]):
        case 0:
            return 'halt'
        case 1:
            a,b = lval(ip+1), rval(ip+2)
            return f'set {a} {b}'
        case 2:
            a = rval(ip+1)
            return f'push {a}'
        case 3:
            a = lval(ip+1)
            return f'pop {a}'
        case 4:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'eq {a} {b} {c}'
        case 5:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'gt {a} {b} {c}'
        case 6:
            a = lval(ip+1)
            return f'jmp {a}'
        case 7:
            a,b = rval(ip+1), lval(ip+2)
            return f'jt {a} {b}'
        case 8:
            a,b = rval(ip+1), lval(ip+2)
            return f'jf {a} {b}'
        case 9:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'add {a} {b} {c}'
        case 10:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'mult {a} {b} {c}'
        case 11:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'mod {a} {b} {c}'
        case 12:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'and {a} {b} {c}'
        case 13:
            a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
            return f'or {a} {b} {c}'
        case 14:
            a,b = lval(ip+1), rval(ip+2)
            return f'not {a} {b}'
        case 15:
            a,b = lval(ip+1), lval(ip+2)
            return f'rmem {a} {b}'
        case 16:
            a,b = lval(ip+1), rval(ip+2)
            return f'wmem {a} {b}'
        case 17:
            a = lval(ip+1)
            return f'call {a}'
        case 18:
            return 'ret'
        case 19:
            a = rval(ip+1)
            return f'out {a}'
        case 20:
            a = lval(ip+1)
            return f'in {a}'
        case 21:
            return 'noop'
        case _:
            raise Exception((f'{ip:04x}: {op:02x}'))
    

def main(image, disasm):
    with open(image, 'rb') as fp:
        vm = vm_load(fp)
    vm.is_disassemble = disasm
    while not vm.is_halted:
        vm.run()


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('image', type=pathlib.Path, help='binary image of the challenge virtual machine')
    parser.add_argument('-d', '--disassemble', action='store_true')
    args = parser.parse_args()
    main(image=args.image, disasm=args.disassemble)