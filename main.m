%Hello sir.
%
% In my segmentation code I have used around 6 methods and took a mean of
% all the methods. The reason was that I would like my code to be a bit
% robust and even if one of the algorithm detects false edges or fails to 
% detect meaningful edges, the other will compensate for it. I have
% provided the list of methods I used. Upon executing this main, 
% border detection will happen for all the twelve images one after the other.
%
% The list of methods I used are as follows
%
% ---> Sobel edge detection method
% ---> K-means clustering 
% ---> Thresholding with open 
% ---> Thresholding with close
% ---> Gabor filters 
% ---> Laplacian filter
%
% The largest value I obtained was 0.76 and the minimum most value was
% 0.46 and the average value was around 0.61.
% Hope it does a decent job for the images you intend to work on
%
% One more key note is the total execution time for 12 images was around 123 seconds. 
% So for one image it will take some where around 11 seconds max. 

for i=1:12
compare_segmentations(i);
end




