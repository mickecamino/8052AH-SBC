10 STRING 110,9
11 $(0)="Sunday"
12 $(1)="Monday"
13 $(2)="Tuesday"
14 $(3)="Wednesday"
15 $(4)="Thursday"
16 $(5)="Friday"
17 $(6)="Saturday"
REM RTC address
20 RTC=0E060H
100 DO
102 PRINT
104 PRINT "Select function:"
106 PRINT "1. Initialize and start clock"
108 PRINT "2. Display time and day"
110 PRINT "9. End program"
112 INPUT A
114 IF A=1 THEN GOSUB 200
116 IF A=2 THEN GOSUB 1000
118 IF A=9 THEN GOTO 122
120 WHILE 1=1
122 END
REM initialize and start clock
REM stop clock while initializing
REM reset multiplexer by setting CS twice
200 Z=XBY(RTC)
205 Z=XBY(RTC)
210 Z=XBY(RTC)
212 Z=XBY(RTC)
215 XBY(RTC)=0Fh
220 XBY(RTC)=00H
230 XBY(RTC)=01H
REM get time and date
300 INPUT "year (0-99)? ",T
310 M=5
320 GOSUB 3000
400 INPUT "month (1-12)? ",T
410 M=4
420 GOSUB 3000
500 INPUT "day of month (1-31)? ",T
510 M=3
520 GOSUB 3000
600 INPUT "day of week (1-7)? (Sunday=0)",T
610 M=6
620 GOSUB 3000
650 INPUT "week number (1-53)?",T
660 M=7
670 GOSUB 3000
700 INPUT "hour (0-23)? ",T
710 M=2
720 GOSUB 3000
800 INPUT "minutes (0-59)? ",T
810 M=1
820 GOSUB 3000
900 INPUT "seconds (0-59)? ",T
910 M=0
920 GOSUB 3000
950 PRINT "Press any key when ready to start the clock"
960 A=GET : IF A=0 THEN GOTO 960
970 Z=XBY(RTC)
971 XBY(RTC)=0FH
971 XBY(RTC)=00H
872 XBY(RTC)=01H 
999 RETURN
REM display current time and date
REM get hours
1000 M=INT(2)
1010 GOSUB 3200
1020 PRINT "Time = ",T,":",
REM get minutes
1100 M=INT(1)
1110 GOSUB 3200
1120 PRINT T,":",
REM get seconds
1200 M=INT(0)
1210 GOSUB 3200
1220 PRINT T,
1230 PRINT
REM get year
1300 M=INT(5)
1310 GOSUB 3200
1320 T=T+2000
1330 PRINT "Date = ",T,"-",
REM get month
1400 M=INT(4)
1410 GOSUB 3200
1420 PRINT T,"-",
REM get day of month
1510 M=INT(3)
1520 GOSUB 3200
1530 PRINT T
REM get day of week
1600 M=INT(6)
1610 GOSUB 3200
1620 PRINT "Day of week = ",$(T)
REM get week #
1700 M=INT(7)
1710 GOSUB 3200
1720 PRINT "Week # = ",T
1730 RETURN
REM convert decimal to tens and units and write to clock
3000 T1=INT(T/10)
3010 T2=T-INT(T/10)*10
3020 Z=XBY(RTC)
3030 XBY(RTC)=M
3040 XBY(RTC)=T1
3050 XBY(RTC)=T2
3060 RETURN
REM read A
3200 Z=XBY(RTC)
3210 XBY(RTC)=M
3220 TIDT=XBY(RTC).AND.0FH
3230 TIDE=XBY(RTC).AND.0FH
3240 T=TIDT*10+TIDE
3250 RETURN