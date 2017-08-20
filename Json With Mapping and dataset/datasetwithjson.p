define var hDset as handle no-undo.      
define var hRel  as handle no-undo.
           
define temp-table ttname
          field v-name as char
          field v-age as inte.
          
define temp-table ttname1
          field v-name as char serialize-hidden
          field v-pass as char.
 
define temp-table ttxtrainfo
          field v-name as char serialize-hidden
          field extrainfo as char extent 3
          field friendinfo as inte.
 
define temp-table ttinfother
          field friendinfo as inte serialize-hidden
          field friendname as char.
 
define BUFFER b-ttname for ttname.

define BUFFER b-ttnam1 for ttname1.

define BUFFER b-xtrain FOR ttxtrainfo.

define BUFFER b-ttinfo FOR ttinfother.
 
create b-ttname.
    ASSIGN
        b-ttname.v-name = "test"
        b-ttname.v-age = 20.
 
create b-ttname.
    assign
       b-ttname.v-name = "test1"
       b-ttname.v-age  = 4.
       
create b-ttnam1.
    assign
        b-ttnam1.v-name = "test1"
        b-ttnam1.v-pass = "sdfasdfqwSA3".
 
create b-ttnam1.
    assign
        b-ttnam1.v-name = "test"
        b-ttnam1.v-pass = "csafsa".
       
CREATE b-xtrain.
    ASSIGN
        b-xtrain.v-name = "test"
        b-xtrain.friendinfo = 1.
 
DEFINE VAR i AS inte INIT 0.
 
DO i = 1 TO 3:
    b-xtrain.extrainfo[i] = STRING(i) + "Helloworld".
END.
 
CREATE b-ttinfo.
    ASSIGN
        b-ttinfo.friendinfo = 1
        b-ttinfo.friendname = "Alex".
              
 
 
define var lRetOK as logical no-undo.
 
 /** this is just for display the sample**/
for each b-ttname, each b-ttnam1:
    disp b-ttname.v-name b-ttname.v-age b-ttnam1.v-name b-ttnam1.v-pass.
end.
 
define dataset hDset for b-ttname , b-ttnam1 , b-xtrain , b-ttinfo
    DATA-RELATION dsnew   FOR b-ttname , b-ttnam1 RELATION-FIELDS(v-name,v-name) NESTED
    DATA-RELATION dsfrnd  FOR b-ttname , b-xtrain RELATION-FIELDS(v-name,v-name) NESTED
    DATA-RELATION dsdrnm  FOR b-xtrain , b-ttinfo RELATION-FIELDS(friendinfo,friendinfo) NESTED
.
 
 
lRetOK = dataset
hDset:WRITE-JSON("file","C:\OpenEdge\nirajsazzie\yeeeyjson.json",false,?,true).

disp "done".
