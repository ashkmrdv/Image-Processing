function show_results(boundariesPred,boundariesHuman,f1score,TP,FP,FN)
%Function used to show comparison between predicted and human image segmentations.
    
maxsubplot(2,2,3); imagescc(boundariesPred); title('Predicted Boundaries')
[a,b]=size(boundariesPred);
if a>b
    ylabel(['f1score=',num2str(f1score,2)]);
else
    xlabel(['f1score=',num2str(f1score,2)]);
end
maxsubplot(2,2,4); imagescc(mean(boundariesHuman,3)); title('Human Boundaries')

maxsubplot(2,3,1); imagescc(TP); title('True Positives')
maxsubplot(2,3,2); imagescc(FP); title('False Positives')
maxsubplot(2,3,3); imagescc(FN); title('False Negatives')
colormap('gray'); 
drawnow;



function imagescc(I)
%Combines imagesc with some other commands to improve appearance of images
imagesc(I,[0,1]); 
axis('equal','tight'); 
set(gca,'XTick',[],'YTick',[]);


function position=maxsubplot(rows,cols,ind,fac)
%Create subplots that are larger than those produced by the standard subplot command.
%Good for plots with no axis labels, tick labels or titles.
%*NOTE*, unlike subplot new axes are drawn on top of old ones; use clf first
%if you don't want this to happen.
%*NOTE*, unlike subplot the first axes are drawn at the bottom-left of the
%window.

if nargin<4, fac=0.075; end
position=[(fac/2)/cols+rem(min(ind)-1,cols)/cols,...
          (fac/2)/rows+fix((min(ind)-1)/cols)/rows,...
          (length(ind)-fac)/cols,(1-fac)/rows];
axes('Position',position); 


