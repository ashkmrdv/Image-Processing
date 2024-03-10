function [f1score,TP,FP,FN]=evaluate(boundariesPred,boundariesHuman)
%Returns the f1score quantifying the quality of the match between predicted
%and human image segmentations.
%
%Note both inputs are assumed to show the boundaries between image regions.

r=3; %set tolerance for boundary matching
neighbourhood=strel('disk',r,0); 

%make dilated and thinned versions of boundaries
boundariesPredThin = boundariesPred.*bwmorph(boundariesPred,'thin',inf);
boundariesHumanThin = prod(imdilate(boundariesHuman,neighbourhood),3);
boundariesHumanThin = boundariesHumanThin.*bwmorph(boundariesHumanThin,'thin',inf);
boundariesPredThick = imdilate(boundariesPred,neighbourhood);
boundariesHumanThick = max(imdilate(boundariesHuman,neighbourhood),[],3);

%Calculate statistics
%true positives: pixels from predicted boundary that match pixels from any human boundary 
%(human boundaries dilated to allow tolerance to match location)
TP=boundariesPredThin.*boundariesHumanThick;
%false positives: pixels that are predicted but do not match any human boundary
FP=max(0,boundariesPred-boundariesHumanThick);
%false negatives: human boundary pixels that do not match predicted boundary 
%(predicted boundaries dilated to allow tolerance to match location)
FN=max(0,boundariesHumanThin-boundariesPredThick);

numTP=sum(TP(:));
numFP=sum(FP(:));
numFN=sum(FN(:));

f1score=2*numTP/(2*numTP+numFP+numFN);


