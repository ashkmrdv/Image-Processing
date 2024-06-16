This was a part of my course work. That I did while I was pursuing my masters degree in AI. 

The course work contains a matlab code for finding out the border for images. The following details contains the guidelines on how to implement it and also the methods that I followed for performing the image segmentation. I have also mentioned the results obtained while training and testing.

The main file has to be run to predict the border line and display the segmented image. 

In my segmentation code I have used around 6 methods and took a mean of all the methods. The reason was that I would like my code to be a bit robust and even if one of the algorithm detects false edges or fails to detect meaningful edges, the other will compensate for it. I have provided the list of methods I used. Upon executing this main, border detection will happen for all the twelve images one after the other.

The list of methods I used are as follows

---> Sobel edge detection method
---> K-means clustering 
---> Thresholding with open 
---> Thresholding with close
---> Gabor filters 
---> Laplacian filter

The largest value of accuracy I obtained was 0.76 and the minimum most value was 0.46 and the average value was around 0.61.

One more key note is the total execution time for 12 images was around 123 seconds. 
So for one image it will take some where around 11 seconds max. 

The images in the folder are the ones used for testing.
