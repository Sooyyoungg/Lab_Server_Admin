# fmriprep_data_recovering
상황: 모든 abcd-fmriprep-rs에 있는 파일들이 폴더 구분 없이 다 섞여서 옮겨짐
해결책: 각 subject별로 resting state에 관련된 파일들 복사해서 원래 폴더로 
서버에서 abcd fmriprep해둔 data의 원본 tar파일, untar파일뿐만 아니라 atlas를 적용한 abcd-fmriprep-rs-time, downsampling한 abcd-fmriprep-rs-downsampling을 되돌리기 위해 만든 code
