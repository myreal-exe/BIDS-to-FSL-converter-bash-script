#!/bin/bash

while getopts ":t:n:r:e:o:d:p:" flag; do
	case "$flag" in
		t) task_name=${OPTARG};; #e.g. "task-flanker"
		n) num_runs=${OPTARG};; #e.g. 4
		r) response_col_idx=${OPTARG};; #e.g. 2
		e) response_types=${OPTARG};; #e.g. "incongruent_correct congruent_correct res4 res5"
		o) onset_time_col_idx=${OPTARG};; #e.g. 1
		d) duration_col_idx=${OPTARG};;#e.g. 2
		#parametric modulation is set to 1

	esac
done

#Check whether the file subjList.txt exists; if not, create it
if [ ! -f subjList.txt ]; then
        ls -d sub-?? > subjList.txt
fi

#Loop over all subjects and format timing files into FSL format
for subj in `cat subjList.txt` ; do
        cd $subj/func #Navigate to the subject's func directory, which contains the timing files
		echo "${subj}..."
		
        for ((n_run=1;n_run<=$num_runs;n_run++)); do
			echo "${subj}...${n_run}..."
			for response in $response_types;do
				echo "${subj}_${task_name}_run-${n_run}_events.tsv"
				echo "response_col_idx : ${response_col_idx}"
				echo "response : ${response}"

				#creating the timing
				cat ${subj}_${task_name}_run-${n_run}_events.tsv | awk -v response_col_idx="$response_col_idx" -v event_type="$response" -v onset_time_col_idx="$onset_time_col_idx" -v duration_col_idx="$duration_col_idx" '{if ($response_col_idx==event_type) {print $onset_time_col_idx, $duration_col_idx, "1"}}' > ${response}_run${n_run}.txt
				#output for monitoring
				cat ${subj}_${task_name}_run-${n_run}_events.tsv | awk -v response_col_idx="$response_col_idx" -v event_type="$response" -v onset_time_col_idx="$onset_time_col_idx" -v duration_col_idx="$duration_col_idx" '{if ($response_col_idx==event_type) {print $onset_time_col_idx, $duration_col_idx, "1"}}' | head -n 5
			done
        done
        cd ../..
done