#/bin/sh
LogFilePath="/dev/null"
AppName=(
    #"/root/python demo.py"
    "/usr/local/bin/python /home/es_sync_mongo.py"
)

Num=${#AppName[*]}
i=0
while [ $i -lt $Num ]; do
    Process=${AppName[$i]}
    pos=`expr index "$Process" '/'`
    pos=`expr $pos - 1`
    ProcessName=${Process:$pos}
    PROCESS_NUM=`ps -ef|grep "$ProcessName"|grep -v "grep"|wc -l`
    #if [ $PROCESS_NUM -lt 1 ] && [ $1 = '-r' ]; then
    if [ $PROCESS_NUM -lt 1 ]; then
        echo "+++++++++++Run $Process++++++++++"
        nohup $Process 1>/dev/null 2>&1 &
        echo "$d run $Process" >>$LogFilePath 2>&1
        sleep 0.2
    #elif [ $PROCESS_NUM -gt 1 ] && [ $1 = '-r' ]; then
    elif [ $PROCESS_NUM -gt 1 ]; then
		pids=(`ps aux | grep "$ProcessName" | grep -v "grep" | awk '{print $2}'`)
		length=${#pids[*]}
		j=0
		while [ $j -lt $length ]; do
			pid=${pids[$j]}
			echo "------------Kill pid: $pid $ProcName-----------"
			kill -9 $pid
		done
		#########################################################
        ####pos=`expr index "$ProcessName" ' '`
        ####if [ $pos -eq 0 ]; then
        ####    ProcName=$ProcessName
        ####else
        ####    pos=`expr $pos - 1`
        ####    ProcName=${ProcessName:0:pos}
        ####fi
        ####echo "------------Kill $ProcName-----------"
        ####killall $ProcName
		#########################################################
    fi
done