close all;
clear all;
clc;
tic;

image = imread('fabric.png');

image = rgb2gray(image);

[rows, cols] = size(image);

entropyOutput = entropyfilt(image);

entropyOutput = mat2gray(entropyOutput);

% subplot(1, 2, 1);
% imshow(image);
% subplot(1, 2, 2);
% imshow(entropyOutput);


windowSize = 9; % 3 5 7 9 11 13 15 17 19 21

if windowSize > rows || windowSize > cols
    error('window size error');
end

windowCenter = floor(windowSize / 2);

image = padarray(image, [windowCenter windowCenter]);
[rows, cols] = size(image);

% offset - p-by-2 array of integers specifying the distance between 
% the pixel of interest and its neighbor. Each row in the
% array is a two-element vector, [row_offset, col_offset],
% that specifies the relationship, or offset, of a pair of pixels.
% row_offset is the number of rows between the pixel-of-interest and
% its neighbor. col_offset is the number of columns between the pixel-of-interest
% and its neighbor. Because the offset is often expressed
% as an angle, the following table lists the offset values that specify common angles,
% given the pixel distance D.
%
% Angle        Offset
% 
%   0           [  0 D ]
% 
%  45           [ -D D ]
% 
%  90           [ -D 0 ]
% 
% 135           [ -D -D ]
% offset = [0, 1];
offset = [-1 0];

% numLevels - specifying the number of gray-levels to use
% when scaling the grayscale values in I. For example,
% if NumLevels is 8, graycomatrix scales the values in I 
% so they are integers between 1 and 8. The number of
% gray-levels determines the size of the gray-level co-occurrence matrix (glcm).
numLevels = 8;

% symmetric - Boolean that creates a GLCM where the ordering of values
% in the pixel pairs is not considered. For example,
% when 'Symmetric' is set to true, graycomatrix counts both 1,2 and 2,1 
% pairings when calculating the number of times the value 1 is adjacent 
% to the value 2. When 'Symmetric' is set to false, graycomatrix only counts
% 1,2 or 2,1, depending on the value of 'offset'. 
symmetric = false;

ContrastImage = zeros(rows, cols);
ContrastImage = padarray(ContrastImage, [windowCenter windowCenter]);

CorrelationImage = zeros(rows, cols);
CorrelationImage = padarray(CorrelationImage, [windowCenter windowCenter]);

EnergyImage = zeros(rows, cols);
EnergyImage = padarray(EnergyImage, [windowCenter windowCenter]);

HomogeneityImage = zeros(rows, cols);
HomogeneityImage = padarray(HomogeneityImage, [windowCenter windowCenter]);

for ii = (windowCenter + 1) : (rows - windowCenter)
    
    for jj = (windowCenter + 1) : (cols - windowCenter)
        
        window = image((ii - windowCenter) : (ii + windowCenter),...
                       (jj - windowCenter) : (jj + windowCenter));
                   
        % creates a gray-level co-occurrence matrix (GLCM) from image
        glcm = graycomatrix(window, 'Offset', offset, 'NumLevels', numLevels,'Symmetric', symmetric);
        
%         contrast = graycoprops(glcm, 'Contrast');
%         correlation = graycoprops(glcm, 'Correlation');
%         energy = graycoprops(glcm, 'Energy');
%         homogeneity = graycoprops(glcm, 'Homogeneity');

        coprops = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
        
        ContrastImage(ii, jj) = coprops.Contrast;
        CorrelationImage(ii, jj) = coprops.Correlation;
        EnergyImage(ii, jj) = coprops.Energy;
        HomogeneityImage(ii, jj) = coprops.Homogeneity;
        
    end
    display(['Percent: ' num2str(floor((ii / rows) * 100))]);
    %ii
end

image = image(windowCenter + 1 : (end - windowCenter), windowCenter + 1 : (end - windowCenter));
entropyOutput = entropyOutput(windowCenter + 1 : (end - windowCenter), windowCenter + 1 : (end - windowCenter));
ContrastImage = ContrastImage(windowCenter + 1 : (end - windowCenter), windowCenter + 1 : (end - windowCenter));
CorrelationImage = CorrelationImage(windowCenter + 1 : (end - windowCenter), windowCenter + 1 : (end - windowCenter));
EnergyImage = EnergyImage(windowCenter + 1 : (end - windowCenter), windowCenter + 1 : (end - windowCenter));
HomogeneityImage = HomogeneityImage(windowCenter + 1 : (end - windowCenter), windowCenter + 1 : (end - windowCenter));

toc;

% showing and writing resulting images
subplot(2, 3, 1); imshow(image); title('Original Image');
imwrite(image, 'Results/CoOccurence/originalImage.tif');

subplot(2, 3, 2); imshow(entropyOutput); title('Entropy Image');
imwrite(entropyOutput, 'Results/CoOccurence/entropyImage.tif');
 
subplot(2, 3, 3); imshow(ContrastImage); title('Contrast Image');
imwrite(ContrastImage,'Results/CoOccurence/contrastImage.tif');

subplot(2, 3, 4); imshow(CorrelationImage); title('Correlation Image');
imwrite(CorrelationImage,'Results/CoOccurence/correlationImage.tif');

subplot(2, 3, 5); imshow(EnergyImage); title('Energy Image');
imwrite(EnergyImage,'Results/CoOccurence/energyImage.tif');

subplot(2, 3, 6); imshow(HomogeneityImage); title('Homogeneity Image');
imwrite(HomogeneityImage,'Results/CoOccurence/homogeneityImage.tif');

beep;

