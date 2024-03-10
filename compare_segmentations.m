function compare_segmentations(imNum)
%Compares a predicted image segmentation to human segmentations of the same image. 
%The number of the image used is defined by the input parameter "imNum".
%
%Note, this function assumes that images and their corresponding human segmentations 
%are stored in a sub-directory "Images" of the current working directory. If they are 
%stored elsewhere, change the following to point to the correct location:
ImDir='Images/';

%load image 
imFile=[ImDir,'im',int2str(imNum),'.jpg'];
I=im2double(imread(imFile));

%segment image
segPred=segment_image(I); %<<<<<< calls your method for image segmentation

%convert segmentation to a boundary map, if necessary
segPred=round(segPred);
inseg=unique(segPred(:));
if min(inseg)==0 & max(inseg)==1
    %result is a boundary map
    boundariesPred=double(segPred);
else
    %result is a segmentation map
    boundariesPred=double(convert_seg_to_boundaries(segPred)); %convert segmentation map to boundary map
end

%load human segmentations
humanFiles=[ImDir,'im',int2str(imNum),'seg*.png'];
numFiles=length(dir(humanFiles));
for i=1:numFiles
    humanFile=['Images/im',int2str(imNum),'seg',int2str(i),'.png'];
    boundariesHuman(:,:,i)=im2double(imread(humanFile));
end

%evaluate and display results
[f1score,TP,FP,FN]=evaluate(boundariesPred,boundariesHuman);
figure(1), clf
show_results(boundariesPred,boundariesHuman,f1score,TP,FP,FN);
