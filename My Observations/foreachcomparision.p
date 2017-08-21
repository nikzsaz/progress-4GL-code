define var i as int64 no-undo.
define query qtquery for customer.

query qtquery:FORWARD-ONLY = TRUE.
query qtquery:QUERY-PREPARE("for each customer no-lock").

ETIME(YES).

query qtquery:QUERY-OPEN().

DO WHILE query qtquery:get-next():
end.

disp etime skip(1).


ETIME(YES).
for each customer no-lock:
end.
disp etime.