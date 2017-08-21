/** the obeservation is that do loop is faster than repaet**/DEFINE TEMP-TABLE aTempTable NO-UNDO
 FIELD cTest AS CHARACTER.

DEFINE VARIABLE i AS INTEGER NO-UNDO.
DEFINE VARIABLE cResults AS CHARACTER NO-UNDO INITIAL "".
DEFINE VARIABLE iMethodTime AS INTEGER NO-UNDO.
&SCOPED-DEFINE NumLoops  1000000
&SCOPED-DEFINE NumLoops2 100000

ETIME(TRUE).
REPEAT i = 1 TO {&NumLoops}:
END.
iMethodTime = ETIME.
cResults = cResults + "repeat Method 1:" + STRING(iMethodTime).

ETIME(TRUE).
DO i = 1 TO {&NumLoops}:
END.
iMethodTime = ETIME.
cResults = cResults + "do Method 2:" + STRING(iMethodTime).

/*test with record creation*/
ETIME(TRUE).
REPEAT i = 1 TO {&NumLoops2}:
  CREATE aTempTable.
END.
iMethodTime = ETIME.
cResults = cResults + "repeat Method 1:" + STRING(iMethodTime).

EMPTY TEMP-TABLE aTempTable.
ETIME(TRUE).
DO i = 1 TO {&NumLoops2}:
  CREATE aTempTable.
END.
iMethodTime = ETIME.

cResults = cResults + "do Method 2:" + STRING(iMethodTime).
MESSAGE cResults VIEW-AS ALERT-BOX.
