%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads an image file with AxB pixels and produces a column vector of bits
% of length Q=AxBx3x8 where 3 represents the R, G and B matrices used to
% represent the image and 8 represents an 8 bit integer. If P>Q then
% the vector is padded at the bottom with zeros.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
% filename (String) = The file name of the image
% P (Integer) = Number of bits to produce at the output - Should be greater
% than or equal to Q=AxBx3x8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
% bitsOut (Px1 Integers) = P bits (1's and 0's) representing the image
% x (Integer) = Number of pixels in image in x dimension
% y (Integer) = Number of pixels in image in y dimension
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bitsOut,x,y]=fImageSource(filename,P);
Image=imread(filename);
[x,y,~]=size(Image); %Calculate Image Size, x(number of pixels vertical) and y(number of pixels horizontal)
ImageBin=de2bi(Image,8); %Since 255 equal to 2^8-1, we use 8 bits to represent a decimal number
bitsOut=reshape(ImageBin',[],1); %Reshape as a column
if length(bitsOut)<P
    bitsOut(P)=0; %Pad Zeros
end
bitsOut=double(bitsOut);
end