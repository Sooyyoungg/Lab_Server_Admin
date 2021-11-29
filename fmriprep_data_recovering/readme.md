# fmriprep_data_recovering
* Problem    
    : 모든 abcd-fmriprep-rs에 있는 파일들이 폴더 구분 없이 다 섞여서 옮겨짐   
    : All the files in abcd-fmriprep-rs folder are moved to abcd-fmriprep-task without order
* Solution    
    : 각 subject별로 resting state에 관련된 파일들 복사해서 원래 폴더로       
    : Copy each resting state file to the original folder by subjects

* Codes     
    : 서버에서 abcd fmriprep해둔 data의 원본 tar파일 & untar파일 & atlas를 적용한 abcd-fmriprep-rs-time & downsampling한 abcd-fmriprep-rs-downsampling을 되돌리기 위해 만든 code    
    : get back tar, untar, abcd-fmriprep-rs-time and abcd-fmriprep-rs-downsampling files in server     
    * tar & untar files : preprocessed abcd files using fmriprep     
    * abcd-fmriprep-rs-time files : preprocessed files with applied atlas
    * abcd-fmriprep-downsampling files : downsampled files in terms of the image size     
    **Order of Preprocessing: untar -> applying atlas -> downsampling**
