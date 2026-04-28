#!/bin/sh

t=../../../..
m=../../../../data/metaschemas
s="xml"


### bootstrap / unittest related
xf=""
xf="$m/*.xml"
set -x
xmlfiles=$xf

target=stdout
target="./AptixiaClientTS.tcl"
mode="tclclient"
python $t/misc/tools/metacompiler.py $mode $target NS $xmlfiles
exitval=$?
(cd ../../; zip aptixia-tcl-client.zip -v -r tcl unitTests/tcltest; mv aptixia-tcl-client.zip c:/tmp/)
set +x

cp -r ../* ../../../../lib/common/tclclient/
exit $exitval
