function b=convert_seg_to_boundaries(seg)
%Performs conversion from an array containing region labels (seg) 
%to one containing the boundaries between the regions (b)

seg=padarray(seg,[1,1],'post','replicate');

b=abs(conv2(seg,[-1,1],'same'))+abs(conv2(seg,[-1;1],'same'))+abs(conv2(seg,[-1,0;0,1],'same'))+abs(conv2(seg,[0,-1;1,0],'same'));

b=im2bw(b(1:end-1,1:end-1),0);
