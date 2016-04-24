Solving Synacor Challenge
=========================

The game: https://challenge.synacor.com/

My notes on it: https://paiv.github.io/blog/2016/04/24/synacor-challenge.html


SPOILER ALERT
-------------

Reading this repository before completing the game will take from you the deep satisfaction from solving hard problems.


The Code
--------

* vm - virtual machine
* ida - disassembler
* mapper - graph the dungeon
* play - save and restore, debugger shell
* solvers


Building
--------

```shell
mkdir build && cd build
cmake ../code/src/
make
```

Run the game debugger:

```
play/synacor challenge.bin
```


Debugger commands
-----------------

Arguments should be in hex, without base prefix (`1ee7`)

Everything not in this list is passed to the game.

* save - saves game state
* load, restore [fn] - restores from save
* restart, reset - resets to clean state
* di, dis, disassemble [addr] - disassemble current pointer, or memory
* reg, regs, registers - show registers
* s, si, step - step in
* c, cont - continue to run
* b, break [addr] - break on address
* clear [addr] - remove breakpoint on address
* fin, finish - step out (limited to first encountered return)
* m, mem, memory [addr [size]] - show memory dump
* stack - show stack
* write [addr|reg] [value] - write to memory or register
