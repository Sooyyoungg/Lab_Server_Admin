#!/bin/bash
data_path='/scratch/bigdata/ABCD/abcd-fmriprep-task'
original_path='/scratch/bigdata/ABCD/abcd-fmriprep-rs'

# subject 모으기
sub_full=$(find $original_path'/abcd-fmriprep-rs-downsampling' -name "fmriprep-deri-*")
for sub in $sub_full
do
        # sub: /scratch/bigdata/ABCD/abcd-fmriprep-rs/abcd-fmriprep-rs-time/fmriprep-deri-NDARINV3MJ73KP6
        # sub_num: sub-NDARINV3MJ73KP6
        sub_num_array=($(echo $sub | tr "-" " "))
        sub_deri=${sub_num_array[-1]}
        sub_num="sub-"$sub_deri
        echo $sub_num

        # tar file recovering - 각 subject당 1개의 file
        tar=$(find $data_path -name $sub_num".tar")
        mkdir $original_path"/abcd-fmriprep-rs-tar/fmriprep-deri-"$sub_deri
        cp $tar $original_path"/abcd-fmriprep-rs-tar/fmriprep-deri-"$sub_deri

        # untar file recovering - 각 run당 9개의 file
        list=("desc-confounds_timeseries.json" "desc-confounds_timeseries.tsv" "from-scanner_to-T1w_mode-image_xfm.txt" "from-T1w_to-scanner_mode-image_xfm.txt" "space-MNIPediatricAsym_cohort-4_res-2_boldref.nii.gz" "space-MNIPediatricAsym_cohort-4_res-2_desc-brain_mask.json" "space-MNIPediatricAsym_cohort-4_res-2_desc-brain_mask.nii.gz" "space-MNIPediatricAsym_cohort-4_res-2_desc-preproc_bold.json" "space-MNIPediatricAsym_cohort-4_res-2_desc-preproc_bold.nii.gz")
        for l in ${list[@]}
        do
                rest=($(find $data_path -name $sub_num"_ses-baselineYear1Arm1_task-rest_*"$l))
                mkdir $original_path"/abcd-fmriprep-rs-untar/fmriprep-deri-"$sub_deri"/fmriprep"
                mkdir $original_path"/abcd-fmriprep-rs-untar/fmriprep-deri-"$sub_deri"/fmriprep/"$sub_num
                mkdir $original_path"/abcd-fmriprep-rs-untar/fmriprep-deri-"$sub_deri"/fmriprep/"$sub_num"/ses-baselineYear1Arm1"
                mkdir $original_path"/abcd-fmriprep-rs-untar/fmriprep-deri-"$sub_deri"/fmriprep/"$sub_num"/ses-baselineYear1Arm1/func"
                cp $rest $original_path"/abcd-fmriprep-rs-untar/fmriprep-deri-"$sub_deri"/fmriprep/"$sub_num"/ses-baselineYear1Arm1/func"
        done

        # atlas 적용한 files covering
        atlas_folder=($(find $data_path -name $sub_num -type d))
        mkdir $original_path"/abcd-fmriprep-rs-time/fmriprep-deri-"$sub_deri
        mkdir $original_path"/abcd-fmriprep-rs-time/fmriprep-deri-"$sub_deri"/fmriprep"
        cp -r $atlas_folder $original_path"/abcd-fmriprep-rs-time/fmriprep-deri-"$sub_deri"/fmriprep"

done
