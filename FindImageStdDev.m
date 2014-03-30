function [ imageOutput ] = FindImageStdDev( image )
%FINDIMAGESTDDEV Summary of this function goes here
%   Detailed explanation goes here

stdDevOutput = stdfilt(image);

maxValue = max(max(stdDevOutput));

stdDevOutput = stdDevOutput / maxValue;

imageOutput = stdDevOutput;

end

