
function Iseg=segment_image(I);
%I=imread("Images\im1.jpg");
Ig=im2gray(im2double(I));
Ig=imadjust(Ig,[0,1]);

% Performing gaussian smoothing to reduce noise 
Ig=conv2(Ig,fspecial("gaussian",15,2),"same");
n=1;

% K means clustering 

% Here I used the K means clustering. I converted the segment to boundaries
% before taking an average to make sure that mean is taken in the same
% metric across all other methods.

Iseg1=imsegkmeans(im2single(Ig),4);
Iseg1=im2double(Iseg1);
Iseg1=Iseg1-min(Iseg1);
m=max(Iseg1);
Iseg1=Iseg1./m;
Iseg1=convert_seg_to_boundaries(Iseg1);

% Thresholding and open and close 

% Here I have used arbitrary threshold value 0.25 and 0.75 since any
% threshold which works for one image will not work for another, so I didnt
% attempt much to correct the values according to one of the images. The
% threshold operation I performed was similar to matlab exercise in week 5,
% but the code was not copied.

S=size(Ig);
row=S(1);
col=S(2);

for i=1:row
    for j=1:col
        if (Ig(i,j)>=0.75)
            Ithresh(i,j)=0;

        elseif ((Ig(i,j)<0.75) &&(Ig(i,j)>=0.5))
                Ithresh(i,j)=1;

        elseif ((Ig(i,j) <0.5) &&(Ig(i,j)>=0.25))
                Ithresh(i,j)=2;
        
        elseif((Ig(i,j)<0.37))
            Ithresh(i,j)=3;
        end
    end
end

Iseg2=imopen(Ithresh,strel('disk',3,0));
Iseg3=imclose(Ithresh,strel('disk',3,0));

Iseg2=im2double(Iseg2);
Iseg3=im2double(Iseg3);

Iseg2=Iseg2-min(Iseg2);
m=max(Iseg2);
Iseg2=Iseg2./m;
Iseg3=Iseg3-min(Iseg3);
m=max(Iseg3);
Iseg3=Iseg3./m;

Iseg2=convert_seg_to_boundaries(Iseg2);
Iseg3=convert_seg_to_boundaries(Iseg3);

% Laplacian mask 

% Here I used the lapacian mask to enhance the difference in all directions
% which I felt would reinforce the border and contribute to increase in the
% pixel value along edges

Ilap=[-0.125,-0.125,-0.125;
    -0.125,1,-0.125;
    -0.125,-0.125,-0.125];

Iseg4=im2double(im2gray(conv2(Ig,Ilap,"same")));
Iseg4=imadjust(Iseg4,[0,1]);

Iseg4=Iseg4-min(Iseg4);
m=max(Iseg4);
Iseg4=Iseg4./m;

% Gabor filters

% I used the gabor filter algorithm which was a part of the assessed course
% work question. I changed the end value and the step value to get finer
% details 

for theta=0:0.5:359.5
    ga=gabor2(3,0.1,90,.75,theta);
    gabor(:,:,n)=conv2(Ig,ga,'valid');
    n=n+1;
end
gabor_max=[];
s=size(gabor);

for i=1:(s(1))
    for j=1:s(2)
        gabor_max(i,j)=max(gabor(i,j,:));
    end
end

gabor_max=imresize(gabor_max,size(Ig));
gabor_max=gabor_max-min(gabor_max);
gabor_max=gabor_max./max(gabor_max);

Iseg5=gabor_max;

% Sobel edge detection method

% This is a new method which is not a part of the course work. I came
% across sobel and found it to be one of the most commonly used algorithms
% for edge detection. I used it as one of the methods.

Iseg6=edge(Ig);

Iseg=(Iseg1+Iseg2+Iseg3+Iseg4+Iseg5+Iseg6)./5;
Iseg=wdenoise2(Iseg);

figure(3)
subplot(2,3,1),imagesc(Iseg1),colormap('gray'),colorbar
subplot(2,3,2),imagesc(Iseg2),colormap('gray'),colorbar
subplot(2,3,3),imagesc(Iseg3),colormap('gray'),colorbar
subplot(2,3,4),imagesc(Iseg4),colormap('gray'),colorbar
subplot(2,3,5),imagesc(Iseg5),colormap('gray'),colorbar
subplot(2,3,6),imagesc(Iseg6),colormap('gray'),colorbar





