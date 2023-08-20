%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display the received image by converting bits back into R, B and G
% matrices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% bitsIn (Px1 Integers) = P demodulated bits of 1's and 0's
% x (Integer) = Number of pixels in image in x dimension
% y (Integer) = Number of pixels in image in y dimension
% Title: Image Title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% None
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fImageSink(bitsIn,x,y,Title)
Image=zeros(x,y,3); %RGB Array for Image
count=1;
for i=1:8:x*y*3*8
    Image(count)=bi2de(bitsIn(i:i+7)'); %Convert binear to Decimal
    count=count+1;
end
Image=uint8(Image);
figure;
imshow(Image);
title(Title);
end