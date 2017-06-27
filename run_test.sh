# run_test.sh [budget] [repetition]

if [ $# -lt 2 ]
then
	echo "run_test.sh [budget] [repetition]"
	exit
fi

budget=$1
repetition=$2

vms=("10.0.0.2" "10.0.0.3" "10.0.0.4" "10.0.0.5" "10.0.0.6" "10.0.0.7" "10.0.0.8" "10.0.0.9" "10.0.0.10" "10.0.0.11" "10.0.0.12" "10.0.0.13" "10.0.0.14" "10.0.0.15" "10.0.0.16" "10.0.0.17" "10.0.0.18" "10.0.0.19" "10.0.0.20" "10.0.0.21" "10.0.0.22" "10.0.0.23" "10.0.0.24" "10.0.0.25" "10.0.0.26" "10.0.0.27" "10.0.0.28" "10.0.0.29" "10.0.0.30" "10.0.0.31" "10.0.0.32" "10.0.0.33" "10.0.0.34" "10.0.0.35" "10.0.0.36" "10.0.0.37" "10.0.0.38" "10.0.0.39" "10.0.0.40" "10.0.0.41" "10.0.0.42" "10.0.0.43" "10.0.0.44" "10.0.0.45" "10.0.0.46" "10.0.0.47" "10.0.0.48" "10.0.0.49")

target=("Chart 1 15" "Chart 16 26 Time 26 27" "Closure 1 15" "Closure 16 30" "Closure 31 45" "Closure 46 60" "Closure 61 75" "Closure 76 90" "Closure 91 105" "Closure 106 120" "Closure 121 133 Math 106" "Lang 1 15" "Lang 16 30" "Lang 31 45" "Lang 46 60" "Lang 61 65 Time 16 25" "Math 1 15" "Math 16 30" "Math 31 45" "Math 46 60" "Math 61 75" "Math 76 90" "Math 91 105" "Time 1 15" "Chart 1 15" "Chart 16 26 Time 26 27" "Closure 1 15" "Closure 16 30" "Closure 31 45" "Closure 46 60" "Closure 61 75" "Closure 76 90" "Closure 91 105" "Closure 106 120" "Closure 121 133 Math 106" "Lang 1 15" "Lang 16 30" "Lang 31 45" "Lang 46 60" "Lang 61 65 Time 16 25" "Math 1 15" "Math 16 30" "Math 31 45" "Math 46 60" "Math 61 75" "Math 76 90" "Math 91 105" "Time 1 15")

echo "* run_test Start"

for (( i=1; i<=48; i++))
do
	remoteVM=${vms[i-1]}
	echo "Connectioni to "$i"th VM: "$remoteVM
	
	t=$i
	echo ${target[t-1]}
	ssh "root@"$remoteVM "screen -dm bash -c './gen_test.sh $i $budget $repetition ${target[t-1]}'"
	
	#ssh "root@"$remoteVM hostname
done

echo "* run_test Complete!"
