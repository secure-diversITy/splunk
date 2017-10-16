#!/bin/bash
###########################################################################################
#
# Author:       Thomas Fischer <mail | se-di | de>, https://github.com/secure-diversITy/splunk
# Created:      2015-08-14
# License:      CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
#
# Desc:         Stress your storage setup to find out IOPS
#
###########################################################################################
#
# Usage & Installation: Checkout README !!
#
#########################################################################################
#
# Last changed: 2017-10-16
#
#########################################################################################
EPATH=$(dirname $0)         # detect path we're running in
VARFILE=libs/general

[ ! -f $VARFILE ] && echo "ERROR: missing variable file <$VARFILE>" && exit
source $VARFILE

# pre-check
for bin in $(echo $REQBINS);do
    if [ ! -x $bin ];then
        echo -e "\n\tERROR: Cannot find $bin or it is not executable!ABORTED.\n"
        exit 3
    else
        echo -e "\t.. $bin detected correctly"
    fi
done
[ ! -d "$FUNCS" ]&& echo -e "\n\tERROR: cannot find $FUNCS path..." && exit

for fc in $(ls $FUNCS);do
    . $FUNCS/$fc
    if [ $? -ne 0 ];then
        echo -e "\tERROR: $FUNCS/$fc cannot be included! Aborted.."
        exit 3
    else
        echo -e "\t... $fc included"
    fi
done

F_USAGE(){
    echo -e "\nBrought to you by Thomas Fischer <mail | se-di | de>\n"
    echo -e "\n\tSimply execute me to start interactive mode."
    echo -e "\tYou can also switch to batch mode but this will use predefined values then:"
    echo -e "\n\t$0 [a1|a2|a3|a4]\n\n\tWhere:\n"
    echo -e "\t[a1] = bonnie++"
    echo -e "\t[a2] = iozone"
    echo -e "\t[a3] = fio"
    echo -e "\t[a4] = ioping (I/O latency)"
    echo -e "\n\t(a means automatic)\n\tIf you choose batch mode all output will be made in JSON format.\n"
}

CHOICE="$1"
if [ "$CHOICE" == "-h" ]||[ "$CHOICE" == "--help" ];then F_USAGE; exit;fi

while [ -z $CHOICE ];do
    # users choice
    echo -e "\n\tWelcome and tighten your seat belts. We are about to stress your storage setup!"
    echo -e "\tThere are several tools out there which can measure things. The question is which of those"
    echo -e "\tis doing it the right way?\n\tThe short answer? Test them all ;)\n"
    echo -e "\tNow let's start. Which tool do you want to use today?\n"
    echo -e "\t[1] = bonnie++"
    echo -e "\t[2] = iozone"
    echo -e "\t[3] = fio"
    echo -e "\t[4] = ioping (I/O latency)"
    echo
    read -p "type in the digit from above: > " CHOICE
done

# do what the user want to do
# the first argument when exec a function is always the batch mode.
# 0 means interactive. 1 means batch mode.
case $CHOICE in
    a1) # auto bonnie
        [ -f "$BCSV" ]&& rm -vf "$BCSV" && echo "...deleted previous stats file $BCSV"
        F_BONNIE 1 $BCSV
    ;;
    a2) # auto iozone
        F_IOZONE 1
    ;;
    a3) # auto fio
        F_FIO 1
    ;;
    a4) # auto ioping
        F_IOPING 1
    ;;
    1) # bonnie
        F_BONNIE 0 $BCSV
    ;;
    2) # iozone
        F_IOZONE 0
    ;;
    3) # fio
        F_FIO 0
    ;;
    4) # ioping
        F_IOPING 0
    ;;
esac
