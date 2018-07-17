#/bin/sh
LogFilePath="/dev/null"
AppName=(
    #"/root/python demo.py"
    "mongod -f /mongo/configer/config/mongo.conf"
    "mongod -f /mongo/shard1/config/mongo.conf"
    "mongod -f /mongo/shard2/config/mongo.conf"
    "mongod -f /mongo/shard3/config/mongo.conf"
)

Num=${#AppName[*]}
i=0
while [ $i -lt $Num ]; do
    Process=${AppName[$i]}
    pos=`expr index "$Process" '/'`
    pos=`expr $pos - 1`
    ProcessName=${Process:$pos}
	echo "--------------check process: $ProcessName --------------------"
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
    elif [ $PROCESS_NUM -eq 1 ]; then
		echo "----------------- $ProcessName is ok ------------------------------"
    fi
	i=`expr $i + 1`
done