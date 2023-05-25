#!/bin/bash

function sleeptime {
if ((1<$1 && $1<97)); then
time=60
elif ((97<=$1 && $1<=98)); then
time=5
elif ((98<=$1 && $1<=99)); then
time=1
else
time=10
fi
}

zilpool=eu.zil.k1pool.com:1111
k1login=KrUdv4Pcgg6RPFJ5v3CAFWp9SdevMkip7mX
workername=$(hostname | awk -F "hive" '{print $2}')

while true
do
blocknumber=$(curl -s --header "Content-Type: application/json" --request POST --data '{"id":"1","jsonrpc":"2.0","method":"GetNumTxBlocks","params":[""]}' https://api.zilliqa.com/ | sed -nE '/"result":/ s/.*"$#echo "${url}" | sed -nE '/"result":/ s/.*"(.+)".*/\1/p'
echo -e "${blocknumber}"
timetomine=$(echo -e "scale=2; ${blocknumber}/100" | bc | awk -F "." '{print $2}')
echo -e "${timetomine}"

if ((${timetomine}>=99 && ${timetomine}<=1)); then
miner stop && /hive/miners/lolminer/1.72/lolMiner --algo ETHASH --pool $zilpool --user $k1login.$workername $@ --enablezilcache --coff 0 --cclk 1100 --mclk 9251 --pl 200
else
kill $(ps aux | grep '/hive/miners/lolmine[r]' | awk '{print $2}')
miner start
fi

sleeptime $timetomine
echo $time
echo $workername
sleep $time
done