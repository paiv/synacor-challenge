0000:    noop
0001:    noop
0002:    out     "Welcome to the Synacor Challenge!\nPlease record your progress by putting codes like\nthis one into the challenge website: XFbQaIRvFWcG\n\nExecuting self-test...\n\n"
0140:    jmp     0x15b
0142:    out     "jmp fails\n"
0156:    halt
0157:    noop
0158:    noop
0159:    noop
015A:    noop
015B:    noop
015C:    noop
015D:    noop
015E:    noop
015F:    noop
0160:    jmp     0x166
0162:    jmp     0x170
0164:    jmp     0x18d
0166:    jmp     0x1e4
0168:    jmp     0x1a8
016A:    jmp     0x1c5
016C:    noop
016D:    noop
016E:    noop
016F:    noop
0170:    out     "jmp lands -2\n"
018A:    halt
018B:    noop
018C:    noop
018D:    out     "jmp lands -1\n"
01A7:    halt
01A8:    noop
01A9:    noop
01AA:    out     "jmp lands +1\n"
01C4:    halt
01C5:    noop
01C6:    noop
01C7:    noop
01C8:    noop
01C9:    out     "jmp lands +2\n"
01E3:    halt
01E4:    jt      0, 0x432
01E7:    jf      1, 0x432
01EA:    jt      1, 0x1ef
01ED:    jmp     0x432
01EF:    jf      0, 0x1f4
01F2:    jmp     0x432
01F4:    jt      r0, 0x445
01F7:    jt      r1, 0x445
01FA:    jt      r2, 0x445
01FD:    jt      r3, 0x445
0200:    jt      r4, 0x445
0203:    jt      r5, 0x445
0206:    jt      r6, 0x445
0209:    jt      r7, 0x445
020C:    set     r0, 1
020F:    jf      r0, 0x45e
0212:    set     r0, 0
0215:    jt      r0, 0x45e
0218:    add     r0, 1, 1
021C:    jt      r0, 0x234
021F:    out     "no add op\n"
0233:    halt
0234:    eq      r1, r0, 2
0238:    jt      r1, 0x24e
023B:    out     "no eq op\n"
024D:    halt
024E:    push    r0
0250:    push    r1
0252:    pop     r0
0254:    pop     r1
0256:    eq      r2, r1, 2
025A:    jf      r2, 0x486
025D:    eq      r2, r0, 1
0261:    jf      r2, 0x486
0264:    gt      r2, r1, r0
0268:    jf      r2, 0x473
026B:    gt      r2, r0, r1
026F:    jt      r2, 0x473
0272:    gt      r2, 0x2a, 0x2a
0276:    jt      r2, 0x473
0279:    and     r0, 0x70f0, 0x4caa
027D:    eq      r1, r0, 0x40a0
0281:    jf      r1, 0x499
0284:    or      r1, 0x70f0, 0x4caa
0288:    eq      r0, r1, 0x7cfa
028C:    jt      r0, 0x2ac
028F:    out     "no bitwise or\n"
02AB:    halt
02AC:    not     r0, 0
02AF:    eq      r1, r0, 0x7fff
02B3:    jf      r1, 0x4b8
02B6:    not     r0, 0x5555
02B9:    eq      r1, r0, 0x2aaa
02BD:    jf      r1, 0x4b8
02C0:    call    0x505
02C2:    jmp     0x509
02C4:    pop     r0
02C6:    eq      r1, r0, 0x2c4
02CA:    jt      r1, 0x509
02CD:    eq      r1, r0, 0x2c2
02D1:    jf      r1, 0x509
02D4:    set     r0, 0x507
02D7:    call    r0
02D9:    jmp     0x509
02DB:    pop     r0
02DD:    eq      r1, r0, 0x2db
02E1:    jt      r1, 0x509
02E4:    eq      r1, r0, 0x2d9
02E8:    jf      r1, 0x509
02EB:    add     r0, 0x7fff, 0x7fff
02EF:    eq      r1, r0, 0x7ffe
02F3:    jf      r1, 0x520
02F6:    eq      r1, 0x7ffe, r0
02FA:    jf      r1, 0x520
02FD:    add     r0, 0x4000, 0x4000
0301:    jt      r0, 0x520
0304:    add     r0, 0x4000, 0x4000
0308:    jt      r0, 0x520
030B:    mult    r0, 6, 9
030F:    eq      r1, r0, 0x2a
0313:    jt      r1, 0x565
0316:    eq      r1, r0, 0x36
031A:    jf      r1, 0x586
031D:    mult    r0, 0x3039, 0x7d7b
0321:    eq      r1, r0, 0x63
0325:    jf      r1, 0x520
0328:    mod     r0, 6, 3
032C:    eq      r1, r0, 0
0330:    jf      r1, 0x59d
0333:    mod     r0, 0x46, 6
0337:    eq      r1, r0, 4
033B:    jf      r1, 0x59d
033E:    mult    r0, 0x7ffe, 15
0342:    eq      r1, r0, 0x7fe2
0346:    jf      r1, 0x520
0349:    jmp     0x34d
034B:    data    0x7530 0x2710 
034D:    rmem    r0, 0x34b
0350:    eq      r1, r0, 0x4e20
0354:    jf      r1, 0x4d7
0357:    add     r2, 0x34b, 1
035B:    rmem    r0, r2
035E:    eq      r1, r0, 0x2710
0362:    jf      r1, 0x4d7
0365:    set     r0, 0x34b
0368:    wmem    r0, 0x7530
036B:    rmem    r2, r0
036E:    eq      r1, r2, 0x7530
0372:    jf      r1, 0x4ee
0375:    call    0x6bb
0377:    rmem    r0, 0x17b4
037A:    eq      r1, r0, 11
037E:    jf      r1, 0x4d7
0381:    add     r2, 0x17b4, 1
0385:    rmem    r0, r2
0388:    eq      r1, r0, 0x74
038C:    jf      r1, 0x4d7
038F:    wmem    r2, 0x54
0392:    rmem    r0, r2
0395:    eq      r1, r0, 0x74
0399:    jt      r1, 0x4ee
039C:    eq      r1, r0, 0x54
03A0:    jf      r1, 0x4ee
03A3:    wmem    0x3a9, 0x15
03A6:    wmem    0x3aa, 7
03A9:    noop
03AA:    jt      0x13, 0x3d2
03AD:    out     "wmem opwrite fail\n"
03D1:    halt
03D2:    add     r1, 10, 0x17c0
03D6:    add     r1, r1, 1
03DA:    rmem    r2, 0x17e4
03DD:    add     r2, r2, 0x17e4
03E1:    set     r0, 0x17e4
03E4:    add     r0, r0, 1
03E8:    gt      r3, r0, r2
03EC:    jt      r3, 0x3ff
03EF:    rmem    r4, r0
03F2:    wmem    r1, r4
03F5:    add     r0, r0, 1
03F9:    add     r1, r1, 1
03FD:    jmp     0x3e8
03FF:    rmem    r0, 0x17c0
0402:    rmem    r1, 0x17d3
0405:    add     r0, r0, r1
0409:    add     r0, r0, 1
040D:    wmem    0x17c0, r0
0410:    wmem    0x17d3, 0x2c
0413:    set     r0, 0x17c0
0416:    call    0x5ee
0418:    push    r0
041A:    push    r1
041C:    push    r2
041E:    set     r0, 0x68e3
0421:    set     r1, 0x5fb
0424:    add     r2, 0xa2e, 0x2ad0
0428:    call    0x5b2
042A:    pop     r2
042C:    pop     r1
042E:    pop     r0
0430:    jmp     0xaae
0432:    out     "no jt/jf\n"
0444:    halt
0445:    out     "nonzero reg\n"
045D:    halt
045E:    out     "no set op\n"
0472:    halt
0473:    out     "no gt op\n"
0485:    halt
0486:    out     "no stack\n"
0498:    halt
0499:    out     "no bitwise and\n"
04B7:    halt
04B8:    out     "no bitwise not\n"
04D6:    halt
04D7:    out     "no rmem op\n"
04ED:    halt
04EE:    out     "no wmem op\n"
0504:    halt
0505:    jmp     0x2c4
0507:    jmp     0x2db
0509:    out     "no call op\n"
051F:    halt
0520:    out     "no modulo math during add or mult\n"
0564:    halt
0565:    out     "not hitchhiking\n"
0585:    halt
0586:    out     "no mult op\n"
059C:    halt
059D:    out     "no mod op\n"
05B1:    halt
05B2:    push    r0
05B4:    push    r3
05B6:    push    r4
05B8:    push    r5
05BA:    push    r6
05BC:    set     r6, r0
05BF:    set     r5, r1
05C2:    rmem    r4, r0
05C5:    set     r1, 0
05C8:    add     r3, 1, r1
05CC:    gt      r0, r3, r4
05D0:    jt      r0, 0x5e3
05D3:    add     r3, r3, r6
05D7:    rmem    r0, r3
05DA:    call    r5
05DC:    add     r1, r1, 1
05E0:    jt      r1, 0x5c8
05E3:    pop     r6
05E5:    pop     r5
05E7:    pop     r4
05E9:    pop     r3
05EB:    pop     r0
05ED:    ret 
05EE:    push    r1
05F0:    set     r1, 0x5f8
05F3:    call    0x5b2
05F5:    pop     r1
05F7:    ret 
05F8:    out     " "
05FA:    ret 
05FB:    push    r1
05FD:    set     r1, r2
0600:    call    0x84d
0602:    out     " "
0604:    pop     r1
0606:    ret 
0607:    push    r1
0609:    push    r3
060B:    rmem    r3, r0
060E:    jf      r3, 0x61b
0611:    call    0x5b2
0613:    jt      r1, 0x61b
0616:    set     r0, r2
0619:    jmp     0x61e
061B:    set     r0, 0x7fff
061E:    pop     r3
0620:    pop     r1
0622:    ret 
0623:    push    r1
0625:    push    r2
0627:    set     r2, r1
062A:    set     r1, 0x645
062D:    call    0x607
062F:    pop     r2
0631:    pop     r1
0633:    ret 
0634:    push    r1
0636:    push    r2
0638:    set     r2, r1
063B:    set     r1, 0x670
063E:    call    0x607
0640:    pop     r2
0642:    pop     r1
0644:    ret 
0645:    eq      r0, r0, r2
0649:    jf      r0, 0x652
064C:    set     r2, r1
064F:    set     r1, 0x7fff
0652:    ret 
0653:    push    r3
0655:    add     r3, r2, 1
0659:    add     r3, r3, r1
065D:    rmem    r3, r3
0660:    eq      r3, r0, r3
0664:    jt      r3, 0x66d
0667:    set     r2, r1
066A:    set     r1, 0x7fff
066D:    pop     r3
066F:    ret 
0670:    push    r1
0672:    set     r1, r2
0675:    call    0x683
0677:    pop     r1
0679:    jf      r0, 0x682
067C:    set     r2, r1
067F:    set     r1, 0x7fff
0682:    ret 
0683:    push    r1
0685:    push    r2
0687:    push    r3
0689:    push    r4
068B:    rmem    r3, r0
068E:    rmem    r4, r1
0691:    eq      r2, r3, r4
0695:    jf      r2, 0x6af
0698:    or      r2, r3, r4
069C:    jf      r2, 0x6aa
069F:    set     r2, r1
06A2:    set     r1, 0x653
06A5:    call    0x5b2
06A7:    jf      r1, 0x6af
06AA:    set     r0, 1
06AD:    jmp     0x6b2
06AF:    set     r0, 0
06B2:    pop     r4
06B4:    pop     r3
06B6:    pop     r2
06B8:    pop     r1
06BA:    ret 
06BB:    push    r0
06BD:    push    r1
06BF:    set     r1, 0x17b4
06C2:    rmem    r0, r1
06C5:    push    r1
06C7:    mult    r1, r1, r1
06CB:    call    0x84d
06CD:    set     r1, 0x4154
06D0:    call    0x84d
06D2:    pop     r1
06D4:    wmem    r1, r0
06D7:    add     r1, r1, 1
06DB:    eq      r0, 0x7562, r1
06DF:    jf      r0, 0x6c2
06E2:    pop     r1
06E4:    pop     r0
06E6:    ret 
06E7:    push    r0
06E9:    push    r2
06EB:    push    r3
06ED:    push    r4
06EF:    push    r5
06F1:    add     r2, r1, r0
06F5:    set     r0, r1
06F8:    set     r5, 0
06FB:    add     r0, r0, 1
06FF:    gt      r3, r0, r2
0703:    jt      r3, 0x718
0706:    in      r4
0708:    eq      r3, r4, 10
070C:    jt      r3, 0x718
070F:    wmem    r0, r4
0712:    add     r5, r5, 1
0716:    jmp     0x6fb
0718:    wmem    r1, r5
071B:    eq      r3, r4, 10
071F:    jt      r3, 0x726
0722:    in      r4
0724:    jmp     0x71b
0726:    pop     r5
0728:    pop     r4
072A:    pop     r3
072C:    pop     r2
072E:    pop     r0
0730:    ret 
0731:    push    r3
0733:    push    r4
0735:    push    r5
0737:    push    r6
0739:    set     r6, 1
073C:    add     r4, r3, r6
0740:    rmem    r4, r4
0743:    add     r5, 0x17ed, r6
0747:    wmem    r5, r4
074A:    add     r6, r6, 1
074E:    rmem    r5, 0x17ed
0751:    gt      r4, r6, r5
0755:    jf      r4, 0x73c
0758:    set     r3, 0
075B:    set     r4, 0
075E:    rmem    r5, 0x17ed
0761:    mod     r5, r4, r5
0765:    add     r5, r5, 0x17ed
0769:    add     r5, r5, 1
076D:    rmem    r6, r5
0770:    mult    r6, r6, 0x1481
0774:    add     r6, r6, 0x3039
0778:    wmem    r5, r6
077B:    push    r0
077D:    push    r1
077F:    set     r1, r6
0782:    call    0x84d
0784:    set     r6, r0
0787:    pop     r1
0789:    pop     r0
078B:    rmem    r5, r1
078E:    mod     r6, r6, r5
0792:    add     r6, r6, 1
0796:    gt      r5, r6, r2
079A:    jt      r5, 0x7a0
079D:    set     r3, 1
07A0:    add     r6, r6, r1
07A4:    rmem    r6, r6
07A7:    add     r4, r4, 1
07AB:    add     r5, r4, 0x17f1
07AF:    wmem    r5, r6
07B2:    rmem    r5, 0x17f1
07B5:    eq      r5, r4, r5
07B9:    jf      r5, 0x75e
07BC:    jf      r3, 0x758
07BF:    push    r0
07C1:    set     r0, 0x17f1
07C4:    call    0x5ee
07C6:    pop     r0
07C8:    pop     r6
07CA:    pop     r5
07CC:    pop     r4
07CE:    pop     r3
07D0:    ret 
07D1:    push    r0
07D3:    push    r1
07D5:    push    r2
07D7:    push    r3
07D9:    push    r4
07DB:    push    r5
07DD:    set     r2, 1
07E0:    set     r5, 0
07E3:    jf      r0, 0x82c
07E6:    eq      r4, r2, 0x2710
07EA:    set     r3, r0
07ED:    jt      r4, 0x7f8
07F0:    mult    r1, r2, 10
07F4:    mod     r3, r0, r1
07F8:    set     r4, 0
07FB:    mult    r2, r2, 0x7fff
07FF:    jf      r3, 0x80c
0802:    add     r4, r4, 1
0806:    add     r3, r3, r2
080A:    jmp     0x7ff
080C:    mult    r2, r2, 0x7fff
0810:    mult    r3, r4, r2
0814:    mult    r3, r3, 0x7fff
0818:    add     r0, r0, r3
081C:    add     r4, r4, 0x30
0820:    mult    r2, r2, 10
0824:    add     r5, r5, 1
0828:    push    r4
082A:    jmp     0x7e3
082C:    jt      r5, 0x833
082F:    out     "0"
0831:    jmp     0x840
0833:    jf      r5, 0x840
0836:    pop     r0
0838:    out     " "
083A:    add     r5, r5, 0x7fff
083E:    jmp     0x833
0840:    pop     r5
0842:    pop     r4
0844:    pop     r3
0846:    pop     r2
0848:    pop     r1
084A:    pop     r0
084C:    ret 
084D:    push    r1
084F:    push    r2
0851:    and     r2, r0, r1
0855:    not     r2, r2
0858:    or      r0, r0, r1
085C:    and     r0, r0, r2
0860:    pop     r2
0862:    pop     r1
0864:    ret 
0865:    add     r0, r0, r1
0869:    gt      r1, r1, r0
086D:    ret 
086E:    push    r2
0870:    gt      r2, r1, r0
0874:    mult    r1, r1, 0x7fff
0878:    add     r0, r0, r1
087C:    set     r1, r2
087F:    pop     r2
0881:    ret 
0882:    jf      r0, 0x8c1
0885:    jf      r1, 0x8c1
0888:    push    r2
088A:    push    r3
088C:    gt      r2, r1, r0
0890:    jt      r2, 0x89c
0893:    set     r2, r0
0896:    set     r0, r1
0899:    set     r1, r2
089C:    set     r2, r0
089F:    set     r0, 0
08A2:    add     r0, r0, r1
08A6:    gt      r3, r1, r0
08AA:    jt      r3, 0x8b9
08AD:    add     r2, r2, 0x7fff
08B1:    jt      r2, 0x8a2
08B4:    set     r1, 0
08B7:    jmp     0x8bc
08B9:    set     r1, 1
08BC:    pop     r3
08BE:    pop     r2
08C0:    ret 
08C1:    set     r0, 0
08C4:    set     r1, 0
08C7:    ret 
08C8:    push    r1
08CA:    push    r2
08CC:    jf      r1, 0x8e4
08CF:    add     r1, r1, 0x7fff
08D3:    and     r2, r0, 0x4000
08D7:    mult    r0, r0, 2
08DB:    jf      r2, 0x8cc
08DE:    or      r0, r0, 1
08E2:    jmp     0x8cc
08E4:    pop     r2
08E6:    pop     r1
08E8:    ret 
08E9:    push    r1
08EB:    gt      r1, r0, 14
08EF:    jt      r1, 0x905
08F2:    set     r1, r0
08F5:    set     r0, 1
08F8:    jf      r1, 0x908
08FB:    add     r1, r1, 0x7fff
08FF:    mult    r0, r0, 2
0903:    jmp     0x8f8
0905:    set     r0, 0x7fff
0908:    pop     r1
090A:    ret 
090B:    jmp     0xaae
090D:    data    0x17fe 0x1808 0x6914 0x6917 
0911:    halt
0912:    data    0x18ce 0x18d8 0x691a 0x691c 
0916:    halt
0917:    data    0x1929 0x1933 0x691e 0x6921 
091B:    halt
091C:    data    0x19c5 0x19cf 0x6924 0x6927 
0920:    halt
0921:    data    0x1a37 0x1a41 0x692a 0x692d 
0925:    halt
0926:    data    0x1b0a 0x1b16 0x6930 0x6933 
092A:    halt
092B:    data    0x1b9e 0x1bb7 0x6936 0x6938 
092F:    halt
0930:    data    0x1c66 0x1c72 0x693a 0x693d 
0934:    halt
0935:    data    0x1d4e 0x1d5a 0x6940 0x6942 
0939:    halt
093A:    data    0x1dc0 0x1dcc 0x6944 0x6947 
093E:    halt
093F:    data    0x1e77 0x1e7f 0x694a 0x694e 
0943:    halt
0944:    data    0x1f47 0x6952 0x6955 0x6958 
0948:    halt
0949:    data    0x1fe3 0x1ff3 0x695b 0x6961 0xe9e 0x208c 0x209c 0x6967 0x696b 0xea2 0x20e5 0x20f5 0x696f 0x6973 0xeac 0x213e 
0959:    data    0x214e 0x6977 0x697c 0xeb6 0x21e1 0x21f1 0x6981 0x6985 0xec0 0x223a 0x224a 0x6989 0x698e 0xeca 0x22e4 0x22f4 
0969:    data    0x6993 0x6997 0xed4 0x233d 0x234d 0x699b 0x699d 0xede 0x238a 0x239a 0x699f 0x69a1 
0975:    halt
0976:    data    0x23d7 0x23e7 0x69a3 0x69a6 0xe48 0x242b 0x2438 0x69a9 0x69ac 0xe48 0x24b5 0x24c2 0x69af 0x69b2 0xe48 0x24ef 
0986:    data    0x24fc 0x69b5 0x69b8 0xe48 0x2529 0x2536 0x69bb 0x69be 0xe48 0x25a5 0x25ab 0x69c1 0x69c4 
0993:    halt
0994:    data    0x26af 0x26b5 0x69c7 0x69ca 
0998:    halt
0999:    data    0x2777 0x277d 0x69cd 0x69d2 
099D:    halt
099E:    halt
099F:    data    0x28b9 0x28bf 0x69e3 0x69e5 0xf35 0x296d 0x2973 0x69e7 0x69ea 
09A8:    halt
09A9:    data    0x2a08 0x2a0e 0x69ed 0x69ef 
09AD:    halt
09AE:    data    0x2a8c 0x2a92 0x69f1 0x69f4 
09B2:    halt
09B3:    data    0x2b4e 0x2b54 0x69f7 0x69f9 
09B7:    halt
09B8:    data    0x2c03 0x2c18 0x69fb 0x69fd 
09BC:    halt
09BD:    data    0x2d20 0x2d35 0x69ff 0x6a01 
09C1:    halt
09C2:    data    0x2dce 0x2dd4 0x6a03 0x6a07 
09C6:    halt
09C7:    data    0x2e8f 0x2e95 0x6a0b 0x6a0e 
09CB:    halt
09CC:    data    0x2fa7 0x2fad 0x6a11 0x6a14 
09D0:    halt
09D1:    data    0x30ab 0x30bb 0x6a17 0x6a1b 
09D5:    halt
09D6:    data    0x3193 0x31a3 0x6a1f 0x6a23 
09DA:    halt
09DB:    data    0x322f 0x323f 0x6a27 0x6a2a 
09DF:    halt
09E0:    data    0x3332 0x3342 0x6a2d 0x6a30 
09E4:    halt
09E5:    data    0x346c 0x347c 0x6a33 0x6a36 
09E9:    halt
09EA:    data    0x357e 0x358c 0x6a39 0x6a3c 
09EE:    halt
09EF:    data    0x3675 0x3683 0x6a3f 0x6a42 
09F3:    halt
09F4:    data    0x370a 0x3718 0x6a45 0x6a49 
09F8:    halt
09F9:    data    0x386c 0x3881 0x6a4d 0x6a4f 
09FD:    halt
09FE:    data    0x392a 0x3938 0x6a51 0x6a54 0x1203 0x39ad 0x39b8 0x6a57 0x6a5a 0xf76 0x3a44 0x3a4f 0x6a5d 0x6a61 0xf87 0x3ae2 
0A0E:    data    0x3aed 0x6a65 0x6a69 0xf98 0x3b7e 0x3b89 0x6a6d 0x6a71 0xfa9 0x3c91 0x3c9c 0x6a75 0x6a79 0xfbc 0x3d30 0x3d3b 
0A1E:    data    0x6a7d 0x6a82 0xfcd 0x3dd2 0x3ddd 0x6a87 0x6a8c 0xfde 0x3e77 0x3e82 0x6a91 0x6a95 0xfef 0x3f14 0x3f1f 0x6a99 
0A2E:    data    0x6a9d 0x1000 0x3fb1 0x3fbc 0x6aa1 0x6aa6 0x1011 0x4055 0x4060 0x6aab 0x6ab0 0x1022 0x40f7 0x4102 0x6ab5 0x6ab9 
0A3E:    data    0x1033 0x4197 0x41a9 0x6abd 0x6ac1 0x1044 0x424b 0x4256 0x6ac5 0x6ac9 0x1047 0x42e7 0x42f2 0x6acd 0x6ad1 0x1058 
0A4E:    data    0x4385 0x4390 0x6ad5 0x6ad8 0x1069 0x441c 0x4422 0x6adb 0x6add 0x1252 0x44fd 0x451d 0x6adf 0x6ae2 
0A5C:    halt
0A5D:    data    0x458e 0x45ae 0x6ae5 0x6ae8 
0A61:    halt
0A62:    data    0x461d 0x462f 0x6aeb 0x6aef 
0A66:    halt
0A67:    data    0x4687 0x468d 0x6af3 0x6af4 0xe75 0x468e 0x4695 0x90d 0x1270 0x471e 0x472c 0x935 
0A73:    halt
0A74:    data    0x47a8 0x47b0 0x7fff 0x1315 0x4824 0x4830 0x7fff 0x1343 0x4888 0x488c 0x971 0x12bf 0x48ba 0x48c3 0x994 0x14f0 
0A84:    data    0x4903 0x4911 0x9a9 0x1501 0x4951 0x495c 0x9b3 0x1512 0x49a4 0x49b1 0x9a4 0x1523 0x4a09 0x4a13 0x9ae 0x1534 
0A94:    data    0x4a55 0x4a60 0x99f 0x1545 0x4aa9 0x4ab7 0x9b8 
0A9B:    halt
0A9C:    data    0x4af8 0x4afc 0xa3f 
0A9F:    halt
0AA0:    data    0x4b3a 0x4b41 0xa53 0x1659 0x4bb8 0x4bc5 0x9b8 
0AA7:    halt
0AA8:    data    0x564d 0x5655 0x9f9 
0AAB:    halt
0AAC:    data    0x90d 0x90d 
0AAE:    push    r0
0AB0:    push    r1
0AB2:    push    r2
0AB4:    push    r3
0AB6:    rmem    r1, 0xaac
0AB9:    rmem    r0, 0xaad
0ABC:    eq      r0, r0, r1
0AC0:    jt      r0, 0xad2
0AC3:    rmem    r0, 0xaac
0AC6:    add     r0, r0, 4
0ACA:    rmem    r0, r0
0ACD:    jf      r0, 0xad2
0AD0:    call    r0
0AD2:    rmem    r1, 0xaac
0AD5:    rmem    r0, 0xaad
0AD8:    eq      r0, r0, r1
0ADC:    jt      r0, 0xae7
0ADF:    set     r0, 0x6576
0AE2:    wmem    r0, 0
0AE5:    call    0xb94
0AE7:    wmem    0xaad, r1
0AEA:    push    r0
0AEC:    push    r1
0AEE:    push    r2
0AF0:    set     r0, 0x6b16
0AF3:    set     r1, 0x5fb
0AF6:    add     r2, 0xbf0, 1
0AFA:    call    0x5b2
0AFC:    pop     r2
0AFE:    pop     r1
0B00:    pop     r0
0B02:    set     r0, 0x20
0B05:    set     r1, 0x6576
0B08:    call    0x6e7
0B0A:    out     "\n\n"
0B0E:    set     r0, 0x6576
0B11:    set     r1, 0x20
0B14:    call    0x623
0B16:    eq      r1, r0, 0x7fff
0B1A:    jf      r1, 0xb20
0B1D:    rmem    r0, 0x6576
0B20:    set     r2, r0
0B23:    rmem    r1, 0x6576
0B26:    push    r1
0B28:    wmem    0x6576, r2
0B2B:    set     r0, 0x6b06
0B2E:    set     r1, 0x6576
0B31:    call    0x634
0B33:    pop     r1
0B35:    wmem    0x6576, r1
0B38:    eq      r1, r0, 0x7fff
0B3C:    jf      r1, 0xb45
0B3F:    set     r0, 0
0B42:    set     r2, 0
0B45:    add     r1, 0x6b0e, 1
0B49:    add     r1, r1, r0
0B4D:    rmem    r1, r1
0B50:    rmem    r3, 0x6576
0B53:    eq      r3, r3, r2
0B57:    jt      r3, 0xb80
0B5A:    mult    r0, r2, 0x7fff
0B5E:    rmem    r3, 0x6576
0B61:    add     r3, r0, r3
0B65:    jf      r2, 0xb6c
0B68:    add     r3, r3, 0x7fff
0B6C:    mod     r3, r3, 0x20
0B70:    add     r0, 0x6576, r2
0B74:    jf      r2, 0xb7b
0B77:    add     r0, r0, 1
0B7B:    wmem    r0, r3
0B7E:    jmp     0xb86
0B80:    set     r0, 0x6576
0B83:    wmem    r0, 0
0B86:    call    r1
0B88:    jt      r1, 0xab6
0B8B:    pop     r3
0B8D:    pop     r2
0B8F:    pop     r1
0B91:    pop     r0
0B93:    ret 
0B94:    push    r0
0B96:    push    r1
0B98:    push    r2
0B9A:    rmem    r1, r0
0B9D:    jf      r1, 0xbd8
0BA0:    call    0x1721
0BA2:    jf      r0, 0xbbe
0BA5:    push    r0
0BA7:    call    0x1766
0BA9:    set     r1, r0
0BAC:    pop     r0
0BAE:    jf      r1, 0xbbe
0BB1:    add     r1, r0, 1
0BB5:    rmem    r0, r1
0BB8:    call    0x5ee
0BBA:    out     "\n"
0BBC:    jmp     0xca6
0BBE:    push    r0
0BC0:    push    r1
0BC2:    push    r2
0BC4:    set     r0, 0x6b28
0BC7:    set     r1, 0x5fb
0BCA:    add     r2, 0x7c9, 0x49e
0BCE:    call    0x5b2
0BD0:    pop     r2
0BD2:    pop     r1
0BD4:    pop     r0
0BD6:    jmp     0xca6
0BD8:    rmem    r0, 0xaac
0BDB:    push    r0
0BDD:    out     "== "
0BE3:    add     r0, r0, 0
0BE7:    rmem    r0, r0
0BEA:    call    0x5ee
0BEC:    out     " ==\n"
0BF4:    pop     r0
0BF6:    push    r0
0BF8:    add     r0, r0, 1
0BFC:    rmem    r0, r0
0BFF:    rmem    r1, r0
0C02:    eq      r1, r1, 2
0C06:    jf      r1, 0xc20
0C09:    push    r0
0C0B:    set     r0, 0xa78
0C0E:    call    0x1766
0C10:    set     r1, r0
0C13:    pop     r0
0C15:    add     r0, r0, 1
0C19:    add     r0, r0, r1
0C1D:    rmem    r0, r0
0C20:    call    0x5ee
0C22:    out     "\n"
0C24:    pop     r0
0C26:    push    r0
0C28:    call    0x16bf
0C2A:    jf      r0, 0xc4a
0C2D:    push    r0
0C2F:    push    r1
0C31:    push    r2
0C33:    set     r0, 0x6b3f
0C36:    set     r1, 0x5fb
0C39:    add     r2, 0x149f, 0x245c
0C3D:    call    0x5b2
0C3F:    pop     r2
0C41:    pop     r1
0C43:    pop     r0
0C45:    rmem    r2, 0xaac
0C48:    call    0x16f4
0C4A:    pop     r0
0C4C:    push    r0
0C4E:    add     r0, r0, 2
0C52:    rmem    r0, r0
0C55:    rmem    r0, r0
0C58:    eq      r2, r0, 1
0C5C:    out     "\nThere "
0C6A:    jt      r2, 0xc75
0C6D:    out     "are"
0C73:    jmp     0xc79
0C75:    out     "is "
0C7B:    call    0x7d1
0C7D:    out     " exit"
0C87:    eq      r2, r0, 1
0C8B:    jt      r2, 0xc90
0C8E:    out     "s:\n"
0C94:    pop     r0
0C96:    push    r0
0C98:    add     r0, r0, 2
0C9C:    rmem    r0, r0
0C9F:    set     r1, 0x16b6
0CA2:    call    0x5b2
0CA4:    pop     r0
0CA6:    pop     r2
0CA8:    pop     r1
0CAA:    pop     r0
0CAC:    ret 
0CAD:    push    r0
0CAF:    push    r1
0CB1:    push    r2
0CB3:    set     r1, r0
0CB6:    rmem    r0, 0xaac
0CB9:    add     r0, r0, 2
0CBD:    rmem    r0, r0
0CC0:    call    0x634
0CC2:    eq      r2, r0, 0x7fff
0CC6:    jt      r2, 0xce6
0CC9:    rmem    r2, 0xaac
0CCC:    add     r2, r2, 3
0CD0:    rmem    r2, r2
0CD3:    add     r2, r2, 1
0CD7:    add     r2, r2, r0
0CDB:    rmem    r2, r2
0CDE:    wmem    0xaac, r2
0CE1:    wmem    0xaad, 0
0CE4:    jmp     0xcfe
0CE6:    push    r0
0CE8:    push    r1
0CEA:    push    r2
0CEC:    set     r0, 0x6b5a
0CEF:    set     r1, 0x5fb
0CF2:    add     r2, 0x2fbd, 0x3e2e
0CF6:    call    0x5b2
0CF8:    pop     r2
0CFA:    pop     r1
0CFC:    pop     r0
0CFE:    pop     r2
0D00:    pop     r1
0D02:    pop     r0
0D04:    ret 
0D05:    push    r0
0D07:    push    r0
0D09:    push    r1
0D0B:    push    r2
0D0D:    set     r0, 0x6b8c
0D10:    set     r1, 0x5fb
0D13:    add     r2, 0x35e, 0x399a
0D17:    call    0x5b2
0D19:    pop     r2
0D1B:    pop     r1
0D1D:    pop     r0
0D1F:    pop     r0
0D21:    ret 
0D22:    push    r0
0D24:    push    r2
0D26:    push    r0
0D28:    push    r1
0D2A:    push    r2
0D2C:    set     r0, 0x6d85
0D2F:    set     r1, 0x5fb
0D32:    add     r2, 0x939, 0x6b40
0D36:    call    0x5b2
0D38:    pop     r2
0D3A:    pop     r1
0D3C:    pop     r0
0D3E:    set     r2, 0
0D41:    call    0x16f4
0D43:    pop     r2
0D45:    pop     r0
0D47:    ret 
0D48:    push    r0
0D4A:    push    r1
0D4C:    push    r2
0D4E:    call    0x1721
0D50:    jf      r0, 0xd81
0D53:    add     r1, r0, 2
0D57:    rmem    r0, r1
0D5A:    rmem    r2, 0xaac
0D5D:    eq      r2, r0, r2
0D61:    jf      r2, 0xd81
0D64:    wmem    r1, 0
0D67:    push    r0
0D69:    push    r1
0D6B:    push    r2
0D6D:    set     r0, 0x6d96
0D70:    set     r1, 0x5fb
0D73:    add     r2, 0x16bb, 0x592b
0D77:    call    0x5b2
0D79:    pop     r2
0D7B:    pop     r1
0D7D:    pop     r0
0D7F:    jmp     0xd99
0D81:    push    r0
0D83:    push    r1
0D85:    push    r2
0D87:    set     r0, 0x6d9e
0D8A:    set     r1, 0x5fb
0D8D:    add     r2, 0x1b53, 0x2ca0
0D91:    call    0x5b2
0D93:    pop     r2
0D95:    pop     r1
0D97:    pop     r0
0D99:    pop     r2
0D9B:    pop     r1
0D9D:    pop     r0
0D9F:    ret 
0DA0:    push    r0
0DA2:    push    r1
0DA4:    call    0x1721
0DA6:    jf      r0, 0xdd3
0DA9:    add     r1, r0, 2
0DAD:    rmem    r0, r1
0DB0:    jt      r0, 0xdd3
0DB3:    rmem    r0, 0xaac
0DB6:    wmem    r1, r0
0DB9:    push    r0
0DBB:    push    r1
0DBD:    push    r2
0DBF:    set     r0, 0x6dba
0DC2:    set     r1, 0x5fb
0DC5:    add     r2, 0x708, 0x17ec
0DC9:    call    0x5b2
0DCB:    pop     r2
0DCD:    pop     r1
0DCF:    pop     r0
0DD1:    jmp     0xdeb
0DD3:    push    r0
0DD5:    push    r1
0DD7:    push    r2
0DD9:    set     r0, 0x6dc4
0DDC:    set     r1, 0x5fb
0DDF:    add     r2, 0x2b2b, 0x2f40
0DE3:    call    0x5b2
0DE5:    pop     r2
0DE7:    pop     r1
0DE9:    pop     r0
0DEB:    pop     r1
0DED:    pop     r0
0DEF:    ret 
0DF0:    push    r0
0DF2:    push    r1
0DF4:    call    0x1721
0DF6:    jf      r0, 0xe11
0DF9:    add     r1, r0, 2
0DFD:    rmem    r1, r1
0E00:    jt      r1, 0xe11
0E03:    add     r1, r0, 3
0E07:    rmem    r1, r1
0E0A:    jf      r1, 0xe2b
0E0D:    call    r1
0E0F:    jmp     0xe43
0E11:    push    r0
0E13:    push    r1
0E15:    push    r2
0E17:    set     r0, 0x6de7
0E1A:    set     r1, 0x5fb
0E1D:    add     r2, 0x23d0, 0x1390
0E21:    call    0x5b2
0E23:    pop     r2
0E25:    pop     r1
0E27:    pop     r0
0E29:    jmp     0xe43
0E2B:    push    r0
0E2D:    push    r1
0E2F:    push    r2
0E31:    set     r0, 0x6e0a
0E34:    set     r1, 0x5fb
0E37:    add     r2, 0x210b, 0x36b
0E3B:    call    0x5b2
0E3D:    pop     r2
0E3F:    pop     r1
0E41:    pop     r0
0E43:    pop     r1
0E45:    pop     r0
0E47:    ret 
0E48:    push    r0
0E4A:    push    r1
0E4C:    push    r2
0E4E:    set     r0, 0xa78
0E51:    call    0x1766
0E53:    jt      r0, 0xe6e
0E56:    add     r0, 0xa74, 2
0E5A:    wmem    r0, 0x7fff
0E5D:    add     r0, 0xa78, 2
0E61:    wmem    r0, 0x7fff
0E64:    add     r0, 0xa70, 2
0E68:    wmem    r0, 0x7fff
0E6B:    wmem    0xaac, 0xa58
0E6E:    pop     r2
0E70:    pop     r1
0E72:    pop     r0
0E74:    ret 
0E75:    push    r0
0E77:    push    r1
0E79:    push    r2
0E7B:    set     r0, 0x6e2c
0E7E:    set     r1, 0x5fb
0E81:    add     r2, 0x1aac, 0x2db4
0E85:    call    0x5b2
0E87:    pop     r2
0E89:    pop     r1
0E8B:    pop     r0
0E8D:    halt
0E8E:    halt
0E8F:    push    r1
0E91:    rmem    r1, 0xe8e
0E94:    or      r1, r1, r0
0E98:    wmem    0xe8e, r1
0E9B:    pop     r1
0E9D:    ret 
0E9E:    wmem    0xe8e, 0
0EA1:    ret 
0EA2:    push    r0
0EA4:    set     r0, 1
0EA7:    call    0xe8f
0EA9:    pop     r0
0EAB:    ret 
0EAC:    push    r0
0EAE:    set     r0, 2
0EB1:    call    0xe8f
0EB3:    pop     r0
0EB5:    ret 
0EB6:    push    r0
0EB8:    set     r0, 4
0EBB:    call    0xe8f
0EBD:    pop     r0
0EBF:    ret 
0EC0:    push    r0
0EC2:    set     r0, 8
0EC5:    call    0xe8f
0EC7:    pop     r0
0EC9:    ret 
0ECA:    push    r0
0ECC:    set     r0, 0x10
0ECF:    call    0xe8f
0ED1:    pop     r0
0ED3:    ret 
0ED4:    push    r0
0ED6:    set     r0, 0x20
0ED9:    call    0xe8f
0EDB:    pop     r0
0EDD:    ret 
0EDE:    push    r0
0EE0:    push    r1
0EE2:    push    r2
0EE4:    push    r3
0EE6:    set     r0, 0x40
0EE9:    call    0xe8f
0EEB:    push    r0
0EED:    push    r1
0EEF:    push    r2
0EF1:    set     r0, 0x6e4c
0EF4:    set     r1, 0x5fb
0EF7:    add     r2, 0x720, 0x39c7
0EFB:    call    0x5b2
0EFD:    pop     r2
0EFF:    pop     r1
0F01:    pop     r0
0F03:    rmem    r0, 0xe8e
0F06:    set     r1, 0x650a
0F09:    set     r2, 0x7fff
0F0C:    set     r3, 0x6e8b
0F0F:    call    0x731
0F11:    push    r0
0F13:    push    r1
0F15:    push    r2
0F17:    set     r0, 0x6e8f
0F1A:    set     r1, 0x5fb
0F1D:    add     r2, 0x320c, 0x39de
0F21:    call    0x5b2
0F23:    pop     r2
0F25:    pop     r1
0F27:    pop     r0
0F29:    wmem    0xaac, 0x971
0F2C:    pop     r3
0F2E:    pop     r2
0F30:    pop     r1
0F32:    pop     r0
0F34:    ret 
0F35:    push    r0
0F37:    push    r1
0F39:    rmem    r0, 0x99e
0F3C:    rmem    r1, 0x69dd
0F3F:    eq      r0, r0, r1
0F43:    jt      r0, 0xf64
0F46:    push    r0
0F48:    push    r1
0F4A:    push    r2
0F4C:    set     r0, 0x6ebb
0F4F:    set     r1, 0x5fb
0F52:    add     r2, 0x2507, 0x1d5c
0F56:    call    0x5b2
0F58:    pop     r2
0F5A:    pop     r1
0F5C:    pop     r0
0F5E:    wmem    0xaac, 0x999
0F61:    wmem    0xaad, 0x999
0F64:    pop     r1
0F66:    pop     r0
0F68:    ret 
0F69:    data    0x6597 0x659d 0x65a1 0x865 0x86e 0x882 
0F6F:    halt
0F70:    data    "\x16"
0F71:    halt
0F72:    halt
0F73:    halt
0F74:    halt
0F75:    halt
0F76:    push    r0
0F78:    push    r1
0F7A:    set     r0, 2
0F7D:    set     r1, 0
0F80:    call    0x107a
0F82:    pop     r1
0F84:    pop     r0
0F86:    ret 
0F87:    push    r0
0F89:    push    r1
0F8B:    set     r0, 8
0F8E:    set     r1, 1
0F91:    call    0x10b7
0F93:    pop     r1
0F95:    pop     r0
0F97:    ret 
0F98:    push    r0
0F9A:    push    r1
0F9C:    set     r0, 1
0F9F:    set     r1, 2
0FA2:    call    0x107a
0FA4:    pop     r1
0FA6:    pop     r0
0FA8:    ret 
0FA9:    push    r0
0FAB:    push    r1
0FAD:    set     r0, 1
0FB0:    set     r1, 3
0FB3:    call    0x10b7
0FB5:    call    0x11b5
0FB7:    pop     r1
0FB9:    pop     r0
0FBB:    ret 
0FBC:    push    r0
0FBE:    push    r1
0FC0:    set     r0, 4
0FC3:    set     r1, 4
0FC6:    call    0x10b7
0FC8:    pop     r1
0FCA:    pop     r0
0FCC:    ret 
0FCD:    push    r0
0FCF:    push    r1
0FD1:    set     r0, 2
0FD4:    set     r1, 5
0FD7:    call    0x107a
0FD9:    pop     r1
0FDB:    pop     r0
0FDD:    ret 
0FDE:    push    r0
0FE0:    push    r1
0FE2:    set     r0, 11
0FE5:    set     r1, 6
0FE8:    call    0x10b7
0FEA:    pop     r1
0FEC:    pop     r0
0FEE:    ret 
0FEF:    push    r0
0FF1:    push    r1
0FF3:    set     r0, 2
0FF6:    set     r1, 7
0FF9:    call    0x107a
0FFB:    pop     r1
0FFD:    pop     r0
0FFF:    ret 
1000:    push    r0
1002:    push    r1
1004:    set     r0, 0
1007:    set     r1, 8
100A:    call    0x107a
100C:    pop     r1
100E:    pop     r0
1010:    ret 
1011:    push    r0
1013:    push    r1
1015:    set     r0, 4
1018:    set     r1, 9
101B:    call    0x10b7
101D:    pop     r1
101F:    pop     r0
1021:    ret 
1022:    push    r0
1024:    push    r1
1026:    set     r0, 1
1029:    set     r1, 10
102C:    call    0x107a
102E:    pop     r1
1030:    pop     r0
1032:    ret 
1033:    push    r0
1035:    push    r1
1037:    set     r0, 0x12
103A:    set     r1, 11
103D:    call    0x10b7
103F:    pop     r1
1041:    pop     r0
1043:    ret 
1044:    call    0x1203
1046:    ret 
1047:    push    r0
1049:    push    r1
104B:    set     r0, 1
104E:    set     r1, 12
1051:    call    0x107a
1053:    pop     r1
1055:    pop     r0
1057:    ret 
1058:    push    r0
105A:    push    r1
105C:    set     r0, 9
105F:    set     r1, 13
1062:    call    0x10b7
1064:    pop     r1
1066:    pop     r0
1068:    ret 
1069:    push    r0
106B:    push    r1
106D:    set     r0, 2
1070:    set     r1, 14
1073:    call    0x107a
1075:    pop     r1
1077:    pop     r0
1079:    ret 
107A:    push    r0
107C:    push    r1
107E:    push    r2
1080:    add     r2, 0xa9c, 2
1084:    rmem    r2, r2
1087:    jt      r2, 0x10b0
108A:    call    0x1135
108C:    wmem    0xf6f, r0
108F:    add     r1, r0, 0xf69
1093:    rmem    r1, r1
1096:    set     r0, 0x65a8
1099:    call    0x5ee
109B:    set     r0, r1
109E:    call    0x5ee
10A0:    set     r0, 0x65e8
10A3:    call    0x5ee
10A5:    set     r0, r1
10A8:    call    0x5ee
10AA:    out     ".\n\n"
10B0:    pop     r2
10B2:    pop     r1
10B4:    pop     r0
10B6:    ret 
10B7:    push    r0
10B9:    push    r1
10BB:    push    r2
10BD:    add     r2, 0xa9c, 2
10C1:    rmem    r2, r2
10C4:    jt      r2, 0x112e
10C7:    call    0x1135
10C9:    push    r0
10CB:    rmem    r0, 0xf6f
10CE:    add     r1, r0, 0xf69
10D2:    rmem    r1, r1
10D5:    set     r0, 0x660a
10D8:    call    0x5ee
10DA:    set     r0, r1
10DD:    call    0x5ee
10DF:    set     r0, 0x663a
10E2:    call    0x5ee
10E4:    pop     r0
10E6:    set     r1, r0
10E9:    rmem    r0, 0xf70
10EC:    rmem    r2, 0xf6f
10EF:    add     r2, r2, 0xf6c
10F3:    rmem    r2, r2
10F6:    call    r2
10F8:    jt      r1, 0x1127
10FB:    rmem    r1, 0xf70
10FE:    wmem    0xf70, r0
1101:    gt      r2, r0, r1
1105:    jf      r2, 0x1111
1108:    push    r0
110A:    set     r0, 0x667b
110D:    call    0x5ee
110F:    pop     r0
1111:    gt      r2, r1, r0
1115:    jf      r2, 0x1121
1118:    push    r0
111A:    set     r0, 0x669b
111D:    call    0x5ee
111F:    pop     r0
1121:    out     "\n\n"
1125:    jmp     0x112e
1127:    call    0x1234
1129:    set     r0, 0x66bb
112C:    call    0x5ee
112E:    pop     r2
1130:    pop     r1
1132:    pop     r0
1134:    ret 
1135:    push    r0
1137:    push    r1
1139:    push    r2
113B:    push    r3
113D:    push    r4
113F:    push    r5
1141:    rmem    r5, 0xf71
1144:    gt      r3, r5, 0x752f
1148:    jt      r3, 0x1152
114B:    add     r5, r5, 1
114F:    wmem    0xf71, r5
1152:    set     r3, r0
1155:    set     r4, r1
1158:    add     r0, r5, 2
115C:    call    0x8e9
115E:    rmem    r1, 0xf72
1161:    or      r0, r1, r0
1165:    set     r1, r4
1168:    call    0x8c8
116A:    wmem    0xf72, r0
116D:    set     r0, 0xf73
1170:    add     r1, r5, 2
1174:    set     r2, r4
1177:    call    0x11a3
1179:    set     r0, 0xf74
117C:    mult    r1, r5, r5
1180:    mult    r2, r4, r4
1184:    call    0x11a3
1186:    set     r0, 0xf75
1189:    set     r1, 13
118C:    mult    r2, r3, 9
1190:    mult    r2, r2, r2
1194:    call    0x11a3
1196:    pop     r5
1198:    pop     r4
119A:    pop     r3
119C:    pop     r2
119E:    pop     r1
11A0:    pop     r0
11A2:    ret 
11A3:    push    r0
11A5:    rmem    r0, r0
11A8:    call    0x8c8
11AA:    set     r1, r2
11AD:    call    0x84d
11AF:    pop     r1
11B1:    wmem    r1, r0
11B4:    ret 
11B5:    push    r0
11B7:    add     r0, 0xa9c, 2
11BB:    rmem    r0, r0
11BE:    jt      r0, 0x1200
11C1:    set     r0, 0x66d1
11C4:    call    0x5ee
11C6:    rmem    r0, 0xf70
11C9:    eq      r0, r0, 0x1e
11CD:    jt      r0, 0x11de
11D0:    set     r0, 0x66f2
11D3:    call    0x5ee
11D5:    set     r0, 0x671e
11D8:    call    0x5ee
11DA:    call    0x1234
11DC:    jmp     0x1200
11DE:    set     r0, 0x6748
11E1:    call    0x5ee
11E3:    rmem    r0, 0xf72
11E6:    add     r0, r0, 1
11EA:    jt      r0, 0x11f4
11ED:    set     r0, 0x6774
11F0:    call    0x5ee
11F2:    jmp     0x11d5
11F4:    set     r0, 0x67d8
11F7:    call    0x5ee
11F9:    add     r0, 0xa9c, 2
11FD:    wmem    r0, 0x7fff
1200:    pop     r0
1202:    ret 
1203:    push    r0
1205:    add     r0, 0xa9c, 2
1209:    rmem    r0, r0
120C:    jt      r0, 0x1231
120F:    set     r0, 0x685d
1212:    call    0x5ee
1214:    rmem    r0, 0xaac
1217:    eq      r0, r0, 0xa3f
121B:    jt      r0, 0x1225
121E:    set     r0, 0x6865
1221:    call    0x5ee
1223:    jmp     0x122a
1225:    set     r0, 0x686b
1228:    call    0x5ee
122A:    set     r0, 0x6871
122D:    call    0x5ee
122F:    call    0x1234
1231:    pop     r0
1233:    ret 
1234:    push    r0
1236:    wmem    0xf70, 0x16
1239:    wmem    0xf71, 0
123C:    wmem    0xf72, 0
123F:    wmem    0xf73, 0
1242:    wmem    0xf74, 0
1245:    wmem    0xf75, 0
1248:    add     r0, 0xa9c, 2
124C:    wmem    r0, 0xa3f
124F:    pop     r0
1251:    ret 
1252:    push    r0
1254:    add     r0, 0xa9c, 2
1258:    rmem    r0, r0
125B:    eq      r0, r0, 0x7fff
125F:    jt      r0, 0x126d
1262:    set     r0, 0x68c8
1265:    call    0x5ee
1267:    wmem    0xaac, 0xa12
126A:    wmem    0xaad, 0xa12
126D:    pop     r0
126F:    ret 
1270:    push    r0
1272:    push    r1
1274:    push    r2
1276:    push    r3
1278:    push    r0
127A:    push    r1
127C:    push    r2
127E:    set     r0, 0x6ed1
1281:    set     r1, 0x5fb
1284:    add     r2, 0x4ba5, 0x1e49
1288:    call    0x5b2
128A:    pop     r2
128C:    pop     r1
128E:    pop     r0
1290:    set     r0, 0x1092
1293:    set     r1, 0x650a
1296:    set     r2, 0x7fff
1299:    set     r3, 0x6eed
129C:    call    0x731
129E:    push    r0
12A0:    push    r1
12A2:    push    r2
12A4:    set     r0, 0x6ef1
12A7:    set     r1, 0x5fb
12AA:    add     r2, 0x3ffe, 0x771
12AE:    call    0x5b2
12B0:    pop     r2
12B2:    pop     r1
12B4:    pop     r0
12B6:    pop     r3
12B8:    pop     r2
12BA:    pop     r1
12BC:    pop     r0
12BE:    ret 
12BF:    push    r0
12C1:    add     r0, 0xa70, 2
12C5:    rmem    r0, r0
12C8:    jt      r0, 0x12fa
12CB:    add     r0, 0xa7c, 2
12CF:    wmem    r0, 0x7fff
12D2:    add     r0, 0xa70, 2
12D6:    wmem    r0, 0x7fff
12D9:    add     r0, 0xa74, 2
12DD:    wmem    r0, 0
12E0:    push    r0
12E2:    push    r1
12E4:    push    r2
12E6:    set     r0, 0x6f25
12E9:    set     r1, 0x5fb
12EC:    add     r2, 0x5c8, 0xb5
12F0:    call    0x5b2
12F2:    pop     r2
12F4:    pop     r1
12F6:    pop     r0
12F8:    jmp     0x1312
12FA:    push    r0
12FC:    push    r1
12FE:    push    r2
1300:    set     r0, 0x6f5e
1303:    set     r1, 0x5fb
1306:    add     r2, 0x4a2a, 0x345
130A:    call    0x5b2
130C:    pop     r2
130E:    pop     r1
1310:    pop     r0
1312:    pop     r0
1314:    ret 
1315:    push    r0
1317:    add     r0, 0xa74, 2
131B:    wmem    r0, 0x7fff
131E:    add     r0, 0xa78, 2
1322:    wmem    r0, 0
1325:    push    r0
1327:    push    r1
1329:    push    r2
132B:    set     r0, 0x6f99
132E:    set     r1, 0x5fb
1331:    add     r2, 0x1c81, 0xc76
1335:    call    0x5b2
1337:    pop     r2
1339:    pop     r1
133B:    pop     r0
133D:    wmem    0xaad, 0
1340:    pop     r0
1342:    ret 
1343:    push    r0
1345:    add     r0, 0xa74, 2
1349:    wmem    r0, 0
134C:    add     r0, 0xa78, 2
1350:    wmem    r0, 0x7fff
1353:    push    r0
1355:    push    r1
1357:    push    r2
1359:    set     r0, 0x6fb3
135C:    set     r1, 0x5fb
135F:    add     r2, 0x15f9, 0xbeb
1363:    call    0x5b2
1365:    pop     r2
1367:    pop     r1
1369:    pop     r0
136B:    wmem    0xaad, 0
136E:    pop     r0
1370:    ret 
1371:    push    r2
1373:    push    r3
1375:    rmem    r2, 0xaac
1378:    eq      r2, r2, 0x999
137C:    jt      r2, 0x1399
137F:    push    r0
1381:    push    r1
1383:    push    r2
1385:    set     r0, 0x6fcd
1388:    set     r1, 0x5fb
138B:    add     r2, 0x309, 0x6ff5
138F:    call    0x5b2
1391:    pop     r2
1393:    pop     r1
1395:    pop     r0
1397:    jmp     0x14d8
1399:    add     r2, r0, 2
139D:    wmem    r2, 0x7fff
13A0:    rmem    r2, 0x99e
13A3:    add     r2, r2, 0x69d7
13A7:    add     r2, r2, 1
13AB:    rmem    r2, r2
13AE:    add     r3, 0x999, 1
13B2:    rmem    r3, r3
13B5:    add     r3, r3, r2
13B9:    add     r2, r1, 0x30
13BD:    wmem    r3, r2
13C0:    rmem    r2, 0x99e
13C3:    add     r2, r2, 0x69dd
13C7:    add     r2, r2, 1
13CB:    wmem    r2, r1
13CE:    push    r0
13D0:    push    r0
13D2:    push    r1
13D4:    push    r2
13D6:    set     r0, 0x6ff8
13D9:    set     r1, 0x5fb
13DC:    add     r2, 0xcb7, 0x92a
13E0:    call    0x5b2
13E2:    pop     r2
13E4:    pop     r1
13E6:    pop     r0
13E8:    pop     r0
13EA:    push    r0
13EC:    add     r2, r0, 0
13F0:    rmem    r0, r2
13F3:    call    0x5ee
13F5:    pop     r0
13F7:    push    r0
13F9:    push    r0
13FB:    push    r1
13FD:    push    r2
13FF:    set     r0, 0x7007
1402:    set     r1, 0x5fb
1405:    add     r2, 0x1418, 0x5e4e
1409:    call    0x5b2
140B:    pop     r2
140D:    pop     r1
140F:    pop     r0
1411:    pop     r0
1413:    rmem    r2, 0x99e
1416:    add     r2, r2, 1
141A:    wmem    0x99e, r2
141D:    rmem    r3, 0x69dd
1420:    eq      r3, r2, r3
1424:    jf      r3, 0x14d8
1427:    set     r0, 0
142A:    add     r1, 0x69dd, 1
142E:    rmem    r1, r1
1431:    add     r0, r0, r1
1435:    add     r1, 0x69dd, 2
1439:    rmem    r1, r1
143C:    add     r2, 0x69dd, 3
1440:    rmem    r2, r2
1443:    mult    r2, r2, r2
1447:    mult    r1, r1, r2
144B:    add     r0, r0, r1
144F:    add     r1, 0x69dd, 4
1453:    rmem    r1, r1
1456:    mult    r2, r1, r1
145A:    mult    r2, r2, r1
145E:    add     r0, r0, r2
1462:    add     r1, 0x69dd, 5
1466:    rmem    r1, r1
1469:    mult    r1, r1, 0x7fff
146D:    add     r0, r0, r1
1471:    eq      r1, r0, 0x18f
1475:    jt      r1, 0x14c0
1478:    add     r2, 0xa80, 2
147C:    wmem    r2, 0x999
147F:    add     r2, 0xa84, 2
1483:    wmem    r2, 0x999
1486:    add     r2, 0xa88, 2
148A:    wmem    r2, 0x999
148D:    add     r2, 0xa8c, 2
1491:    wmem    r2, 0x999
1494:    add     r2, 0xa90, 2
1498:    wmem    r2, 0x999
149B:    wmem    0x99e, 0
149E:    set     r0, 0x69d7
14A1:    set     r1, 0x14dd
14A4:    call    0x5b2
14A6:    push    r0
14A8:    push    r1
14AA:    push    r2
14AC:    set     r0, 0x7026
14AF:    set     r1, 0x5fb
14B2:    add     r2, 0x19ae, 0x2b3a
14B6:    call    0x5b2
14B8:    pop     r2
14BA:    pop     r1
14BC:    pop     r0
14BE:    jmp     0x14d8
14C0:    push    r0
14C2:    push    r1
14C4:    push    r2
14C6:    set     r0, 0x7069
14C9:    set     r1, 0x5fb
14CC:    add     r2, 0x3f3, 0xf76
14D0:    call    0x5b2
14D2:    pop     r2
14D4:    pop     r1
14D6:    pop     r0
14D8:    pop     r3
14DA:    pop     r2
14DC:    ret 
14DD:    push    r2
14DF:    add     r2, 0x999, 1
14E3:    rmem    r2, r2
14E6:    add     r2, r2, r0
14EA:    wmem    r2, 0x5f
14ED:    pop     r2
14EF:    ret 
14F0:    push    r0
14F2:    push    r1
14F4:    set     r0, 0xa80
14F7:    set     r1, 2
14FA:    call    0x1371
14FC:    pop     r1
14FE:    pop     r0
1500:    ret 
1501:    push    r0
1503:    push    r1
1505:    set     r0, 0xa84
1508:    set     r1, 3
150B:    call    0x1371
150D:    pop     r1
150F:    pop     r0
1511:    ret 
1512:    push    r0
1514:    push    r1
1516:    set     r0, 0xa88
1519:    set     r1, 5
151C:    call    0x1371
151E:    pop     r1
1520:    pop     r0
1522:    ret 
1523:    push    r0
1525:    push    r1
1527:    set     r0, 0xa8c
152A:    set     r1, 7
152D:    call    0x1371
152F:    pop     r1
1531:    pop     r0
1533:    ret 
1534:    push    r0
1536:    push    r1
1538:    set     r0, 0xa90
153B:    set     r1, 9
153E:    call    0x1371
1540:    pop     r1
1542:    pop     r0
1544:    ret 
1545:    push    r0
1547:    push    r1
1549:    push    r2
154B:    jf      r7, 0x15e5
154E:    push    r0
1550:    push    r1
1552:    push    r2
1554:    set     r0, 0x70ac
1557:    set     r1, 0x5fb
155A:    add     r2, 0x433, 0xc1
155E:    call    0x5b2
1560:    pop     r2
1562:    pop     r1
1564:    pop     r0
1566:    noop
1567:    noop
1568:    noop
1569:    noop
156A:    noop
156B:    set     r0, 4
156E:    set     r1, 1
1571:    call    0x178b
1573:    eq      r1, r0, 6
1577:    jf      r1, 0x15cb
157A:    push    r0
157C:    push    r1
157E:    push    r2
1580:    set     r0, 0x7156
1583:    set     r1, 0x5fb
1586:    add     r2, 0x1dd, 0x2d15
158A:    call    0x5b2
158C:    pop     r2
158E:    pop     r1
1590:    pop     r0
1592:    set     r0, r7
1595:    set     r1, 0x650a
1598:    set     r2, 0x7fff
159B:    push    r3
159D:    set     r3, 0x7239
15A0:    call    0x731
15A2:    pop     r3
15A4:    push    r0
15A6:    push    r1
15A8:    push    r2
15AA:    set     r0, 0x723d
15AD:    set     r1, 0x5fb
15B0:    add     r2, 0x21b3, 0x40c2
15B4:    call    0x5b2
15B6:    pop     r2
15B8:    pop     r1
15BA:    pop     r0
15BC:    wmem    0xaac, 0x9c2
15BF:    wmem    0xaad, 0
15C2:    add     r1, 0xa94, 2
15C6:    wmem    r1, 0x7fff
15C9:    jmp     0x1652
15CB:    push    r0
15CD:    push    r1
15CF:    push    r2
15D1:    set     r0, 0x72d8
15D4:    set     r1, 0x5fb
15D7:    add     r2, 0x11b6, 0x1aaa
15DB:    call    0x5b2
15DD:    pop     r2
15DF:    pop     r1
15E1:    pop     r0
15E3:    jmp     0x1652
15E5:    push    r0
15E7:    push    r1
15E9:    push    r2
15EB:    set     r0, 0x7369
15EE:    set     r1, 0x5fb
15F1:    add     r2, 0x141a, 0x3ed4
15F5:    call    0x5b2
15F7:    pop     r2
15F9:    pop     r1
15FB:    pop     r0
15FD:    set     r0, 0
1600:    add     r2, 1, 0x69dd
1604:    rmem    r1, r2
1607:    add     r0, r0, r1
160B:    mult    r0, r0, 0x7bac
160F:    call    0x84d
1611:    rmem    r1, 0x69dd
1614:    add     r1, r1, 0x69dd
1618:    add     r2, r2, 1
161C:    gt      r1, r2, r1
1620:    jf      r1, 0x1604
1623:    set     r1, 0x650a
1626:    set     r2, 0x7fff
1629:    push    r3
162B:    set     r3, 0x73df
162E:    call    0x731
1630:    pop     r3
1632:    push    r0
1634:    push    r1
1636:    push    r2
1638:    set     r0, 0x73e3
163B:    set     r1, 0x5fb
163E:    add     r2, 0x951, 0x22e
1642:    call    0x5b2
1644:    pop     r2
1646:    pop     r1
1648:    pop     r0
164A:    wmem    0xaac, 0x9b8
164D:    wmem    0xaad, 0
1650:    jmp     0x1652
1652:    pop     r2
1654:    pop     r1
1656:    pop     r0
1658:    ret 
1659:    push    r0
165B:    push    r1
165D:    push    r2
165F:    push    r3
1661:    push    r0
1663:    push    r1
1665:    push    r2
1667:    set     r0, 0x743d
166A:    set     r1, 0x5fb
166D:    add     r2, 0x5e27, 0x64f
1671:    call    0x5b2
1673:    pop     r2
1675:    pop     r1
1677:    pop     r0
1679:    rmem    r0, 0xf73
167C:    rmem    r1, 0xf74
167F:    call    0x84d
1681:    rmem    r1, 0xf75
1684:    call    0x84d
1686:    set     r1, 0x653f
1689:    set     r2, 4
168C:    push    r3
168E:    set     r3, 0x74f6
1691:    call    0x731
1693:    pop     r3
1695:    push    r0
1697:    push    r1
1699:    push    r2
169B:    set     r0, 0x74fa
169E:    set     r1, 0x5fb
16A1:    add     r2, 0x38b9, 0x2bb3
16A5:    call    0x5b2
16A7:    pop     r2
16A9:    pop     r1
16AB:    pop     r0
16AD:    pop     r3
16AF:    pop     r2
16B1:    pop     r1
16B3:    pop     r0
16B5:    ret 
16B6:    out     "- "
16BA:    call    0x5ee
16BC:    out     "\n"
16BE:    ret 
16BF:    push    r1
16C1:    push    r2
16C3:    set     r0, 0x6af5
16C6:    set     r1, 0x16d6
16C9:    set     r2, 0
16CC:    call    0x5b2
16CE:    set     r0, r2
16D1:    pop     r2
16D3:    pop     r1
16D5:    ret 
16D6:    push    r3
16D8:    push    r4
16DA:    rmem    r3, 0xaac
16DD:    add     r4, r0, 2
16E1:    rmem    r4, r4
16E4:    eq      r3, r3, r4
16E8:    jf      r3, 0x16ef
16EB:    add     r2, r2, 1
16EF:    pop     r4
16F1:    pop     r3
16F3:    ret 
16F4:    push    r0
16F6:    push    r1
16F8:    set     r0, 0x6af5
16FB:    set     r1, 0x1705
16FE:    call    0x5b2
1700:    pop     r1
1702:    pop     r0
1704:    ret 
1705:    push    r3
1707:    add     r3, r0, 2
170B:    rmem    r3, r3
170E:    eq      r3, r2, r3
1712:    jf      r3, 0x171e
1715:    add     r0, r0, 0
1719:    rmem    r0, r0
171C:    call    0x16b6
171E:    pop     r3
1720:    ret 
1721:    push    r1
1723:    push    r2
1725:    set     r2, r0
1728:    set     r0, 0x6af5
172B:    set     r1, 0x174c
172E:    call    0x607
1730:    eq      r1, r0, 0x7fff
1734:    jt      r1, 0x1744
1737:    add     r1, 0x6af5, r0
173B:    add     r1, r1, 1
173F:    rmem    r0, r1
1742:    jmp     0x1747
1744:    set     r0, 0
1747:    pop     r2
1749:    pop     r1
174B:    ret 
174C:    push    r1
174E:    set     r1, r2
1751:    add     r0, r0, 0
1755:    rmem    r0, r0
1758:    call    0x683
175A:    pop     r1
175C:    jf      r0, 0x1765
175F:    set     r2, r1
1762:    set     r1, 0x7fff
1765:    ret 
1766:    push    r1
1768:    push    r2
176A:    add     r0, r0, 2
176E:    rmem    r0, r0
1771:    jf      r0, 0x1783
1774:    rmem    r1, 0xaac
1777:    eq      r1, r0, r1
177B:    jt      r1, 0x1783
177E:    set     r0, 0
1781:    jmp     0x1786
1783:    set     r0, 1
1786:    pop     r2
1788:    pop     r1
178A:    ret 
178B:    jt      r0, 0x1793
178E:    add     r0, r1, 1
1792:    ret 
1793:    jt      r1, 0x17a0
1796:    add     r0, r0, 0x7fff
179A:    set     r1, r7
179D:    call    0x178b
179F:    ret 
17A0:    push    r0
17A2:    add     r1, r1, 0x7fff
17A6:    call    0x178b
17A8:    set     r1, r0
17AB:    pop     r0
17AD:    add     r0, r0, 0x7fff
17B1:    call    0x178b
17B3:    ret 
17B4:    data    "\vTest string#self-test complete, all tests pass\n\bcomplete\x03\0\0\0\f\0\0\0\0\0\0\0\0\0\0\0\0\tFoothills"
1808:    data    0xb7 
1809:    data    "You find yourself standing at the base of an enormous mountain.  At its base to the north, there is a massive doorway.  A sign nearby reads \"Keep out!  Definitely no treasure within!\"\adoorway\x05south\tFoothillsJAs you begin to leave, you feel the urge for adventure pulling you back...\x05north\tDark cave"
1933:    data    0x85 
1934:    data    "This seems to be the mouth of a deep cave.  As you peer north into the darkness, you think you hear the echoes of bats deeper within.\x05north\x05south\tDark cave[The cave is somewhat narrow here, and the light from the doorway to the south is quite dim.\x05north\x05south\tDark cave"
1A41:    data    0xbb 
1A42:    data    "The cave acoustics dramatically change as you find yourself at a legde above a large chasm.  There is barely enough light here to notice a rope bridge leading out into the dark emptiness.\x06bridge\x05south\vRope bridgeyThis rope bridge creaks as you walk along it.  You aren\'t sure how old it is, or whether it can even support your weight.\bcontinue\x04back\x18Falling through the air!"
1BB7:    data    0xa9 
1BB8:    data    "As you continue along the bridge, it snaps!  You try to grab the bridge, but it evades your grasp in the darkness.  You are plummeting quickly downward into the chasm...\x04down\vMoss cavern"
1C72:    data    0xd1 
1C73:    data    "You are standing in a large cavern full of bioluminescent moss.  It must have broken your fall!  The cavern extends to the east and west; at the west end, you think you see a passage leading out of the cavern.\x04west\x04east\vMoss cavern`You are standing in a large cavern full of bioluminescent moss.  The cavern extends to the west.\x04west\vMoss cavern"
1DCC:    data    0x9d 
1DCD:    data    "You are standing in a large cavern full of bioluminescent moss.  The cavern extends to the east.  There is a crevise in the rocks which opens into a passage.\x04east\apassage\aPassage"
1E7F:    data    0xb0 
1E80:    data    "You are in a crevise on the west wall of the moss cavern.  A dark passage leads further west.  There is a ladder here which leads down into a smaller, moss-filled cavern below.\x06cavern\x06ladder\bdarkness\aPassage9It is pitch black.  You are likely to be eaten by a grue.KYou feel that your light source is more than sufficient to keep grues away.\bcontinue\x04back\x0fTwisty passages{You are in a maze of twisty little passages, all dimly lit by more bioluminescent moss.  There is a ladder here leading up.\x06ladder\x05north\x05south\x04east\x04west\x0fTwisty passages7You are in a twisty maze of little passages, all alike.\x05north\x05south\x04west\x0fTwisty passages7You are in a maze of little twisty passages, all alike.\x05north\x05south\x04east\x0fTwisty passages|You are in a maze of alike little passages, all twisty.\n\nThe passage to the east looks very dark; you think you hear a Grue.\x05north\x05south\x04west\x04east\x0fTwisty passages7You are in a little maze of twisty passages, all alike.\x05north\x05south\x04east\x0fTwisty passages"
224A:    data    0x83 
224B:    data    "You are in a twisty alike of little passages, all maze.\n\nThe east passage appears very dark; you feel likely to be eaten by a Grue.\x05north\x05south\x04west\x04east\x0fTwisty passages7You are in a maze of alike twisty passages, all little.\x05north\x04east\x05south\x0fTwisty passages7You are in a maze of twisty little passages, all alike.\x04west\x0fTwisty passages7You are in a maze of twisty little passages, all alike.\x04west\x0fTwisty passages7You are in a twisty maze of little passages, all alike.\x05north\x05south\fDark passagerYou are in a narrow passage.  There is darkness to the west, but you can barely see a glowing opening to the east.\x04west\x04east\fDark passage\"You are in a dark, narrow passage.\x04east\x04west\fDark passage\"You are in a dark, narrow passage.\x04east\x04west\fDark passagedYou are in a dark, narrow passage.  To the west, you spot some vegetation where the passage expands.\x04east\x04west\x05Ruins"
25AB:    data    0xf8 
25AC:    data    "You stand in a large cavern with a huge ruin to the north, overgrown by plant life.  There is a large stone archway to the north acting as the doorway to the ruined complex.  A crevice in the rock to the east leads to an alarmingly dark passageway.\x04east\x05north\x05Ruins"
26B5:    data    0xb5 
26B6:    data    "You are in the once-opulent foyer of a massive ruined complex.  There is a door to the south leading to the overgrowth outside and stairs to the north which lead into a larger hall.\x05north\x05south\x05Ruins"
277D:    data    0x125 
277E:    data    "You stand in the massive central hall of these ruins.  The walls are crumbling, and vegetation has clearly taken over.  Rooms are attached in all directions.  There is a strange monument in the center of the hall with circular slots and unusual symbols.  It reads:\n\n_ + _ * _^2 + _^3 - _ = 399\x05north\x05south\x04east\x04west\x05Ruins"
28BF:    data    0xa7 
28C0:    data    "Because it has been so well-protected, this room hardly shows signs of decay.  The walls are covered in elaborate murals and decorated with precious metals and stones.\x05south\x05Ruins"
2973:    data    0x8a 
2974:    data    "You stand in what seems to have once been a dining hall; broken tables and pottery are scattered everywhere.  A staircase here leads down.\x04down\x04west\x05RuinszThis seems to be a kitchen; there are brick stoves and shelves along the wall.  Everything here has fallen into disrepair.\x02up\x05Ruins"
2A92:    data    0xb3 
2A93:    data    "You find yourself in what was once the living quarters for the complex.  Many smaller rooms which once had walls to divide them now lay in disarray.  There is a staircase up here.\x02up\x04east\x05Ruins"
2B54:    data    0xa9 
2B55:    data    "This was long ago a lavish throne room.  Dried-up fountains and crumbling statues line the walls, and the carved stone throne in the center of the room is falling apart.\x04down\x14Synacor Headquarters"
2C18:    data    0xff 
2C19:    data    "You stand in the lobby of what appears to be a really fun place to work!  Sadly, there doesn\'t seem to be anyone around at the moment, so you make a note to call them later.  The bookshelf here looks like it might have something interesting in it, though.\aoutside\x14Synacor Headquarters"
2D35:    data    0x91 
2D36:    data    "It\'s a warm, sunny day!  While the breeze from Lake Erie is certainly refreshing, you don\'t see anything here that will help you with your quest.\x06inside\x05Beach"
2DD4:    data    0xaa 
2DD5:    data    "This is a sandy beach in a cove on some tropical island.  It is raining.  The ocean is to your south, and heavy foliage is to your north; the beach extends west and east.\x04west\x04east\x05north\x05Beach"
2E95:    data    0x106 
2E96:    data    "This is a sandy beach in a cove on some tropical island.  It is raining.  To your west is an embankment of the cove which looks too steep to climb.  The beach extends to the east, and there is dense foliage to the north.  The ocean to the south seems uninviting.\x04east\x05north\x05Beach"
2FAD:    data    0xf2 
2FAE:    data    "This is a sandy beach in a cove on some tropical island.  It is raining.  The steep cove embankment to your east blocks your path, and the ocean waters here look unsafe.  The beach extends to the west, and there is dense foliage to the north.\x04west\x05north\x0fTropical Island"
30BB:    data    0xc6 
30BC:    data    "The large trees here seem to be protecting you from the rain.  As you push through the undergrowth, you can hear birds chirping overhead.  There is a steep rock face to your west blocking your path.\x05north\x05south\x04east\x0fTropical IslandzThe east embankment of the cove towers over you.  It produces a small waterfall here which cascades excitedly into a pool.\x05north\x05south\x04west\x0fTropical Island"
323F:    data    0xe6 
3240:    data    "The embankment of the cove come toegher here to your east and west.  Between these tall rock faces, there is a narrow, overgrown path leading north.  You hear waves lapping up on a beach through the dense vegetation to your south.\x05north\x05south\x0fTropical Island"
3342:    data    0x11d 
3343:    data    "You are on a narrow path between two steep rock faces which look like they have been here for thousands of years.  Rain trickles down through the vegetation and moss, and through the leaves you can occasionally see a sliver of light hundreds of feet above you where the rock walls end.\x05north\x05south\x0fTropical Island"
347C:    data    0xf5 
347D:    data    "The narrow path slopes downward to the north and leads to the mouth of a small cave.  A sign nearby reads \"Treasure Vault Access\", but different handwriting has crossed this out and written \"Lair of Horrible Monster!  All non-pirates keep out!\".\x05north\x05south\rTropical Cave"
358C:    data    0xdc 
358D:    data    "You stand at the entrance to a natural cave which looks like it hasn\'t been visited in quite some time.  Light pours in through the opening to the south, while fireflies light the path further into the cave to the north.\x05north\x05south\rTropical CavezFireflies slowly drift around you and light the tunnel, which seems to get brighter to the south, but dimmer to the north.\x05north\x05south\rTropical Cave"
3718:    data    0x142 
3719:    data    "The cave is a little wider here.  You find the cobweb-encrusted remains of a small camp, and although you don\'t suspect the broken pieces of tables and chairs will prove useful to your quest, the fireflies seem to like using the debris as a shelter.  A passageway leads north and south, and there is an alcove to the east.\x05north\x05south\x04east\x14Tropical Cave Alcove"
3881:    data    0xa3 
3882:    data    "At the back of this alcove, there is a small table, a chair, and a broken lantern.  It looks like this space was used much more recently than the camp to the west.\x04west\rTropical CavehThis tunnel slopes deeper underground to the north, but the fireflies are all around to light your path.\x05north\x05south\nVault Lock"
39B8:    data    0x80 
39B9:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'*\' symbol.\x04east\x05south\nVault Lock"
3A4F:    data    0x82 
3A50:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting the number \'8\'.\x04east\x05south\x04west\nVault Lock"
3AED:    data    0x80 
3AEE:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'-\' symbol.\x04east\x05south\x04west\nVault Door"
3B89:    data    0xf6 
3B8A:    data    "You stand before the door to the vault; it has a large \'30\' carved into it.  Affixed to the wall near the door, there is a running hourglass which never seems to run out of sand.\n\nThe floor of this room is a large mosaic depicting the number \'1\'.\x05south\x04west\x05vault\nVault Lock"
3C9C:    data    0x82 
3C9D:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting the number \'4\'.\x05north\x04east\x05south\nVault Lock"
3D3B:    data    0x80 
3D3C:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'*\' symbol.\x05north\x04east\x05south\x04west\nVault Lock"
3DDD:    data    0x83 
3DDE:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting the number \'11\'.\x05north\x04east\x05south\x04west\nVault Lock"
3E82:    data    0x80 
3E83:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'*\' symbol.\x05north\x05south\x04west\nVault Lock"
3F1F:    data    0x80 
3F20:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'+\' symbol.\x05north\x04east\x05south\nVault Lock"
3FBC:    data    0x82 
3FBD:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting the number \'4\'.\x05north\x04east\x05south\x04west\nVault Lock"
4060:    data    0x80 
4061:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'-\' symbol.\x05north\x04east\x05south\x04west\nVault Lock"
4102:    data    0x83 
4103:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting the number \'18\'.\x05north\x05south\x04west\x11Vault Antechamber"
41A9:    data    0x90 
41AA:    data    "You are in the antechamber to a grid of rooms that control the door to the vault.  You notice the number \'22\' is carved into the orb\'s pedestal.\x05north\x04east\x05south\nVault Lock"
4256:    data    0x80 
4257:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'-\' symbol.\x05north\x04east\x04west\nVault Lock"
42F2:    data    0x82 
42F3:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting the number \'9\'.\x05north\x04east\x04west\nVault Lock"
4390:    data    0x80 
4391:    data    "You are in a grid of rooms that control the door to the vault.\n\nThe floor of this room is a large mosaic depicting a \'*\' symbol.\x05north\x04west\x05Vault"
4422:    data    0xd4 
4423:    data    "This vault contains incredible riches!  Piles of gold and platinum coins surround you, and the walls are adorned with topazes, rubies, sapphires, emeralds, opals, dilithium crystals, elerium-115, and unobtainium.\x05leave\x1fFumbling around in the darknesscWithout a source of light, you have become hopelessly lost and are fumbling around in the darkness.\aforward\x04back\x1fFumbling around in the darkness^You can\'t seem to find your way.  However, you do think you hear low growling in the distance.\x03run\vinvestigate\x11Panicked and lostIThe growling is getting louder.  Did I mention there are Grues down here?\x03run\x04wait\x04hide\x05eaten\0\x06tablet"
4695:    data    0x88 
4696:    data    "The tablet seems appropriate for use as a writing surface but is unfortunately blank.  Perhaps you should USE it as a writing surface...\rempty lantern{The lantern seems to have quite a bit of wear but appears otherwise functional.  It is, however, sad that it is out of oil.\alanternsThe lantern seems to have quite a bit of wear but appears otherwise functional.  It is off but happily full of oil.\vlit lanternWThe lantern seems to have quite a bit of wear.  It is lit and producing a bright light.\x03can-This can is full of high-quality lantern oil.\bred coin?This coin is made of a red metal.  It has two dots on one side.\rcorroded coin?This coin is somewhat corroded.  It has a triangle on one side.\nshiny coinGThis coin is somehow still quite shiny.  It has a pentagon on one side.\fconcave coinWThis coin is slightly rounded, almost like a tiny bowl.  It has seven dots on one side.\tblue coinAThis coin is made of a blue metal.  It has nine dots on one side.\nteleporterHThis small device has a button on it and reads \"teleporter\" on the side.\rbusiness card@This business card has \"synacor.com\" printed in red on one side.\x03orb=This is a clear glass sphere about the size of a tennis ball.\x06mirrorvThis is a rather mundane hand-held mirror from the otherwise magnificent vault room.  What USE could it possibly have?\fstrange book"
4BC5:    data    0xa87 
4BC6:    data    "The cover of this book subtly swirls with colors.  It is titled \"A Brief Introduction to Interdimensional Physics\".  It reads:\n\nRecent advances in interdimensional physics have produced fascinating\npredictions about the fundamentals of our universe!  For example,\ninterdimensional physics seems to predict that the universe is, at its root, a\npurely mathematical construct, and that all events are caused by the\ninteractions between eight pockets of energy called \"registers\".\nFurthermore, it seems that while the lower registers primarily control mundane\nthings like sound and light, the highest register (the so-called \"eighth\nregister\") is used to control interdimensional events such as teleportation.\n\nA hypothetical such teleportation device would need to have have exactly two\ndestinations.  One destination would be used when the eighth register is at its\nminimum energy level - this would be the default operation assuming the user\nhas no way to control the eighth register.  In this situation, the teleporter\nshould send the user to a preconfigured safe location as a default.\n\nThe second destination, however, is predicted to require a very specific\nenergy level in the eighth register.  The teleporter must take great care to\nconfirm that this energy level is exactly correct before teleporting its user!\nIf it is even slightly off, the user would (probably) arrive at the correct\nlocation, but would briefly experience anomalies in the fabric of reality\nitself - this is, of course, not recommended.  Any teleporter would need to test\nthe energy level in the eighth register and abort teleportation if it is not\nexactly correct.\n\nThis required precision implies that the confirmation mechanism would be very\ncomputationally expensive.  While this would likely not be an issue for large-\nscale teleporters, a hypothetical hand-held teleporter would take billions of\nyears to compute the result and confirm that the eighth register is correct.\n\nIf you find yourself trapped in an alternate dimension with nothing but a\nhand-held teleporter, you will need to extract the confirmation algorithm,\nreimplement it on more powerful hardware, and optimize it.  This should, at the\nvery least, allow you to determine the value of the eighth register which would\nhave been accepted by the teleporter\'s confirmation mechanism.\n\nThen, set the eighth register to this value, activate the teleporter, and\nbypass the confirmation mechanism.  If the eighth register is set correctly, no\nanomalies should be experienced, but beware - if it is set incorrectly, the\nnow-bypassed confirmation mechanism will not protect you!\n\nOf course, since teleportation is impossible, this is all totally ridiculous.\ajournal"
5655:    data    0xeb4 
5656:    data    "Fireflies were using this dusty old journal as a resting spot until you scared them off.  It reads:\n\nDay 1: We have reached what seems to be the final in a series of puzzles guarding an ancient treasure.  I suspect most adventurers give up long before this point, but we\'re so close!  We must press on!\n\nDay 1: P.S.: It\'s a good thing the island is tropical.  We should have food for weeks!\n\nDay 2: The vault appears to be sealed by a mysterious force - the door won\'t budge an inch.  We don\'t have the resources to blow it open, and I wouldn\'t risk damaging the contents even if we did.  We\'ll have to figure out the lock mechanism.\n\nDay 3: The door to the vault has a number carved into it.  Each room leading up to the vault has more numbers or symbols embedded in mosaics in the floors.  We even found a strange glass orb in the antechamber on a pedestal itself labeled with a number.  What could they mean?\n\nDay 5: We finally built up the courage to touch the strange orb in the antechamber.  It flashes colors as we carry it from room to room, and sometimes the symbols in the rooms flash colors as well.  It simply evaporates if we try to leave with it, but another appears on the pedestal in the antechamber shortly thereafter.  It also seems to do this even when we return with it to the antechamber from the other rooms.\n\nDay 8: When the orb is carried to the vault door, the numbers on the door flash black, and then the orb evaporates.  Did we do something wrong?  Doesn\'t the door like us?  We also found a small hourglass near the door, endlessly running.  Is it waiting for something?\n\nDay 13: Some of my crew swear the orb actually gets heaver or lighter as they walk around with it.  Is that even possible?  They say that if they walk through certain rooms repeatedly, they feel it getting lighter and lighter, but it eventually just evaporates and a new one appears as usual.\n\nDay 21: Now I can feel the orb changing weight as I walk around.  It depends on the area - the change is very subtle in some places, but certainly more noticeable in others, especially when I walk into a room with a larger number or out of a room marked \'*\'.  Perhaps we can actually control the weight of this mysterious orb?\n\nDay 34: One of the crewmembers was wandering the rooms today and claimed that the numbers on the door flashed white as he approached!  He said the door still didn\'t open, but he noticed that the hourglass had run out and flashed black.  When we went to check on it, it was still running like it always does.  Perhaps he is going mad?  If not, which do we need to appease: the door or the hourglass?  Both?\n\nDay 55: The fireflies are getting suspicious.  One of them looked at me funny today and then flew off.  I think I saw another one blinking a little faster than usual.  Or was it a little slower?  We are getting better at controlling the weight of the orb, and we think that\'s what the numbers are all about.  The orb starts at the weight labeled on the pedestal, and goes down as we leave a room marked \'-\', up as we leave a room marked \'+\', and up even more as we leave a room marked \'*\'.  Entering rooms with larger numbers has a greater effect.\n\nDay 89: Every once in a great while, one of the crewmembers has the same story: that the door flashes white, the hourglass had already run out, it flashes black, and the orb evaporates.  Are we too slow?  We can\'t seem to find a way to make the orb\'s weight match what the door wants before the hourglass runs out.  If only we could find a shorter route through the rooms...\n\nDay 144: We are abandoning the mission.  None of us can work out the solution to the puzzle.  I will leave this journal here to help future adventurers, though I am not sure what help it will give.  Good luck!4abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\x17dbqpwuiolxv8WTYUIOAHXVM\x02go\x04look\x04help\x03inv\x04take\x04drop\x03use\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x05green\x03red\x06yellow?As you enter the room, the symbol on the floor briefly flashes !.  The orb begins subtly glowing /As you enter the room, the orb briefly flashes @.  The number on the floor vibrates strangely beneath your feet.\x1f  The orb seems to get heavier.\x1f  The orb seems to get lighter.\x15  The orb shatters!\n\n As you approach the vault door, +the number on the vault door flashes black.)  The orb evaporates out of your hands.\n\n+the number on the vault door flashes white!c  The hourglass has already run out.  It flashes black and flips over, restarting the flow of sand."
67D8:    data    0x84 
67D9:    data    "  The hourglass is still running!  It flashes white!  You hear a click from the vault door.  The orb evaporates out of hour hands.\n\n\aAs you \x05leave\x05enterV the room, the orb evaporates out of your hands!  It rematerializes on its pedestal.\n\n\x1aThe vault door is sealed.\n0"
68E4:    data    0x34aa 0x3496 0x349b 0x34de 0x348d 0x349b 0x3492 0x3498 0x34d3 0x348a 0x349b 0x348d 0x348a 0x34de 0x349d 0x3491 
68F4:    data    0x3493 0x348e 0x3492 0x349b 0x348a 0x3497 0x3491 0x3490 0x34de 0x349d 0x3491 0x349a 0x349b 0x34de 0x3497 0x348d 
6904:    data    0x34c4 0x34de 0x34ad 0x348d 0x34af 0x34ba 0x3496 0x34ac 0x34b7 0x348f 0x34a9 0x34b0 0x34b6 0x348c 0x34f4 0x34f4 
6914:    data    "\x02"
6915:    data    0x18c0 0x18c8 
6917:    data    "\x02"
6918:    data    0x917 0x912 
691A:    data    "\x01"
691B:    data    0x1923 
691C:    data    "\x01"
691D:    data    0x90d 
691E:    data    "\x02"
691F:    data    0x19b9 0x19bf 
6921:    data    "\x02"
6922:    data    0x91c 0x90d 
6924:    data    "\x02"
6925:    data    0x1a2b 0x1a31 
6927:    data    "\x02"
6928:    data    0x921 0x917 
692A:    data    "\x02"
692B:    data    0x1afd 0x1b04 
692D:    data    "\x02"
692E:    data    0x926 0x917 
6930:    data    "\x02"
6931:    data    0x1b90 0x1b99 
6933:    data    "\x02"
6934:    data    0x92b 0x921 
6936:    data    "\x01"
6937:    data    0x1c61 
6938:    data    "\x01"
6939:    data    0x930 
693A:    data    "\x02"
693B:    data    0x1d44 0x1d49 
693D:    data    "\x02"
693E:    data    0x93a 0x935 
6940:    data    "\x01"
6941:    data    0x1dbb 
6942:    data    "\x01"
6943:    data    0x930 
6944:    data    "\x02"
6945:    data    0x1e6a 0x1e6f 
6947:    data    "\x02"
6948:    data    0x930 0x93f 
694A:    data    "\x03"
694B:    data    0x1f30 0x1f37 0x1f3e 
694E:    data    "\x03"
694F:    data    0x93a 0x949 0x944 
6952:    data    "\x02"
6953:    data    0x1f4f 0x1f89 
6955:    data    "\x02"
6956:    data    0x1fd5 0x1fde 
6958:    data    "\x02"
6959:    data    0x97b 0x93f 
695B:    data    "\x05"
695C:    data    0x206f 0x2076 0x207c 0x2082 0x2087 
6961:    data    "\x05"
6962:    data    0x93f 0x94e 0x953 0x958 0x95d 
6967:    data    "\x03"
6968:    data    0x20d4 0x20da 0x20e0 
696B:    data    "\x03"
696C:    data    0x953 0x949 0x94e 
696F:    data    "\x03"
6970:    data    0x212d 0x2133 0x2139 
6973:    data    "\x03"
6974:    data    0x949 0x94e 0x953 
6977:    data    "\x04"
6978:    data    0x21cb 0x21d1 0x21d7 0x21dc 
697C:    data    "\x04"
697D:    data    0x967 0x958 0x949 0x976 
6981:    data    "\x03"
6982:    data    0x2229 0x222f 0x2235 
6985:    data    "\x03"
6986:    data    0x95d 0x962 0x949 
6989:    data    "\x04"
698A:    data    0x22ce 0x22d4 0x22da 0x22df 
698E:    data    "\x04"
698F:    data    0x96c 0x94e 0x953 0x976 
6993:    data    "\x03"
6994:    data    0x232c 0x2332 0x2337 
6997:    data    "\x03"
6998:    data    0x953 0x94e 0x967 
699B:    data    "\x01"
699C:    data    0x2385 
699D:    data    "\x01"
699E:    data    0x949 
699F:    data    "\x01"
69A0:    data    0x23d2 
69A1:    data    "\x01"
69A2:    data    0x949 
69A3:    data    "\x02"
69A4:    data    0x241f 0x2425 
69A6:    data    "\x02"
69A7:    data    0x953 0x94e 
69A9:    data    "\x02"
69AA:    data    0x24ab 0x24b0 
69AC:    data    "\x02"
69AD:    data    0x980 0x944 
69AF:    data    "\x02"
69B0:    data    0x24e5 0x24ea 
69B2:    data    "\x02"
69B3:    data    0x97b 0x985 
69B5:    data    "\x02"
69B6:    data    0x251f 0x2524 
69B8:    data    "\x02"
69B9:    data    0x980 0x98a 
69BB:    data    "\x02"
69BC:    data    0x259b 0x25a0 
69BE:    data    "\x02"
69BF:    data    0x985 0x98f 
69C1:    data    "\x02"
69C2:    data    0x26a4 0x26a9 
69C4:    data    "\x02"
69C5:    data    0x98a 0x994 
69C7:    data    "\x02"
69C8:    data    0x276b 0x2771 
69CA:    data    "\x02"
69CB:    data    0x999 0x98f 
69CD:    data    "\x04"
69CE:    data    0x28a3 0x28a9 0x28af 0x28b4 
69D2:    data    "\x04"
69D3:    data    0x99f 0x994 0x9a4 0x9ae 
69D7:    data    "\x05"
69D8:    data    0x10b 0x10f 0x113 0x119 0x11f 
69DD:    data    "\x05\0\0\0\0\0\x01"
69E4:    data    0x2967 
69E5:    data    "\x01"
69E6:    data    0x999 
69E7:    data    "\x02"
69E8:    data    0x29fe 0x2a03 
69EA:    data    "\x02"
69EB:    data    0x9a9 0x999 
69ED:    data    "\x01"
69EE:    data    0x2a89 
69EF:    data    "\x01"
69F0:    data    0x9a4 
69F1:    data    "\x02"
69F2:    data    0x2b46 0x2b49 
69F4:    data    "\x02"
69F5:    data    0x9b3 0x999 
69F7:    data    "\x01"
69F8:    data    0x2bfe 
69F9:    data    "\x01"
69FA:    data    0x9ae 
69FB:    data    "\x01"
69FC:    data    0x2d18 
69FD:    data    "\x01"
69FE:    data    0x9bd 
69FF:    data    "\x01"
6A00:    data    0x2dc7 
6A01:    data    "\x01"
6A02:    data    0x9b8 
6A03:    data    "\x03"
6A04:    data    0x2e7f 0x2e84 0x2e89 
6A07:    data    "\x03"
6A08:    data    0x9c7 0x9cc 0x9d1 
6A0B:    data    "\x02"
6A0C:    data    0x2f9c 0x2fa1 
6A0E:    data    "\x02"
6A0F:    data    0x9c2 0x9d1 
6A11:    data    "\x02"
6A12:    data    0x30a0 0x30a5 
6A14:    data    "\x02"
6A15:    data    0x9c2 0x9d6 
6A17:    data    "\x03"
6A18:    data    0x3182 0x3188 0x318e 
6A1B:    data    "\x03"
6A1C:    data    0x9db 0x9c2 0x9d6 
6A1F:    data    "\x03"
6A20:    data    0x321e 0x3224 0x322a 
6A23:    data    "\x03"
6A24:    data    0x9db 0x9cc 0x9d1 
6A27:    data    "\x02"
6A28:    data    0x3326 0x332c 
6A2A:    data    "\x02"
6A2B:    data    0x9e0 0x9d1 
6A2D:    data    "\x02"
6A2E:    data    0x3460 0x3466 
6A30:    data    "\x02"
6A31:    data    0x9e5 0x9db 
6A33:    data    "\x02"
6A34:    data    0x3572 0x3578 
6A36:    data    "\x02"
6A37:    data    0x9ea 0x9e0 
6A39:    data    "\x02"
6A3A:    data    0x3669 0x366f 
6A3C:    data    "\x02"
6A3D:    data    0x9ef 0x9e5 
6A3F:    data    "\x02"
6A40:    data    0x36fe 0x3704 
6A42:    data    "\x02"
6A43:    data    0x9f4 0x9ea 
6A45:    data    "\x03"
6A46:    data    0x385b 0x3861 0x3867 
6A49:    data    "\x03"
6A4A:    data    0x9fe 0x9ef 0x9f9 
6A4D:    data    "\x01"
6A4E:    data    0x3925 
6A4F:    data    "\x01"
6A50:    data    0x9f4 
6A51:    data    "\x02"
6A52:    data    0x39a1 0x39a7 
6A54:    data    "\x02"
6A55:    data    0xa3f 0x9f4 
6A57:    data    "\x02"
6A58:    data    0x3a39 0x3a3e 
6A5A:    data    "\x02"
6A5B:    data    0xa08 0xa17 
6A5D:    data    "\x03"
6A5E:    data    0x3ad2 0x3ad7 0x3add 
6A61:    data    "\x03"
6A62:    data    0xa0d 0xa1c 0xa03 
6A65:    data    "\x03"
6A66:    data    0x3b6e 0x3b73 0x3b79 
6A69:    data    "\x03"
6A6A:    data    0xa12 0xa21 0xa08 
6A6D:    data    "\x03"
6A6E:    data    0x3c80 0x3c86 0x3c8b 
6A71:    data    "\x03"
6A72:    data    0xa26 0xa0d 0xa53 
6A75:    data    "\x03"
6A76:    data    0x3d1f 0x3d25 0x3d2a 
6A79:    data    "\x03"
6A7A:    data    0xa03 0xa1c 0xa2b 
6A7D:    data    "\x04"
6A7E:    data    0x3dbc 0x3dc2 0x3dc7 0x3dcd 
6A82:    data    "\x04"
6A83:    data    0xa08 0xa21 0xa30 0xa17 
6A87:    data    "\x04"
6A88:    data    0x3e61 0x3e67 0x3e6c 0x3e72 
6A8C:    data    "\x04"
6A8D:    data    0xa0d 0xa26 0xa35 0xa1c 
6A91:    data    "\x03"
6A92:    data    0x3f03 0x3f09 0x3f0f 
6A95:    data    "\x03"
6A96:    data    0xa12 0xa3a 0xa21 
6A99:    data    "\x03"
6A9A:    data    0x3fa0 0x3fa6 0x3fab 
6A9D:    data    "\x03"
6A9E:    data    0xa17 0xa30 0xa3f 
6AA1:    data    "\x04"
6AA2:    data    0x403f 0x4045 0x404a 0x4050 
6AA6:    data    "\x04"
6AA7:    data    0xa1c 0xa35 0xa44 0xa2b 
6AAB:    data    "\x04"
6AAC:    data    0x40e1 0x40e7 0x40ec 0x40f2 
6AB0:    data    "\x04"
6AB1:    data    0xa21 0xa3a 0xa49 0xa30 
6AB5:    data    "\x03"
6AB6:    data    0x4186 0x418c 0x4192 
6AB9:    data    "\x03"
6ABA:    data    0xa26 0xa4e 0xa35 
6ABD:    data    "\x03"
6ABE:    data    0x423a 0x4240 0x4245 
6AC1:    data    "\x03"
6AC2:    data    0xa2b 0xa44 0x9fe 
6AC5:    data    "\x03"
6AC6:    data    0x42d7 0x42dd 0x42e2 
6AC9:    data    "\x03"
6ACA:    data    0xa30 0xa49 0xa3f 
6ACD:    data    "\x03"
6ACE:    data    0x4375 0x437b 0x4380 
6AD1:    data    "\x03"
6AD2:    data    0xa35 0xa4e 0xa44 
6AD5:    data    "\x02"
6AD6:    data    0x4411 0x4417 
6AD8:    data    "\x02"
6AD9:    data    0xa3a 0xa49 
6ADB:    data    "\x01"
6ADC:    data    0x44f7 
6ADD:    data    "\x01"
6ADE:    data    0xa12 
6ADF:    data    "\x02"
6AE0:    data    0x4581 0x4589 
6AE2:    data    "\x02"
6AE3:    data    0xa5d 0xa5d 
6AE5:    data    "\x02"
6AE6:    data    0x460d 0x4611 
6AE8:    data    "\x02"
6AE9:    data    0xa62 0xa62 
6AEB:    data    "\x03"
6AEC:    data    0x4679 0x467d 0x4682 
6AEF:    data    "\x03"
6AF0:    data    0xa67 0xa67 0xa67 
6AF3:    data    "\0\0\x10"
6AF6:    data    0xa6c 0xa70 0xa74 0xa78 0xa7c 0xa80 0xa84 0xa88 0xa8c 0xa90 0xa94 0xa98 0xaa4 0xaa8 0xa9c 0xaa0 
6B06:    data    "\a"
6B07:    data    0x6557 0x655a 0x655f 0x6564 0x6568 0x656d 0x6572 
6B0E:    data    "\a"
6B0F:    data    0xcad 0xb94 0xd05 0xd22 0xd48 0xda0 0xdf0 
6B16:    data    "\x11"
6B17:    data    0xbfb 0xba6 0xb99 0xb90 0xb85 0xbd1 0xb95 0xb9e 0xbd1 0xb88 0xb9e 0xb84 0xbd1 0xb95 0xb9e 0xbce 
6B27:    data    0xbfb 
6B28:    data    "\x16"
6B29:    data    0xc3e 0xc08 0xc12 0xc47 0xc14 0xc02 0xc02 0xc47 0xc09 0xc08 0xc47 0xc14 0xc12 0xc04 0xc0f 0xc47 
6B39:    data    0xc0e 0xc13 0xc02 0xc0a 0xc49 0xc6d 
6B3F:    data    "\x1a"
6B40:    data    0x38f1 0x38af 0x3893 0x3892 0x3895 0x389c 0x3888 0x38db 0x3894 0x389d 0x38db 0x3892 0x3895 0x388f 0x389e 0x3889 
6B50:    data    0x389e 0x3888 0x388f 0x38db 0x3893 0x389e 0x3889 0x389e 0x38c1 0x38f1 
6B5A:    data    "1"
6B5B:    data    0x6da2 0x6dcb 0x6d8f 0x6d84 0x6d85 0x6dcc 0x6d9f 0x6dcb 0x6d9e 0x6d85 0x6d8f 0x6d8e 0x6d99 0x6d98 0x6d9f 0x6d8a 
6B6B:    data    0x6d85 0x6d8f 0x6dd0 0x6dcb 0x6d9f 0x6d99 0x6d92 0x6dcb 0x6dcc 0x6d83 0x6d8e 0x6d87 0x6d9b 0x6dcc 0x6dcb 0x6d8d 
6B7B:    data    0x6d84 0x6d99 0x6dcb 0x6d82 0x6d85 0x6d98 0x6d9f 0x6d99 0x6d9e 0x6d88 0x6d9f 0x6d82 0x6d84 0x6d85 0x6d98 0x6dc5 
6B8B:    data    0x6de1 0x1f8 0x3c94 0x3c97 0x3c97 0x3c93 0x3cf2 0x3cd8 0x3cd8 0x3ca1 0x3c97 0x3c8d 0x3cd8 0x3c95 0x3c99 0x3c81 
6B9B:    data    0x3cd8 0x3c95 0x3c9d 0x3c8a 0x3c9d 0x3c94 0x3c81 0x3cd8 0x3cdf 0x3c94 0x3c97 0x3c97 0x3c93 0x3cdf 0x3cd8 0x3c8c 
6BAB:    data    0x3c97 0x3cd8 0x3c9d 0x3c80 0x3c99 0x3c95 0x3c91 0x3c96 0x3c9d 0x3cd8 0x3c8c 0x3c90 0x3c9d 0x3cd8 0x3c8a 0x3c97 
6BBB:    data    0x3c97 0x3c95 0x3cd4 0x3cd8 0x3c97 0x3c8a 0x3cd8 0x3c81 0x3c97 0x3c8d 0x3cd8 0x3c95 0x3c99 0x3c81 0x3cd8 0x3cdf 
6BCB:    data    0x3c94 0x3c97 0x3c97 0x3c93 0x3cd8 0x3cc4 0x3c8b 0x3c8d 0x3c9a 0x3c92 0x3c9d 0x3c9b 0x3c8c 0x3cc6 0x3cdf 0x3cd8 
6BDB:    data    0x3cd0 0x3c8b 0x3c8d 0x3c9b 0x3c90 0x3cd8 0x3c99 0x3c8b 0x3cd8 0x3cdf 0x3c94 0x3c97 0x3c97 0x3c93 0x3cd8 0x3c9b 
6BEB:    data    0x3c90 0x3c99 0x3c91 0x3c8a 0x3cdf 0x3cd1 0x3cd8 0x3c8c 0x3c97 0x3cd8 0x3c9d 0x3c80 0x3c99 0x3c95 0x3c91 0x3c96 
6BFB:    data    0x3c9d 0x3cd8 0x3c8b 0x3c97 0x3c95 0x3c9d 0x3c8c 0x3c90 0x3c91 0x3c96 0x3c9f 0x3cd8 0x3c8b 0x3c88 0x3c9d 0x3c9b 
6C0B:    data    0x3c91 0x3c9e 0x3c91 0x3c9b 0x3cd6 0x3cf2 0x3c9f 0x3c97 0x3cf2 0x3cd8 0x3cd8 0x3ca1 0x3c97 0x3c8d 0x3cd8 0x3c95 
6C1B:    data    0x3c99 0x3c81 0x3cd8 0x3cdf 0x3c9f 0x3c97 0x3cd8 0x3cc4 0x3c9d 0x3c80 0x3c91 0x3c8c 0x3cc6 0x3cdf 0x3cd8 0x3c8c 
6C2B:    data    0x3c97 0x3cd8 0x3c8c 0x3c8a 0x3c99 0x3c8e 0x3c9d 0x3c94 0x3cd8 0x3c91 0x3c96 0x3cd8 0x3c8c 0x3c90 0x3c99 0x3c8c 
6C3B:    data    0x3cd8 0x3c9c 0x3c91 0x3c8a 0x3c9d 0x3c9b 0x3c8c 0x3c91 0x3c97 0x3c96 0x3cd8 0x3cd0 0x3c8b 0x3c8d 0x3c9b 0x3c90 
6C4B:    data    0x3cd8 0x3c99 0x3c8b 0x3cd8 0x3cdf 0x3c9f 0x3c97 0x3cd8 0x3c8f 0x3c9d 0x3c8b 0x3c8c 0x3cdf 0x3cd1 0x3cd4 0x3cd8 
6C5B:    data    0x3c97 0x3c8a 0x3cd8 0x3c81 0x3c97 0x3c8d 0x3cd8 0x3c95 0x3c99 0x3c81 0x3cd8 0x3c95 0x3c9d 0x3c8a 0x3c9d 0x3c94 
6C6B:    data    0x3c81 0x3cd8 0x3cdf 0x3cc4 0x3c9d 0x3c80 0x3c91 0x3c8c 0x3cc6 0x3cdf 0x3cd8 0x3cd0 0x3c8b 0x3c8d 0x3c9b 0x3c90 
6C7B:    data    0x3cd8 0x3c99 0x3c8b 0x3cd8 0x3cdf 0x3c8f 0x3c9d 0x3c8b 0x3c8c 0x3cdf 0x3cd1 0x3cd6 0x3cf2 0x3c91 0x3c96 0x3c8e 
6C8B:    data    0x3cf2 0x3cd8 0x3cd8 0x3cac 0x3c97 0x3cd8 0x3c8b 0x3c9d 0x3c9d 0x3cd8 0x3c8c 0x3c90 0x3c9d 0x3cd8 0x3c9b 0x3c97 
6C9B:    data    0x3c96 0x3c8c 0x3c9d 0x3c96 0x3c8c 0x3c8b 0x3cd8 0x3c97 0x3c9e 0x3cd8 0x3c81 0x3c97 0x3c8d 0x3c8a 0x3cd8 0x3c91 
6CAB:    data    0x3c96 0x3c8e 0x3c9d 0x3c96 0x3c8c 0x3c97 0x3c8a 0x3c81 0x3cd4 0x3cd8 0x3c95 0x3c9d 0x3c8a 0x3c9d 0x3c94 0x3c81 
6CBB:    data    0x3cd8 0x3cdf 0x3c91 0x3c96 0x3c8e 0x3cdf 0x3cd6 0x3cf2 0x3c8c 0x3c99 0x3c93 0x3c9d 0x3cf2 0x3cd8 0x3cd8 0x3ca1 
6CCB:    data    0x3c97 0x3c8d 0x3cd8 0x3c95 0x3c99 0x3c81 0x3cd8 0x3cdf 0x3c8c 0x3c99 0x3c93 0x3c9d 0x3cd8 0x3cc4 0x3c91 0x3c8c 
6CDB:    data    0x3c9d 0x3c95 0x3cc6 0x3cdf 0x3cd8 0x3cd0 0x3c8b 0x3c8d 0x3c9b 0x3c90 0x3cd8 0x3c99 0x3c8b 0x3cd8 0x3cdf 0x3c8c 
6CEB:    data    0x3c99 0x3c93 0x3c9d 0x3cd8 0x3c94 0x3c99 0x3c8a 0x3c9f 0x3c9d 0x3cd8 0x3c8a 0x3c97 0x3c9b 0x3c93 0x3cdf 0x3cd1 
6CFB:    data    0x3cd6 0x3cf2 0x3c9c 0x3c8a 0x3c97 0x3c88 0x3cf2 0x3cd8 0x3cd8 0x3cac 0x3c97 0x3cd8 0x3c9c 0x3c8a 0x3c97 0x3c88 
6D0B:    data    0x3cd8 0x3c8b 0x3c97 0x3c95 0x3c9d 0x3c8c 0x3c90 0x3c91 0x3c96 0x3c9f 0x3cd8 0x3c91 0x3c96 0x3cd8 0x3c81 0x3c97 
6D1B:    data    0x3c8d 0x3c8a 0x3cd8 0x3c91 0x3c96 0x3c8e 0x3c9d 0x3c96 0x3c8c 0x3c97 0x3c8a 0x3c81 0x3cd4 0x3cd8 0x3c81 0x3c97 
6D2B:    data    0x3c8d 0x3cd8 0x3c95 0x3c99 0x3c81 0x3cd8 0x3cdf 0x3c9c 0x3c8a 0x3c97 0x3c88 0x3cd8 0x3cc4 0x3c91 0x3c8c 0x3c9d 
6D3B:    data    0x3c95 0x3cc6 0x3cdf 0x3cd6 0x3cf2 0x3c8d 0x3c8b 0x3c9d 0x3cf2 0x3cd8 0x3cd8 0x3ca1 0x3c97 0x3c8d 0x3cd8 0x3c95 
6D4B:    data    0x3c99 0x3c81 0x3cd8 0x3c99 0x3c9b 0x3c8c 0x3c91 0x3c8e 0x3c99 0x3c8c 0x3c9d 0x3cd8 0x3c97 0x3c8a 0x3cd8 0x3c97 
6D5B:    data    0x3c8c 0x3c90 0x3c9d 0x3c8a 0x3c8f 0x3c91 0x3c8b 0x3c9d 0x3cd8 0x3c99 0x3c88 0x3c88 0x3c94 0x3c81 0x3cd8 0x3c99 
6D6B:    data    0x3c96 0x3cd8 0x3c91 0x3c8c 0x3c9d 0x3c95 0x3cd8 0x3c8f 0x3c91 0x3c8c 0x3c90 0x3cd8 0x3cdf 0x3c8d 0x3c8b 0x3c9d 
6D7B:    data    0x3cd8 0x3cc4 0x3c91 0x3c8c 0x3c9d 0x3c95 0x3cc6 0x3cdf 0x3cd6 0x3cf2 
6D85:    data    "\x10"
6D86:    data    0x7420 0x7416 0x740c 0x740b 0x7459 0x7410 0x7417 0x740f 0x741c 0x7417 0x740d 0x7416 0x740b 0x7400 0x7443 0x7473 
6D96:    data    "\a"
6D97:    data    0x6fb2 0x6f87 0x6f8d 0x6f83 0x6f88 0x6fc8 0x6fec 
6D9E:    data    "\x1b"
6D9F:    data    0x47aa 0x479c 0x4786 0x47d3 0x4780 0x4796 0x4796 0x47d3 0x479d 0x479c 0x47d3 0x4780 0x4786 0x4790 0x479b 0x47d3 
6DAF:    data    0x479a 0x4787 0x4796 0x479e 0x47d3 0x479b 0x4796 0x4781 0x4796 0x47dd 0x47f9 
6DBA:    data    "\t"
6DBB:    data    0x1eb0 0x1e86 0x1e9b 0x1e84 0x1e84 0x1e91 0x1e90 0x1eda 0x1efe 
6DC4:    data    "\""
6DC5:    data    0x5a32 0x5a04 0x5a1e 0x5a4b 0x5a08 0x5a0a 0x5a05 0x5a4c 0x5a1f 0x5a4b 0x5a0d 0x5a02 0x5a05 0x5a0f 0x5a4b 0x5a1f 
6DD5:    data    0x5a03 0x5a0a 0x5a1f 0x5a4b 0x5a02 0x5a05 0x5a4b 0x5a12 0x5a04 0x5a1e 0x5a19 0x5a4b 0x5a1b 0x5a0a 0x5a08 0x5a00 
6DE5:    data    0x5a45 0x5a61 
6DE7:    data    "\""
6DE8:    data    0x3739 0x370f 0x3715 0x3740 0x3703 0x3701 0x370e 0x3747 0x3714 0x3740 0x3706 0x3709 0x370e 0x3704 0x3740 0x3714 
6DF8:    data    0x3708 0x3701 0x3714 0x3740 0x3709 0x370e 0x3740 0x3719 0x370f 0x3715 0x3712 0x3740 0x3710 0x3701 0x3703 0x370b 
6E08:    data    0x374e 0x376a 
6E0A:    data    "!"
6E0B:    data    0x242f 0x2419 0x2403 0x2456 0x2417 0x2404 0x2413 0x2418 0x2451 0x2402 0x2456 0x2405 0x2403 0x2404 0x2413 0x2456 
6E1B:    data    0x241e 0x2419 0x2401 0x2456 0x2402 0x2419 0x2456 0x2403 0x2405 0x2413 0x2456 0x2402 0x241e 0x2417 0x2402 0x2458 
6E2B:    data    0x247c 
6E2C:    data    "\x1f"
6E2D:    data    0x4839 0x480f 0x4815 0x4840 0x4808 0x4801 0x4816 0x4805 0x4840 0x4802 0x4805 0x4805 0x480e 0x4840 0x4805 0x4801 
6E3D:    data    0x4814 0x4805 0x480e 0x4840 0x4802 0x4819 0x4840 0x4801 0x4840 0x4807 0x4812 0x4815 0x4805 0x484e 0x486a 
6E4C:    data    ">"
6E4D:    data    0x40a4 0x408f 0x408e 0x4094 0x4082 0x408b 0x4082 0x4083 0x40c7 0x4088 0x4089 0x40c7 0x4093 0x408f 0x4082 0x40c7 
6E5D:    data    0x4090 0x4086 0x408b 0x408b 0x40c7 0x4088 0x4081 0x40c7 0x4088 0x4089 0x4082 0x40c7 0x4088 0x4081 0x40c7 0x4093 
6E6D:    data    0x408f 0x4082 0x40c7 0x4097 0x4086 0x4094 0x4094 0x4086 0x4080 0x4082 0x4090 0x4086 0x409e 0x4094 0x40cb 0x40c7 
6E7D:    data    0x409e 0x4088 0x4092 0x40c7 0x4094 0x4082 0x4082 0x40dd 0x40ed 0x40ed 0x40c7 0x40c7 0x40c7 0x40c7 
6E8B:    data    "\x03"
6E8C:    data    0x417f 0x5fbf 0x26bd 
6E8F:    data    "+"
6E90:    data    0x6be0 0x6be0 0x6bb3 0x6b85 0x6b9f 0x6bca 0x6b9e 0x6b8b 0x6b81 0x6b8f 0x6bca 0x6b84 0x6b85 0x6b9e 0x6b8f 0x6bca 
6EA0:    data    0x6b85 0x6b8c 0x6bca 0x6b9e 0x6b82 0x6b83 0x6b99 0x6bca 0x6b8b 0x6b84 0x6b8e 0x6bca 0x6b81 0x6b8f 0x6b8f 0x6b9a 
6EB0:    data    0x6bca 0x6b9d 0x6b8b 0x6b86 0x6b81 0x6b83 0x6b84 0x6b8d 0x6bc4 0x6be0 0x6be0 
6EBB:    data    "\x15"
6EBC:    data    0x4237 0x420b 0x4202 0x4217 0x4243 0x4207 0x420c 0x420c 0x4211 0x4243 0x420a 0x4210 0x4243 0x420f 0x420c 0x4200 
6ECC:    data    0x4208 0x4206 0x4207 0x424d 0x4269 
6ED1:    data    "\x1b"
6ED2:    data    0x69b7 0x6981 0x699b 0x69ce 0x6988 0x6987 0x6980 0x698a 0x69ce 0x6997 0x6981 0x699b 0x699c 0x699d 0x698b 0x6982 
6EE2:    data    0x6988 0x69ce 0x6999 0x699c 0x6987 0x699a 0x6987 0x6980 0x6989 0x69ce 0x69cc 
6EED:    data    "\x03"
6EEE:    data    0x7210 0xbf0 0x163c 
6EF1:    data    "3"
6EF2:    data    0x474d 0x474f 0x4700 0x4701 0x474f 0x471b 0x4707 0x470a 0x474f 0x471b 0x470e 0x470d 0x4703 0x470a 0x471b 0x4741 
6F02:    data    0x474f 0x474f 0x473f 0x470a 0x471d 0x4707 0x470e 0x471f 0x471c 0x474f 0x4706 0x471b 0x4748 0x471c 0x474f 0x471c 
6F12:    data    0x4700 0x4702 0x470a 0x474f 0x4704 0x4706 0x4701 0x470b 0x474f 0x4700 0x4709 0x474f 0x470c 0x4700 0x470b 0x470a 
6F22:    data    0x4750 0x4765 0x4765 
6F25:    data    "8"
6F26:    data    0x624 0x612 0x608 0x65d 0x61b 0x614 0x611 0x611 0x65d 0x604 0x612 0x608 0x60f 0x65d 0x611 0x61c 
6F36:    data    0x613 0x609 0x618 0x60f 0x613 0x65d 0x60a 0x614 0x609 0x615 0x65d 0x612 0x614 0x611 0x653 0x65d 
6F46:    data    0x65d 0x634 0x609 0x65d 0x60e 0x618 0x618 0x610 0x60e 0x65d 0x609 0x612 0x65d 0x61e 0x615 0x618 
6F56:    data    0x618 0x60f 0x65d 0x608 0x60d 0x65c 0x677 0x677 
6F5E:    data    ":"
6F5F:    data    0x4d36 0x4d00 0x4d1a 0x4d48 0x4d03 0x4d03 0x4d4f 0x4d07 0x4d0e 0x4d19 0x4d0a 0x4d4f 0x4d1b 0x4d00 0x4d4f 0x4d09 
6F6F:    data    0x4d06 0x4d01 0x4d0b 0x4d4f 0x4d1c 0x4d00 0x4d02 0x4d0a 0x4d1b 0x4d07 0x4d06 0x4d01 0x4d08 0x4d4f 0x4d1b 0x4d00 
6F7F:    data    0x4d4f 0x4d1f 0x4d1a 0x4d1b 0x4d4f 0x4d1b 0x4d07 0x4d0a 0x4d4f 0x4d00 0x4d06 0x4d03 0x4d4f 0x4d06 0x4d01 0x4d1b 
6F8F:    data    0x4d00 0x4d4f 0x4d09 0x4d06 0x4d1d 0x4d1c 0x4d1b 0x4d41 0x4d65 0x4d65 
6F99:    data    "\x19"
6F9A:    data    0x28ae 0x2898 0x2882 0x28d7 0x289b 0x289e 0x2890 0x289f 0x2883 0x28d7 0x288e 0x2898 0x2882 0x2885 0x28d7 0x289b 
6FAA:    data    0x2896 0x2899 0x2883 0x2892 0x2885 0x2899 0x28d9 0x28fd 0x28fd 
6FB3:    data    "\x19"
6FB4:    data    0x21bd 0x218b 0x2191 0x21c4 0x2180 0x218b 0x2191 0x2197 0x2181 0x21c4 0x219d 0x218b 0x2191 0x2196 0x21c4 0x2188 
6FC4:    data    0x2185 0x218a 0x2190 0x2181 0x2196 0x218a 0x21ca 0x21ee 0x21ee 
6FCD:    data    "*"
6FCE:    data    0x72a7 0x7291 0x728b 0x72d9 0x728c 0x729b 0x72de 0x7290 0x7291 0x728a 0x72de 0x728d 0x728b 0x728c 0x729b 0x72de 
6FDE:    data    0x7289 0x7296 0x729f 0x728a 0x72de 0x728a 0x7291 0x72de 0x729a 0x7291 0x72de 0x7289 0x7297 0x728a 0x7296 0x72de 
6FEE:    data    0x728a 0x7296 0x729b 0x72de 0x729d 0x7291 0x7297 0x7290 0x72d0 0x72f4 
6FF8:    data    "\x0e"
6FF9:    data    0x15b8 0x158e 0x1594 0x15c1 0x1591 0x158d 0x1580 0x1582 0x1584 0x15c1 0x1595 0x1589 0x1584 0x15c1 
7007:    data    "\x1e"
7008:    data    0x7246 0x720f 0x7208 0x7212 0x7209 0x7246 0x7212 0x720e 0x7203 0x7246 0x720a 0x7203 0x7200 0x7212 0x720b 0x7209 
7018:    data    0x7215 0x7212 0x7246 0x7209 0x7216 0x7203 0x7208 0x7246 0x7215 0x720a 0x7209 0x7212 0x7248 0x726c 
7026:    data    "B"
7027:    data    0x44a9 0x449b 0x44c8 0x4491 0x4487 0x449d 0x44c8 0x4498 0x4484 0x4489 0x448b 0x448d 0x44c8 0x449c 0x4480 0x448d 
7037:    data    0x44c8 0x4484 0x4489 0x449b 0x449c 0x44c8 0x448b 0x4487 0x4481 0x4486 0x44c4 0x44c8 0x449c 0x4480 0x448d 0x4491 
7047:    data    0x44c8 0x4489 0x449a 0x448d 0x44c8 0x4489 0x4484 0x4484 0x44c8 0x449a 0x448d 0x4484 0x448d 0x4489 0x449b 0x448d 
7057:    data    0x448c 0x44c8 0x4487 0x4486 0x449c 0x4487 0x44c8 0x449c 0x4480 0x448d 0x44c8 0x448e 0x4484 0x4487 0x4487 0x449a 
7067:    data    0x44c6 0x44e2 
7069:    data    "B"
706A:    data    0x1328 0x131a 0x1349 0x1310 0x1306 0x131c 0x1349 0x1319 0x1305 0x1308 0x130a 0x130c 0x1349 0x131d 0x1301 0x130c 
707A:    data    0x1349 0x1305 0x1308 0x131a 0x131d 0x1349 0x130a 0x1306 0x1300 0x1307 0x1345 0x1349 0x1310 0x1306 0x131c 0x1349 
708A:    data    0x1301 0x130c 0x1308 0x131b 0x1349 0x1308 0x1349 0x130a 0x1305 0x1300 0x130a 0x1302 0x1349 0x130f 0x131b 0x1306 
709A:    data    0x1304 0x1349 0x131d 0x1301 0x130c 0x1349 0x1307 0x1306 0x131b 0x131d 0x1301 0x1349 0x130d 0x1306 0x1306 0x131b 
70AA:    data    0x1347 0x1363 0xa9 0x4b5 0x4d4 0x487 0x480 0x486 0x495 0x49a 0x493 0x491 0x4d8 0x4d4 0x491 0x498 
70BA:    data    0x491 0x497 0x480 0x486 0x49b 0x49a 0x49d 0x497 0x4d4 0x482 0x49b 0x49d 0x497 0x491 0x4d4 0x49d 
70CA:    data    0x487 0x4d4 0x484 0x486 0x49b 0x49e 0x491 0x497 0x480 0x491 0x490 0x4d4 0x49d 0x49a 0x480 0x49b 
70DA:    data    0x4d4 0x48d 0x49b 0x481 0x486 0x4d4 0x499 0x49d 0x49a 0x490 0x4ce 0x4fe 0x4fe 0x4d4 0x4d4 0x4d6 
70EA:    data    0x4a1 0x49a 0x481 0x487 0x481 0x495 0x498 0x4d4 0x487 0x491 0x480 0x480 0x49d 0x49a 0x493 0x4d4 
70FA:    data    0x490 0x491 0x480 0x491 0x497 0x480 0x491 0x490 0x4d5 0x4d4 0x4d4 0x4a7 0x480 0x495 0x486 0x480 
710A:    data    0x49d 0x49a 0x493 0x4d4 0x497 0x49b 0x49a 0x492 0x49d 0x486 0x499 0x495 0x480 0x49d 0x49b 0x49a 
711A:    data    0x4d4 0x484 0x486 0x49b 0x497 0x491 0x487 0x487 0x4d5 0x4d4 0x4d4 0x4b1 0x487 0x480 0x49d 0x499 
712A:    data    0x495 0x480 0x491 0x490 0x4d4 0x480 0x49d 0x499 0x491 0x4d4 0x480 0x49b 0x4d4 0x497 0x49b 0x499 
713A:    data    0x484 0x498 0x491 0x480 0x49d 0x49b 0x49a 0x4ce 0x4d4 0x4c5 0x4d4 0x496 0x49d 0x498 0x498 0x49d 
714A:    data    0x49b 0x49a 0x4d4 0x48d 0x491 0x495 0x486 0x487 0x4da 0x4d6 0x4fe 0x4fe 0xe2 0x2eab 0x2e9d 0x2e87 
715A:    data    0x2ed2 0x2e85 0x2e93 0x2e99 0x2e97 0x2ed2 0x2e87 0x2e82 0x2ed2 0x2e9d 0x2e9c 0x2ed2 0x2e93 0x2ed2 0x2e81 0x2e93 
716A:    data    0x2e9c 0x2e96 0x2e8b 0x2ed2 0x2e90 0x2e97 0x2e93 0x2e91 0x2e9a 0x2ed2 0x2e85 0x2e9b 0x2e86 0x2e9a 0x2ed2 0x2e93 
717A:    data    0x2ed2 0x2e81 0x2e9e 0x2e9b 0x2e95 0x2e9a 0x2e86 0x2ed2 0x2e9a 0x2e97 0x2e93 0x2e96 0x2e93 0x2e91 0x2e9a 0x2e97 
718A:    data    0x2edc 0x2ed2 0x2ed2 0x2ea6 0x2e9a 0x2e97 0x2ed2 0x2e9e 0x2e93 0x2e81 0x2e86 0x2ed2 0x2e86 0x2e9a 0x2e9b 0x2e9c 
719A:    data    0x2e95 0x2ed2 0x2e8b 0x2e9d 0x2e87 0x2ed2 0x2e80 0x2e97 0x2e9f 0x2e97 0x2e9f 0x2e90 0x2e97 0x2e80 0x2ed2 0x2e9b 
71AA:    data    0x2e81 0x2ed2 0x2e93 0x2e91 0x2e86 0x2e9b 0x2e84 0x2e93 0x2e86 0x2e9b 0x2e9c 0x2e95 0x2ed2 0x2e86 0x2e9a 0x2e93 
71BA:    data    0x2e86 0x2ed2 0x2e86 0x2e97 0x2e9e 0x2e97 0x2e82 0x2e9d 0x2e80 0x2e86 0x2e97 0x2e80 0x2edc 0x2edc 0x2edc 0x2ed2 
71CA:    data    0x2e90 0x2e87 0x2e86 0x2ed2 0x2e9c 0x2e9d 0x2e85 0x2ed2 0x2e8b 0x2e9d 0x2e87 0x2ed2 0x2e91 0x2e93 0x2e9c 0x2ed5 
71DA:    data    0x2e86 0x2ed2 0x2e94 0x2e9b 0x2e9c 0x2e96 0x2ed2 0x2e9b 0x2e86 0x2ed2 0x2e93 0x2e9c 0x2e8b 0x2e85 0x2e9a 0x2e97 
71EA:    data    0x2e80 0x2e97 0x2ed2 0x2e9b 0x2e9c 0x2ed2 0x2e8b 0x2e9d 0x2e87 0x2e80 0x2ed2 0x2e82 0x2e93 0x2e91 0x2e99 0x2edc 
71FA:    data    0x2ed2 0x2ed2 0x2ea1 0x2e9d 0x2e9f 0x2e97 0x2e9d 0x2e9c 0x2e97 0x2ed2 0x2e81 0x2e97 0x2e97 0x2e9f 0x2e81 0x2ed2 
720A:    data    0x2e86 0x2e9d 0x2ed2 0x2e9a 0x2e93 0x2e84 0x2e97 0x2ed2 0x2e96 0x2e80 0x2e93 0x2e85 0x2e9c 0x2ed2 0x2e93 0x2ed2 
721A:    data    0x2e9f 0x2e97 0x2e81 0x2e81 0x2e93 0x2e95 0x2e97 0x2ed2 0x2e9b 0x2e9c 0x2ed2 0x2e86 0x2e9a 0x2e97 0x2ed2 0x2e81 
722A:    data    0x2e93 0x2e9c 0x2e96 0x2ed2 0x2e9a 0x2e97 0x2e80 0x2e97 0x2ec8 0x2ef8 0x2ef8 0x2ed2 0x2ed2 0x2ed2 0x2ed2 
7239:    data    "\x03"
723A:    data    0x1a07 0x5759 0x75d7 0x9a 0x627f 0x627f 0x623c 0x6201 0x6255 0x6217 0x6210 0x6212 0x621c 0x621b 0x6206 0x6255 
724A:    data    0x6201 0x621a 0x6255 0x6207 0x6214 0x621c 0x621b 0x625b 0x6255 0x6255 0x6221 0x621d 0x6210 0x6255 0x6218 0x6210 
725A:    data    0x6206 0x6206 0x6214 0x6212 0x6210 0x6255 0x6202 0x6214 0x6206 0x621d 0x6210 0x6206 0x6255 0x6214 0x6202 0x6214 
726A:    data    0x620c 0x625b 0x6255 0x6255 0x622c 0x621a 0x6200 0x6255 0x6201 0x6214 0x621e 0x6210 0x6255 0x6214 0x6255 0x6211 
727A:    data    0x6210 0x6210 0x6205 0x6255 0x6217 0x6207 0x6210 0x6214 0x6201 0x621d 0x6255 0x6214 0x621b 0x6211 0x6255 0x6213 
728A:    data    0x6210 0x6210 0x6219 0x6255 0x6213 0x621c 0x6207 0x6218 0x6219 0x620c 0x6255 0x6212 0x6207 0x621a 0x6200 0x621b 
729A:    data    0x6211 0x6210 0x6211 0x6255 0x621c 0x621b 0x6255 0x6207 0x6210 0x6214 0x6219 0x621c 0x6201 0x620c 0x6255 0x6214 
72AA:    data    0x6206 0x6255 0x6201 0x621d 0x6210 0x6255 0x6210 0x6213 0x6213 0x6210 0x6216 0x6201 0x6206 0x6255 0x621a 0x6213 
72BA:    data    0x6255 0x6201 0x621d 0x6210 0x6255 0x6201 0x6210 0x6219 0x6210 0x6205 0x621a 0x6207 0x6201 0x6214 0x6201 0x621c 
72CA:    data    0x621a 0x621b 0x6255 0x6202 0x6210 0x6214 0x6207 0x6255 0x621a 0x6213 0x6213 0x625b 0x627f 0x627f 0x90 0x2c21 
72DA:    data    0x2c40 0x2c13 0x2c14 0x2c12 0x2c01 0x2c0e 0x2c07 0x2c05 0x2c4c 0x2c40 0x2c05 0x2c0c 0x2c05 0x2c03 0x2c14 0x2c12 
72EA:    data    0x2c0f 0x2c0e 0x2c09 0x2c03 0x2c40 0x2c16 0x2c0f 0x2c09 0x2c03 0x2c05 0x2c40 0x2c09 0x2c13 0x2c40 0x2c10 0x2c12 
72FA:    data    0x2c0f 0x2c0a 0x2c05 0x2c03 0x2c14 0x2c05 0x2c04 0x2c40 0x2c09 0x2c0e 0x2c14 0x2c0f 0x2c40 0x2c19 0x2c0f 0x2c15 
730A:    data    0x2c12 0x2c40 0x2c0d 0x2c09 0x2c0e 0x2c04 0x2c5a 0x2c6a 0x2c6a 0x2c40 0x2c40 0x2c42 0x2c2d 0x2c09 0x2c13 0x2c03 
731A:    data    0x2c01 0x2c0c 0x2c09 0x2c02 0x2c12 0x2c01 0x2c14 0x2c09 0x2c0f 0x2c0e 0x2c40 0x2c04 0x2c05 0x2c14 0x2c05 0x2c03 
732A:    data    0x2c14 0x2c05 0x2c04 0x2c41 0x2c40 0x2c40 0x2c21 0x2c02 0x2c0f 0x2c12 0x2c14 0x2c09 0x2c0e 0x2c07 0x2c40 0x2c14 
733A:    data    0x2c05 0x2c0c 0x2c05 0x2c10 0x2c0f 0x2c12 0x2c14 0x2c01 0x2c14 0x2c09 0x2c0f 0x2c0e 0x2c41 0x2c42 0x2c6a 0x2c6a 
734A:    data    0x2c2e 0x2c0f 0x2c14 0x2c08 0x2c09 0x2c0e 0x2c07 0x2c40 0x2c05 0x2c0c 0x2c13 0x2c05 0x2c40 0x2c13 0x2c05 0x2c05 
735A:    data    0x2c0d 0x2c13 0x2c40 0x2c14 0x2c0f 0x2c40 0x2c08 0x2c01 0x2c10 0x2c10 0x2c05 0x2c0e 0x2c4e 0x2c6a 0x2c6a 
7369:    data    "u"
736A:    data    0x52b7 0x5281 0x529b 0x52ce 0x528f 0x528d 0x529a 0x5287 0x5298 0x528f 0x529a 0x528b 0x52ce 0x529a 0x5286 0x528b 
737A:    data    0x52ce 0x529a 0x528b 0x5282 0x528b 0x529e 0x5281 0x529c 0x529a 0x528b 0x529c 0x52cf 0x52ce 0x52ce 0x52af 0x529d 
738A:    data    0x52ce 0x5297 0x5281 0x529b 0x52ce 0x529d 0x529e 0x5287 0x529c 0x528f 0x5282 0x52ce 0x529a 0x5286 0x529c 0x5281 
739A:    data    0x529b 0x5289 0x5286 0x52ce 0x529a 0x5287 0x5283 0x528b 0x52ce 0x528f 0x5280 0x528a 0x52ce 0x529d 0x529e 0x528f 
73AA:    data    0x528d 0x528b 0x52c2 0x52ce 0x5297 0x5281 0x529b 0x52ce 0x529a 0x5286 0x5287 0x5280 0x5285 0x52ce 0x5297 0x5281 
73BA:    data    0x529b 0x52ce 0x529d 0x528b 0x528b 0x52ce 0x528f 0x52ce 0x529e 0x528f 0x529a 0x529a 0x528b 0x529c 0x5280 0x52ce 
73CA:    data    0x5287 0x5280 0x52ce 0x529a 0x5286 0x528b 0x52ce 0x529d 0x529a 0x528f 0x529c 0x529d 0x52c0 0x52c0 0x52c0 0x52e4 
73DA:    data    0x52e4 0x52ce 0x52ce 0x52ce 0x52ce 
73DF:    data    "\x03"
73E0:    data    0x4c6a 0x65f5 0x1847 
73E3:    data    "Y"
73E4:    data    0xb75 0xb75 0xb3e 0xb19 0xb0b 0xb1a 0xb0d 0xb5f 0xb1e 0xb5f 0xb19 0xb1a 0xb08 0xb5f 0xb12 0xb10 
73F4:    data    0xb12 0xb1a 0xb11 0xb0b 0xb0c 0xb53 0xb5f 0xb06 0xb10 0xb0a 0xb5f 0xb19 0xb16 0xb11 0xb1b 0xb5f 
7404:    data    0xb06 0xb10 0xb0a 0xb0d 0xb0c 0xb1a 0xb13 0xb19 0xb5f 0xb1d 0xb1e 0xb1c 0xb14 0xb5f 0xb10 0xb11 
7414:    data    0xb5f 0xb0c 0xb10 0xb13 0xb16 0xb1b 0xb5f 0xb18 0xb0d 0xb10 0xb0a 0xb11 0xb1b 0xb5f 0xb1e 0xb11 
7424:    data    0xb1b 0xb5f 0xb1e 0xb5f 0xb13 0xb16 0xb0b 0xb0b 0xb13 0xb1a 0xb5f 0xb1b 0xb16 0xb0c 0xb10 0xb0d 
7434:    data    0xb16 0xb1a 0xb11 0xb0b 0xb1a 0xb1b 0xb51 0xb75 0xb75 0xb8 0x642f 0x6419 0x6403 0x6456 0x6411 0x6417 
7444:    data    0x640c 0x6413 0x6456 0x641f 0x6418 0x6402 0x6419 0x6456 0x6402 0x641e 0x6413 0x6456 0x641b 0x641f 0x6404 0x6404 
7454:    data    0x6419 0x6404 0x645a 0x6456 0x6417 0x6418 0x6412 0x6456 0x640f 0x6419 0x6403 0x6456 0x6405 0x6413 0x6413 0x6456 
7464:    data    0x640f 0x6419 0x6403 0x6404 0x6405 0x6413 0x641a 0x6410 0x6456 0x6411 0x6417 0x640c 0x641f 0x6418 0x6411 0x6456 
7474:    data    0x6414 0x6417 0x6415 0x641d 0x6458 0x6456 0x6456 0x6434 0x6403 0x6402 0x6456 0x6401 0x6417 0x641f 0x6402 0x6457 
7484:    data    0x6456 0x6456 0x643f 0x6402 0x6456 0x641a 0x6419 0x6419 0x641d 0x6405 0x6456 0x641a 0x641f 0x641d 0x6413 0x6456 
7494:    data    0x6405 0x6419 0x641b 0x6413 0x6419 0x6418 0x6413 0x6456 0x6401 0x6404 0x6419 0x6402 0x6413 0x6456 0x6419 0x6418 
74A4:    data    0x6456 0x640f 0x6419 0x6403 0x6404 0x6456 0x6410 0x6417 0x6415 0x6413 0x6456 0x6401 0x641e 0x641f 0x641a 0x6413 
74B4:    data    0x6456 0x640f 0x6419 0x6403 0x6456 0x6401 0x6413 0x6404 0x6413 0x6456 0x6403 0x6418 0x6415 0x6419 0x6418 0x6405 
74C4:    data    0x6415 0x641f 0x6419 0x6403 0x6405 0x6456 0x6419 0x6418 0x6456 0x6402 0x641e 0x6413 0x6456 0x6414 0x6413 0x6417 
74D4:    data    0x6415 0x641e 0x6457 0x6456 0x6456 0x6422 0x641e 0x6404 0x6419 0x6403 0x6411 0x641e 0x6456 0x6402 0x641e 0x6413 
74E4:    data    0x6456 0x641b 0x641f 0x6404 0x6404 0x6419 0x6404 0x645a 0x6456 0x640f 0x6419 0x6403 0x6456 0x6405 0x6413 0x6413 
74F4:    data    0x6456 0x6454 
74F6:    data    "\x03"
74F7:    data    0x5b33 0x541 0x751d 
74FA:    data    "g"
74FB:    data    0x644e 0x644c 0x641f 0x640f 0x641e 0x640d 0x641b 0x6400 0x6409 0x6408 0x644c 0x6405 0x6402 0x644c 0x640f 0x6404 
750B:    data    0x640d 0x641e 0x640f 0x6403 0x640d 0x6400 0x644c 0x6403 0x6402 0x644c 0x6415 0x6403 0x6419 0x641e 0x644c 0x640a 
751B:    data    0x6403 0x641e 0x6409 0x6404 0x6409 0x640d 0x6408 0x6442 0x6466 0x6466 0x642f 0x6403 0x6402 0x640b 0x641e 0x640d 
752B:    data    0x6418 0x6419 0x6400 0x640d 0x6418 0x6405 0x6403 0x6402 0x641f 0x6457 0x644c 0x6415 0x6403 0x6419 0x644c 0x6404 
753B:    data    0x640d 0x641a 0x6409 0x644c 0x641e 0x6409 0x640d 0x640f 0x6404 0x6409 0x6408 0x644c 0x6418 0x6404 0x6409 0x644c 
754B:    data    0x6409 0x6402 0x6408 0x644c 0x6403 0x640a 0x644c 0x6418 0x6404 0x6409 0x644c 0x640f 0x6404 0x640d 0x6400 0x6400 
755B:    data    0x6409 0x6402 0x640b 0x6409 0x644d 0x6466 0x6466 
7562:    data    "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
