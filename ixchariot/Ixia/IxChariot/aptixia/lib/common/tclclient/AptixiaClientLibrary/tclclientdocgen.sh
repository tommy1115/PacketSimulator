#!/bin/sh

set -x

t=../../../..
m=../../../../data/metaschemas
s="xml"


### bootstrap / unittest related
xf=""
xf="`ls $m/*.xml | grep -v 'XP'`"
xmlfiles=$xf

target=stdout
target="./AptixiaClientTS.html"
dttmp="./AptixiaClientTS.dt.tmp"
mode="tclclientdoc"
python $t/misc/tools/metacompiler.py $mode $dttmp NS $xmlfiles
exitval=$?


bash ./dtconvert.sh -file AptixiaClient.dt > AptixiaClient.html

bash ./dtconvert.sh -file $dttmp > $target
rm -f $dttmp

exit $exitval
