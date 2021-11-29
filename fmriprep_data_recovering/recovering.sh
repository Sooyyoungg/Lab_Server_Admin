#!/bin/bash
data_path='/scratch/bigdata/ABCD/abcd-fmriprep-task'
original_path='/scratch/bigdata/ABCD/abcd-fmriprep-rs'

# subject list
subs=$(find "$original_path/abcd-fmriprep-rs-downsampling" -name "fmriprep-deri-*")

for sub in $subs
do
        sub_num_array=($(echo $sub | tr "-" " "))
        sub_deri=${sub_num_array[-1]}
        sub_num="sub-$sub_deri"
        echo $sub_num

        # untar file recovering
        list=("desc-confounds_timeseries.json" "desc-confounds_timeseries.tsv" "from-scanner_to-T1w_mode-image_xfm.txt" "from-T1w_to-scanner_mode-image_xfm.txt" "space-MNIPediatricAsym_cohort-4_res-2_boldref.nii.gz" "space-MNIPediatricAsym_cohort-4_res-2_desc-brain_mask.json" "space-MNIPediatricAsym_cohort-4_res-2_desc-brain_mask.nii.gz" "space-MNIPediatricAsym_cohort-4_res-2_desc-preproc_bold.json" "space-MNIPediatricAsym_cohort-4_res-2_desc-preproc_bold.nii.gz")

        mkdir "$original_path/abcd-fmriprep-rs-tar/fmriprep-deri-$sub_deri"
        mkdir "$original_path/abcd-fmriprep-rs-untar/fmriprep-deri-$sub_deri/fmriprep"
        mkdir "$original_path/abcd-fmriprep-rs-untar/fmriprep-deri-$sub_deri/fmriprep/$sub_num"
        mkdir "$original_path/abcd-fmriprep-rs-untar/fmriprep-deri-$sub_deri/fmriprep/$sub_num/ses-baselineYear1Arm1"
        mkdir "$original_path/abcd-fmriprep-rs-untar/fmriprep-deri-$sub_deri/fmriprep/$sub_num/ses-baselineYear1Arm1/func"

        # find total data about each subject
        all_sub_files=$(find $data_path -name "$sub_num*")
        #echo $all_sub_files

        is_tar=False
        for file in $all_sub_files
        do
                # file: /scratch/bigdata/ABCD/abcd-fmriprep-task/sub-NDARINV3MJ73KP6_ses-baselineYear1Arm1_task-rest_run-2_space-MNIPediatricAsym_cohort-4_res-2_desc-preproc_bold_ds.npz
                # file_name: sub-NDARINV3MJ73KP6_ses-baselineYear1Arm1_task-rest_run-2_space-MNIPediatricAsym_cohort-4_res-2_desc-preproc_bold_ds.npz
                file_array=($(echo $file | tr "/" " "))
                file_name=${file_array[-1]}

                # tar file
                # file_finish: npz
                file_fin=($(echo $file | tr "." " "))
                file_finish=${file_fin[-1]}
                if [ "$file_finish" == "tar" ]
                then
                        cp $file "$original_path/abcd-fmriprep-rs-tar/fmriprep-deri-$sub_deri/$sub_num.tar"
                        is_tar=True
                fi

                # untar file
                for l in ${list[@]}
                do
                        if (echo "${file}" | fgrep -q "${l}")
                        then
                                cp $file "$original_path/abcd-fmriprep-rs-untar/fmriprep-deri-$sub_deri/fmriprep/$sub_num/ses-baselineYear1Arm1/func/$file_name"
                        fi
                done
        done

        # Whether this subject has tar file or not
        if [ "${is_tar}" != "True" ]
        then
                echo "$sub_num doesn't have tar file"
        fi

        # atlas applied files covering in folder - ex) sub-NDARINVZZZP87KR folder
        atlas_folder=$(find $data_path -type d -name "$sub_num")
        mkdir $original_path"/abcd-fmriprep-rs-time/fmriprep-deri-"$sub_deri
        mkdir $original_path"/abcd-fmriprep-rs-time/fmriprep-deri-"$sub_deri"/fmriprep"
        cp -r $atlas_folder "$original_path/abcd-fmriprep-rs-time/fmriprep-deri-$sub_deri/fmriprep/$sub_num"
        break
done
