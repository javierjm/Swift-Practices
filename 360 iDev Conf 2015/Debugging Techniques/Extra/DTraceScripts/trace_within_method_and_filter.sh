#!/usr/sbin/dtrace -s
#pragma D option quiet

/* Usage:  
    sudo ./trace_within_method_and_filter.sh -ppidof xcode > output.txt
    cat output.txt | sort -n | cut -c 17-200
*/

unsigned long long indention;
int indentation_amount;

BEGIN {
  indentation_amount = 4;
}

/* the : in method selectors must be replaced with ? */
objc$target:DVTTextCompletionSession:-_setFilteringPrefix?forceFilter?:entry
{
    tracing++;
}

objc$target:DVTTextCompletionSession:-_setFilteringPrefix?forceFilter?:return
{
    tracing--;
}

objc$target:DVTTextCompletionList*::entry
/
    tracing > 0 &&
    &probefunc[1] != "tableView:willDisplayCell:forTableColumn:row:" &&
    &probefunc[1] != "tableView:objectValueForTableColumn:row:"
/
{
    method = (string)&probefunc[1];
    type = probefunc[0];
    class = probemod;
    printf("%lu %*s%s %c[%s %s]\n", timestamp, indention * indentation_amount, "", "->", type, class, method);
    indention++;
}

objc$target:DVTTextCompletionList*::return
/
    tracing > 0 &&
    &probefunc[1] != "tableView:willDisplayCell:forTableColumn:row:" &&
    &probefunc[1] != "tableView:objectValueForTableColumn:row:"
/
{
    indention--;
    method = (string)&probefunc[1];
    type = probefunc[0];
    class = probemod;
    printf("%lu %*s%s %c[%s %s]\n", timestamp, indention * indentation_amount, "", "<-", type, class, method);
}
