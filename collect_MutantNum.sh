# collect_test.sh [budget] [destination]

if [ $# -lt 2 ]
then
	echo "collect_test.sh [budget] [destination]"
	exit
fi

budget=$1
des=$2

mkdir -p $des

vms=("10.0.0.2" "10.0.0.3" "10.0.0.4" "10.0.0.5" "10.0.0.6" "10.0.0.7" "10.0.0.8" "10.0.0.9" "10.0.0.10" "10.0.0.11" "10.0.0.12" "10.0.0.13" "10.0.0.14" "10.0.0.15" "10.0.0.16" "10.0.0.17" "10.0.0.18" "10.0.0.19" "10.0.0.20" "10.0.0.21" "10.0.0.22" "10.0.0.23" "10.0.0.24" "10.0.0.25" "10.0.0.26" "10.0.0.27" "10.0.0.28" "10.0.0.29" "10.0.0.30" "10.0.0.31" "10.0.0.32" "10.0.0.33" "10.0.0.34" "10.0.0.35" "10.0.0.36" "10.0.0.37" "10.0.0.38" "10.0.0.39" "10.0.0.40" "10.0.0.41" "10.0.0.42" "10.0.0.43" "10.0.0.44" "10.0.0.45" "10.0.0.46" "10.0.0.47" "10.0.0.48" "10.0.0.49")

echo "* collect_test Start"

for (( i=1; i<=48; i++))
do
	remoteVM=${vms[i-1]}
	echo "Connectioni to "$i"th VM: "$remoteVM
	
	t=$i
	
	scp -rq "root@$remoteVM:/root/testSuites"$i"_"$budget"/Math" "./$des/"
	
	#ssh "root@"$remoteVM hostname
done

echo "* collect_test Complete!"
