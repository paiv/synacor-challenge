#!/usr/bin/env python
import json
import pathlib
import struct
import sys


class MachineImage:
    def __init__(self, raw):
        n = len(raw) // 2
        self.mem = struct.unpack(f'<{n}h', raw)
        self.reg = [0] * 8
        self.stack = list()
        self.ip = 0
        self.in_queue = list()


class DisBufferedText:
    def __init__(self, op, size, printer):
        self.op = op
        self.size = size
        self.printer = printer
        self.ip = None
        self.out = None
        self.last = None
        self._hexdigits = set('0123456789abcdefABCDEF')
        
    def print(self, ip, x):
        if isinstance(x, str) and all(c in self._hexdigits for c in x):
            x = int(x, 16)
        if isinstance(x, int):
            if (32 <= x < 127 or x == 10):
                if self.out is None:
                    self.ip = ip
                    self.last = ip
                    self.out = chr(x)
                elif self.last + self.size == ip:
                    self.last = ip
                    self.out += chr(x)
                else:
                    s = json.dumps(self.out)
                    self.printer(self.ip, f'{self.op} {s}')
                    self.out = chr(x)
                    self.ip = ip
                    self.last = ip
                return
            else:
                x = f'{x:04x}'
        if self.out:
            s = json.dumps(self.out)
            self.printer(self.ip, f'{self.op} {s}')
        if x is not None:
            self.printer(ip, f'{self.op} {x}')
        self.out = None

    def flush(self):
        self.print(0, None)


def vm_disasm(image, addr=None, raw_range=None):
    if addr is None:
        addr = image.ip
        
    so = list()
    def dis_append(ip, s):
        so.append(f'{ip:04x}: {s}')
    
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

    group_out = DisBufferedText('out', 2, dis_append)
    group_dw = DisBufferedText('dw', 1, dis_append)
    
    while ip < len(mem):
        op = mem[ip]
        if op != 19:
            group_out.flush()
        if raw_range and ip in raw_range:
            group_dw.print(ip, op)
            ip += 1
            continue
        if op < 22:
            group_dw.flush()
        
        match op:
            case 0:
                dis_append(ip, 'halt')
                ip += 1
            case 1:
                a,b = lval(ip+1), rval(ip+2)
                dis_append(ip, f'set {a} {b}')
                ip += 3
            case 2:
                a = rval(ip+1)
                dis_append(ip, f'push {a}')
                ip += 2
            case 3:
                a = lval(ip+1)
                dis_append(ip, f'pop {a}')
                ip += 2
            case 4:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'eq {a} {b} {c}')
                ip += 4
            case 5:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'gt {a} {b} {c}')
                ip += 4
            case 6:
                a = lval(ip+1)
                dis_append(ip, f'jmp {a}')
                ip += 2
            case 7:
                a,b = rval(ip+1), lval(ip+2)
                dis_append(ip, f'jt {a} {b}')
                ip += 3
            case 8:
                a,b = rval(ip+1), lval(ip+2)
                dis_append(ip, f'jf {a} {b}')
                ip += 3
            case 9:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'add {a} {b} {c}')
                ip += 4
            case 10:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'mult {a} {b} {c}')
                ip += 4
            case 11:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'mod {a} {b} {c}')
                ip += 4
            case 12:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'and {a} {b} {c}')
                ip += 4
            case 13:
                a,b,c = lval(ip+1), rval(ip+2), rval(ip+3)
                dis_append(ip, f'or {a} {b} {c}')
                ip += 4
            case 14:
                a,b = lval(ip+1), rval(ip+2)
                dis_append(ip, f'not {a} {b}')
                ip += 3
            case 15:
                a,b = lval(ip+1), lval(ip+2)
                dis_append(ip, f'rmem {a} {b}')
                ip += 3
            case 16:
                a,b = lval(ip+1), rval(ip+2)
                dis_append(ip, f'wmem {a} {b}')
                ip += 3
            case 17:
                a = lval(ip+1)
                dis_append(ip, f'call {a}')
                ip += 2
            case 18:
                dis_append(ip, 'ret')
                ip += 1
            case 19:
                a = rval(ip+1)
                group_out.print(ip, a)
                ip += 2
            case 20:
                a = lval(ip+1)
                dis_append(ip, f'in {a}')
                ip += 2
            case 21:
                dis_append(ip, 'noop')
                ip += 1
            case _:
                group_dw.print(ip, op)
                ip += 1
    group_out.flush()
    group_dw.flush()
    return '\n'.join(so)


def main(image, keep_raw):
    if keep_raw:
        keep_raw = range(*(int(x,0) for x in keep_raw))
    with open(image, 'rb') as fp:
        raw = fp.read()
    image = MachineImage(raw)
    s = vm_disasm(image, raw_range=keep_raw)
    print(s)


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('image', type=pathlib.Path, help='binary image of the challenge virtual machine')
    parser.add_argument('-r', '--raw-range', metavar='A', nargs=2, help='keep raw data in the range')
    args = parser.parse_args()
    main(image=args.image, keep_raw=args.raw_range)