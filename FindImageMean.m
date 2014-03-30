function [ imageOutput ] = FindImageMean( image, filterSize )
%FINDIMAGEMEAN Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    filterSize = 5;
end

filter = (1 / (filterSize ^ 2)) * ones(filterSize);

imageMean = conv2(image, filter, 'same');

maxValue = max(max(imageMean));

meanOutput = imageMean / maxValue;

imageOutput = meanOutput;

end

