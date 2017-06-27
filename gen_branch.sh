#gen_test [machine_id] [budget] [repetition] [target list... (project, min-version, max-version)]

echo $@

if [ $# -lt 6 ]
then
	echo "gen_test [machine_id] [budget] [repetition] [target list...]"
	exit
fi

export PATH=$PATH:~/defects4j/framework/bin:~/defects4j/framework/util

machine_id=$1
budget=$2
repetition=$3
target_list=( "${@:4}" )
projects=$(( ${#target_list[@]} / 3 ))

min_run=1
max_run=$repetition

for ((t=0; t<$projects; t++));
do
	project=${target_list[t*3]}
	version_min=${target_list[t*3+1]}
	version_max=${target_list[t*3+2]}

	for ((i=$version_min;i<=$version_max;i++));
	do
		for ((c=$min_run;c<=$max_run;c++)); #cycle
		do	
			bug=$i
			
			echo "**** Testgen_"$project"_"$bug"F_count:"$c
			run_evosuite.pl -p $project -v $bug"f" -n $c -o testSuites$machine_id"_"$budget -c branch -b $budget
		
			#RESPATH="$(ls -d /tmp/run_evosuite*)"
			#mv "${RESPATH}/evosuite-report/matrix" "results/matrix_$project$n"
			#rm -rf /tmp/run_evosuite*
		done
		
		echo "**** SuiteFix_"$project"_"$bug"F"
		fix_test_suite.pl -p $project -v $bug"f" -d testSuites$machine_id"_"$budget"/"$project
		
		echo "**** BugDetection_"$project"_"$bug"F"
		run_bug_detection.pl -p $project -v $bug"f" -o results$machine_id"_"$budget -d testSuites$machine_id"_"$budget"/"$project
	done
done
