Proc sql select column names when like pattern contains a macro variable and underline

Example: like "&prefix^_%" escape '^'

The '_' is a pattern matching character so we need to escape it.
We have to use double quotes so the macro variable is resolved.

guthub
https://tinyurl.com/yxkwvdub
https://github.com/rogerjdeangelis/utl-proc-sql-select-column-names-when-like-pattern-contains-a-macro-variable-and-underline

inspired by
Patrick
https://communities.sas.com/t5/user/viewprofilepage/user-id/12447

SAS Forum
https://tinyurl.com/y2ko2pze
https://communities.sas.com/t5/SAS-Programming/Create-a-dynamic-logic-based-on-data-available/m-p/559836

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

options valivarname=upcase;

%let prefix=DEM;

data have;
   length colName $12.;

   prefix="DEM";
   colName='DEM_GENDER';
   output;

   prefix="LAB";
   colName='LAB_CO2';
 output;
run;quit;

WORK.HAVE total obs=2
                                  | RULE
Obs     COLNAME      PREFIX       |
                                  |
 1     DEM_GENDER     DEM         | ==> Select this ob

 2     LAB_CO2        LAB         |

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

WORK.WANT total obs=1

Obs    PREFIX     COLNAME

 1      DEM     DEM_GENDER

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

%let prefix=DEM;

proc sql;
  create
      table want as
  select
      prefix
     ,colName
  from
     have
  where
     upcase(colName) like "&prefix^_%" escape '^'
;quit;

