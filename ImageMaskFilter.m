function [ imageOutput ] = ImageMaskFilter( image, filter )
%IMAGEMASKFILTER Summary of this function goes here
%   Detailed explanation goes here

% convImg = imfilter(image, filter, 'replicate', 'conv');
% 
% maxVal = max(max(convImg));
% 
% convImg = convImg/maxVal;
% 
% imageOutput = convImg;

filteredImage = filter2(filter, image) / 255;

maxValue = max(max(filteredImage));

filteredImage = filteredImage / maxValue;

imageOutput = filteredImage;

end

