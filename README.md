# BIDS-to-FSL-converter-bash-script

# Usage :
1) Assure that your `-event.tsv` files in your dataset conforms to the following standard: 
`{subj}_{task_name}_run-{n_run}_events.tsv`
2) Place the script in the main directory of your BIDS datasets containing all subjects
3) open a terminal in the dataset directory and run the script using:

`bash bids_to_FSL_timings.sh -t {task_name} -n {num_runs} -r {response_col_idx} -e {response_types} -o {onset_time_col_idx} -d {duration_col_idx}`

**ALL PARAMETERS ARE REQUIRED** , Parametric modulation is automatically set to 1

# FLAGS DESCRIPTION
-t) **task_name** is the name of the task the subjects are executing  (if you have multiple tasks just run the script twice with different task names :D )

e.g. -> `"task-flanker"`

-n) **num_runs** is the number of runs (duh) for a single task 

e.g -> `2`

-r) **reponse_col_idx** is the column's index of the subject response type (sometimes called *event_type* )in the `-events.tsv` file 

e.g. -> `3`

-e) **response_types** are all possible values for the `reponse_col` we discussed before, the whole parameter **must** be **double-quoted** and the individual response types **must** be **space-separated** between them , as in the example:

e.g -> `"incongruent_correct congruent_correct res3 res4"`

-o) **onset_time_col_idx** is the column's index of the subject's onset time (aka timestamp of the start of the event) 

e.g. -> `1`

-d) **duration_col_idx** is the column's index of the subject's duration time for the event

e.g. -> `2`
