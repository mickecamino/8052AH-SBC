1 REM  Set and Read M3003
10 STRING 110,9
11 $(1)="Monday"
12 $(2)="Tuesday"
13 $(3)="Wednesday"
14 $(4)="Thursday"
15 $(5)="Friday"
16 $(6)="Saturday"
17 $(7)="Sunday"
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
REM reset multiplexer by setting CS twice
200 Z=XBY(RTC)
205 Z=XBY(RTC)
REM now read it twice again
210 Z=XBY(RTC)
212 Z=XBY(RTC)
REM write to Address 0FH
215 XBY(RTC)=0Fh
REM write the Tens
220 XBY(RTC)=00H
REM write the units, set bit 0 to 1 to start clock
230 XBY(RTC)=01H
REM set the clock
300 INPUT "year (0-99)? ",T
301 IF T > 99 THEN GOTO 300
302 IF T < 0 THEN GOTO 300
310 M=5
320 GOSUB 3000
400 INPUT "month (1-12)? ",T
401 IF T > 12 THEN GOTO 400
402 IF T < 1 THEN GOTO 400
410 M=4
420 GOSUB 3000
500 INPUT "day of month (1-31)? ",T
501 IF T > 31 THEN GOTO 500
502 IF T < 1 THEN GOTO 500
510 M=3
520 GOSUB 3000
600 INPUT "day of week (1-7)? (Sunday=7)",T
601 IF T > 7 THEN GOTO 600
602 IF T < 1 THEN GOTO 600
610 M=6
620 GOSUB 3000
650 INPUT "week number (1-53)?",T
651 IF T > 53 THEN GOTO 650
652 IF T < 1 THEN GOTO 650
660 M=7
670 GOSUB 3000
700 INPUT "hour (0-23)? ",T
701 IF T > 23 THEN GOTO 700
702 IF T < 0 THEN GOTO 700
710 M=2
720 GOSUB 3000
800 INPUT "minutes (0-59)? ",T
801 IF T > 59 THEN GOTO 800
802 IF T < 0 THEN GOTO 800
810 M=1
820 GOSUB 3000
900 INPUT "seconds (0-59)? ",T
901 IF T > 59 THEN GOTO 900
902 IF T < 0 THEN GOTO 900
910 M=0
920 GOSUB 3000
950 PRINT "Press any key when ready to start the clock"
960 A=GET : IF A=0 THEN GOTO 960
REM Read M3003 Bus
970 Z=XBY(RTC)
REM Address 0FH
971 XBY(RTC)=0FH
REM Tens
971 XBY(RTC)=00H
REM units, set bit 0 to 1 to start clock
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
REM Read M3003 Bus
3020 Z=XBY(RTC)
REM Write address, M contains address
3030 XBY(RTC)=M
REM Write tens
3040 XBY(RTC)=T1
REM Write Units
3050 XBY(RTC)=T2
3060 RETURN
REM read RTC
3200 Z=XBY(RTC)
REM Set Address
3210 XBY(RTC)=M
REM Read Tens
3220 TIDT=XBY(RTC).AND.0FH
REM Read Units
3230 TIDE=XBY(RTC).AND.0FH
REM Combine the result
3240 T=TIDT*10+TIDE
3250 RETURN
