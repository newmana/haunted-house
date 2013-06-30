10 REM HAUNTED HOUSE ADVENTURE
20 REM ***********************
30 REM THIS VERSION FOR "MICROSOFT" BASIC
40 REM REQUIRES A MINIMUM OF 16K
50 REM SELECT "TEXT MODE" IF NECESSARY
60 REM *******************************
70 V=25:W=36:G=18
80 GOSUB 1600

90 HOME:PRINT"HAUNTED HOUSE"
100 PRINT "--------------"

110 PRINT "YOUR LOCATION"
120 PRINT D$(RM)
130 PRINT "EXITS:";
140 FOR I=1 TO LEN(R$(RM))
150 PRINT MID$(R$(RM),I,1);",";
160 NEXT I
170 PRINT
180 FOR I=1 TO G
190 IF L(I)=RM AND F(I)=0 THEN PRINT "YOU CAN SEE ";O$(I);" HERE"
200 NEXT I
210 PRINT "============================"
220 PRINT M$:M$="WHAT"

230 INPUT "WHAT WILL YOU DO NOW ";Q$
240 V$="":W$="":VB=0:OB=0
250 FOR I=1 TO LEN(Q$)
260 IF MID$(Q$,I,1)=" " AND V$="" THEN V$=LEFT$(Q$,I-1)
270 IF MID$(Q$,I+1,1)<>" " AND V$<>"" THEN W$=MID$(Q$,I+1,LEN(Q$)-1):I=LEN(Q$)
280 NEXT I
290 IF W$="" THEN V$=Q$
300 FOR I=1 TO V
310 IF V$=V$(I) THEN VB=I
320 NEXT I
330 FOR I=1 TO W
340 IF W$=O$(I) THEN LET OB=I
350 NEXT I

359 REM *** ERROR MESSAGE OVERRIDE CONDITIONS *** 
360 IF W$>"" AND OB=0 THEN M$="THAT'S SILLY"
370 IF VB=0 THEN VB=V+1
380 IF W$="" THEN M$="I NEED TWO WORDS"
390 IF VB>V AND OB>0 THEN M$="YOU CAN'T '"+Q$+"'"
400 IF VB>V AND OB=0 THEN M$="YOU DON'T MAKE SENSE"
410 IF VB<V AND OB>0 AND C(OB)=0 THEN M$="YOU DON'T HAVE '"+W$+"'"
420 IF F(26)=1 AND RM=13 AND INT(RND(1) * 3)<>2 AND VB<>21 THEN M$="BATS ATTACKING!":GOTO 90
430 IF RM=44 AND INT(RND(1) * 2)=1 AND F(24)<>1 THEN F(27)=1
440 IF F(0)=1 THEN LL=LL-1
450 IF LL<1 THEN F(0)=0

459 REM *** BRANCH TO SUBROUTINES ***
460 ON VB GOSUB 500,570,640,640,640,640,640,640,640,980,980,1030,1070,1140,1180,1220,1250,1300,1340,1380,1400,1430,1460,1490,1510,1590

470 IF LL=10 THEN M$="YOUR CANDLE IS WANING!"
480 IF LL=1 THEN M$="YOUR CANDLE IS OUT!"
490 GOTO 90

499 REM *** HELP *** 
500 PRINT "WORDS I KNOW:"
510 FOR I=1 TO V
520  PRINT V$(I);",";
530  NEXT I
540 M$="":PRINT
550 GOSUB 1580
560 RETURN

569 REM *** CARRYING *** 
570 PRINT "YOUR ARE CARRYING:"
580 FOR I=1 TO G
590   IF C(I)=1 THEN PRINT O$(I);",";
600   NEXT I
610 M$="":PRINT
620 GOSUB 1580
630 RETURN

639 REM *** MOVEMENT ***
640 D=0

650 IF OB=0 THEN D=VB-3
660 IF OB=19 THEN D=1
670 IF OB=20 THEN D=2
680 IF OB=21 THEN D=3
690 IF OB=22 THEN D=4
700 IF OB=23 THEN D=5
710 IF OB=24 THEN D=6

720 IF RM=20 AND D=5 THEN D=1
730 IF RM=20 AND D=6 THEN D=3

740 IF RM=22 AND D=6 THEN D=2
750 IF RM=22 AND D=5 THEN D=3

760 IF RM=36 AND D=6 THEN D=1
770 IF RM=36 AND D=5 THEN D=2

780 IF F(14)=1 THEN M$="CRASH! YOU FELL OUT OF THE TREE!":F(14)=0:RETURN
790 IF F(27)=1 AND RM=52 THEN M$="GHOSTS WILL NOT LET YOU MOVE":RETURN
800 IF RM=45 AND C(1)=1 AND F(34)=0 THEN M$="A MAGICAL BARRIER TO THE WEST":RETURN
810 IF (RM=26 AND F(0)=0) AND (D=1 OR D=4) THEN M$="YOU NEED A LIGHT":RETURN
820 IF RM=54 AND C(15) <> 1 THEN M$="YOU'RE STUCK!":RETURN
830 IF C(15)=1 AND NOT (RM=53 OR RM=54 OR RM=55 OR RM=47) THEN M$="YOU CAN'T CARRY A BOAT!":RETURN
840 IF (RM>26 AND RM<30) AND F(0)=0 THEN M$="TOO DARK TO MOVE":RETURN
850 F(35)=0:RL=LEN(R$(RM))
860 FOR I=1 TO RL
870   U$=MID$(R$(RM),I,1)
880   IF (U$="N" AND D=1 AND F(35)=0) THEN RM=RM-8:F(35)=1
890   IF (U$="S" AND D=2 AND F(35)=0) THEN RM=RM+8:F(35)=1
900   IF (U$="W" AND D=3 AND F(35)=0) THEN RM=RM-1:F(35)=1
910   IF (U$="E" AND D=4 AND F(35)=0) THEN RM=RM+1:F(35)=1
920   NEXT I
930 M$="OK"
940 IF F(35)=0 THEN M$="CAN'T GO THAT WAY!"
950 IF D<1 THEN M$="GO WHERE?"
960 IF RM=41 AND F(23)=1 THEN R$(49)="SW":M$="THE DOOR SLAMS SHUT!":F(23)=0
970 RETURN

979 REM *** GET AND TAKE ***
980 IF OB>G THEN M$="I CAN'T GET "+W$:RETURN
981 REM PRINT "L(OB): " + L(OB) + " RM " + RM;
985 IF L(OB) <> RM THEN M$="IT ISN'T HERE"
990 IF F(OB) <> 0 THEN M$="WHAT "+W$+"?"
1000 IF C(OB)=1 THEN M$="YOU ALREADY HAVE IT"
1010 IF OB>0 AND L(OB)=RM AND F(OB)=0 THEN C(OB)=1:L(OB)=65:M$="YOU HAVE THE "+W$
1020 RETURN

1029 REM *** OPEN ***
1030 IF RM=43 AND (OB=28 OR OB=29) THEN F(17)=0:M$="DRAWER OPEN"
1040 IF RM=28 AND OB=25 THEN M$="IT'S LOCKED"
1050 IF RM=38 AND OB=32 THEN M$="THAT'S CREEPY!":F(2)=0
1060 RETURN

1069 REM *** EXAMINE ***
1070 IF OB=30 THEN F(18)=0:M$="SOMETHING HERE!"
1080 IF OB=31 THEN M$="THAT'S DISGUSTING!"
1090 IF (OB=28 OR OB=29) THEN M$="THERE IS A DRAWER"
1100 IF OB=33 OR OB=5 THEN GOSUB 1140
1110 IF RM=43 AND OB=35 THEN M$="THERE IS SOMETHING BEYOND..."
1120 IF OB=32 THEN GOSUB 1030
1130 return

1139 REM *** READ ***
1140 IF RM=42 AND OB=33 THEN M$="THEY ARE DEMONIC WORKS"
1150 IF (OB=3 OR OB=36) AND C(3)=1 AND F(34)=0 THEN M$="USE THIS WORD WITH CARE 'XZANFAR'"
1160 IF C(5)=1 AND OB=5 THEN M$="THE SCRIPT IS IN AN ALIEN TONGUE"
1170 RETURN

1179 REM *** SAY ***
1180 M$="OK '"+W$+"'"
1190 IF C(3)=1 AND OB=34 THEN M$="*MAGIC OCCURS*": IF RM<>45 THEN RM=INT(RND(1) * 64)
1200 IF C(3)=1 AND OB=34 AND RM=45 THEN F(34)=1
1210 RETURN

1219 REM *** DIG ***
1220 IF C(12)=1 THEN M$="YOU MADE A HOLE"
1230 IF C(12)=1 AND RM=30 THEN M$="DUG THE BARS OUT":D$(RM)="HOLE IN WALL":R$(RM)="NSE"
1240 RETURN

1249 REM *** SWING ***
1250 IF C(14) <> 1 AND RM=7 THEN M$="THIS IS NO TIME TO PLAY GAMES"
1260 IF OB=14 AND C(14)=1 THEN M$="YOU SWUNG IT"
1270 IF OB=13 AND C(13)=1 THEN M$="WHOOSH"
1280 IF OB=13 AND C(13)=1 AND RM=43 THEN R$(RM)="WN":D$(RM)="STUDY WITH SECRET ROOM":M$="YOU BROKE THE THIN WALL"
1290 RETURN

1299 REM *** CLIMB ***
1300 IF OB=14 AND C(14)=1 THEN M$="IT ISN'T ATTACHED TO ANYTHING!"
1310 IF OB=14 AND C(14)<>1 AND RM=7 AND F(14)=0 THEN M$="YOU SEE THICK FOREST AND CLIFF SOUTH":F(14)=1:RETURN
1320 IF OB=14 AND C(14)<>1 AND RM=7 AND F(14)=1 THEN M$="GOING DOWN!":F(14)=0
1330 RETURN

1339 REM *** LIGHT ***
1340 IF OB=17 AND C(17)=1 AND C(8)=0 THEN M$="IT WILL BURN YOUR HANDS"
1350 IF OB=17 AND C(17)=1 AND C(9)=0 THEN M$="NOTHING TO LIGHT IT WITH"
1360 IF OB=17 AND C(17)=1 AND C(9)=1 AND C(8)=1 THEN M$="IT CASTS A FLICKERING LIGHT":F(0)=1
1370 RETURN

1379 REM *** UNLIGHT ***
1380 IF F(0)=1 THEN F(0)=0:M$="EXTINGUISHED"
1390 RETURN

1399 REM *** SPRAY ***
1400 IF OB=26 AND C(16)=1 THEN M$="HISSSS"
1410 IF OB=26 AND C(16)=1 AND F(26)=1 THEN F(26)=0:M$="PFFT! GOT THEM"
1420 RETURN

1429 REM *** USE ***
1430 IF OB=10 AND C(10)=1 AND C(11)=1 THEN M$="SWITCHED ON":F(24)=1
1440 IF F(27)=1 AND F(24)=1 THEN M$="WHIZZ - VACUUMED THE GHOSTS UP!":F(27)=0
1450 RETURN

1459 REM *** UNLOCK ***
1460 IF RM=43 AND (OB=27 OR OB=28) THEN GOSUB 1030
1470 IF RM=28 AND OB=25 AND F(25)=0 AND C(18)=1 THEN F(25)=1:R$(RM)="SEW":D$(RM)="HUGE OPEN DOOR":M$="THE KEY TURNS!"
1480 RETURN

1489 REM *** LEAVE ***
1490 IF C(OB)=1 THEN C(OB)=0:L(OB)=RM:M$="DONE"
1500 RETURN

1509 REM *** SCORE ***
1510 S=0
1520 FOR I=1 TO G
1530   IF C(I)=1 THEN S=S+1
1540   NEXT I
1550 IF S=17 AND C(15)<>1 AND RM<>57 THEN PRINT "YOU HAVE EVERYTHING":PRINT "RETURN TO THE GATE FOR FINAL SCORE"
1560 IF S=17 AND RM= 57 THEN PRINT "DOUBLE SCORE FOR REACHING HERE!":S=S*2
1570 PRINT "YOUR SCORE=";S:IF S>18 THEN PRINT "WELL DONE! YOU FINISHED THE GAME":END

1580 INPUT "PRESS RETURN TO CONTINUE"; Q$
1590 RETURN

1600 DIM R$(63), D$(63), O$(W),V$(V)
1610 DIM C(W),L(G),F(W)
1620 DATA 46,38,35,50,13,18,28,42,10,25,26,4,2,7,47,60,43,32
1630 FOR I=1 TO G
1640   READ L(I)
1650   NEXT I

1660 DATA "HELP","CARRYING","GO","N","S","W","E","U","D","GET","TAKE","OPEN","EXAMINE","READ","SAY"
1665 DATA "DIG","SWING","CLIMB","LIGHT","UNLIGHT","SPRAY","USE","UNLOCK","LEAVE","SCORE"
1680 FOR I=1 TO V
1690   READ V$(I)
1700   NEXT I

1710 DATA "SE","WE","WE","SWE","WE","WE","SWE","WS"
1720 DATA "NS","SE","WE","NW","SE","W","NE","NSW"
1730 DATA "NS","NS","SE","WE","NWUD","SE","WSUD","NS"
1740 DATA "N","NS","NSE","WE","WE","NSW","NS","NS"
1750 DATA "S","NSE","NSW","S","NSUD","N","N","NS"
1760 DATA "NE","NW","NE","W","NSE","WE","W","NS"
1770 DATA "SE","NSW","E","WE","NW","S","SW","NW"
1780 DATA "NE","NWE","WE","WE","WE","NWE","NWE","W"
1790 FOR I=0 TO 63 
1800   READ R$(I)
1810   NEXT I

1820 DATA "DARK CORNER","OVERGROWN GARDEN","BY LARGE WOODPILE","YARD BY RUBBISH"
1825 DATA "WEEDPATCH","FOREST","THICK FOREST","BLASTED TREE"
1840 DATA "CORNER OF HOUSE","ENTRANCE TO KITCHEN","KITCHEN & GRIMY COOKER","SCULLERY DOOR"
1845 DATA "ROOM WITH INCHES OF DUST","REAR TURRET ROOM","CLEARING BY HOUSE","PATH"
1860 DATA "SIDE OF HOUSE","BACK OF HALLWAY","DARK ALCOVE","SMALL DARK ROOM"
1865 DATA "BOTTOM OF SPIRAL STAIRCASE","WIDE PASSAGE","SLIPPERY STEPS","CLIFFTOP"
1880 DATA "NEAR CRUMBLING WALL","GLOOMY PASSAGE","POOL OF LIGHT","IMPRESSIVE VAULTED HALLWAY"
1885 DATA "HALL BY THICK WOODEN DOOR","TROPHY ROOM","CELLAR WITH BARRED WINDOW","CLIFF PATH"
1900 DATA "CUPBOARD WITH HANGING COAT","FRONT HALL","SITTING ROOM","SECRET ROOM"
1905 DATA "STEEP MARBLE STAIRS","DINING ROOM","DEEP CELLAR WITIH COFFIN"," CLIFF PATH"
1920 DATA "CLOSET","FRONT LOBBY","LIBRARY OF EVIL BOOKS","STUDY WITH DESK & HOLE IN WALL"
1925 DATA "WEIRD COBWEBBY ROOM","VERY COLD CHAMBER","SPOOKY ROOM","CLIFF PATH BY MARSH"
1940 DATA "RUBBLE-STREWN VERANDAH","FRONT PORCH","FRONT TOWER","SLOPING CORRIDOR"
1945 DATA "UPPER GALLERY","MARSH BY WALL","MARSH","SOGGY PATH"
1960 DATA "BY TWISTED RAILING","PATH THROUGH IRON GATE","BY RAILINGS","BENEATH FRONT TOWER"
1965 DATA "DEBRIS FROM CRUMBLING FACADE","LARGE FALLEN BRICKWORK","ROTTING STONE ARCH","CRUMBLING CLIFFTOP"
1980 FOR I=0 TO 63
1990   READ D$(I)
2000   NEXT I

2010 DATA "PAINTING","RING","MAGIC SPELLS","GOBLET","SCROLL","COINS","STATUE","CANDLESTICK"
2012 DATA "MATCHES","VACUUM","BATTERIES","SHOVEL","AXE","ROPE","BOAT","AEROSOL","CANDLE","KEY"
2014 DATA "NORTH","SOUTH","WEST","EAST","UP","DOWN"
2016 DATA "DOOR","BATS","GHOSTS","DRAWER","DESK","COAT","RUBBISH"
2018 DATA "COFFIN","BOOKS","XZANFAR","WALL","SPELLS"
2060 FOR I=1 TO W
2070  READ O$(I)
2080  NEXT I
2090 F(18)=1:F(17)=1:F(2)=1:F(26)=1:F(28)=1:F(23)=1:LL=60:RM=57:M$="OK"
2100 RETURN
