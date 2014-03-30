close all;
clear all;
clc;
tic;

image = imread('fabric.png');

imageR = image(:, :, 1);
imageG = image(:, :, 2);
imageB = image(:, :, 3);

hsvImage = rgb2hsv(image);

imageHue = hsvImage(:, :, 1);

imageGray = im2double(rgb2gray(image));

[rows, cols] = size(image);

imageR = im2double(imageR);
imageG = im2double(imageG);
imageB = im2double(imageB);

% Laws' Masks
L3L3 = [1 2 1; 
        2 4 2; 
        1 2 1];
    
L3E3 = [-1 0 1;
        -2 0 2;
        -1 0 1];
    
L3S3 = [-1 2 -1;
        -2 4 -2;
        -1 2 -1];
    
E3L3 = [-1 -2 -1;
        0 0 0;
        1 2 1];
    
E3E3 = [1 0 -1;
        0 0 0;
        -1 0 1];
    
E3S3 = [1 -2 1;
        0 0 0;
        -1 2 -1];
    
S3L3 = [-1 -2 -1;
        2 4 2;
        -1 -2 -1];
    
S3E3 = [1 0 -1;
        -2 0 2;
        1 0 -1];
    
S3S3 = [1 -2 1;
        -2 4 -2;
        1 -2 1];
    
E5L5 = [-1 -4 -6 -4 -1;
        -2 -8 -12 -8 -2;
        0 0 0 0 0;
        2 8 12 8 2;
        1 4 6 4 1];
    
R5R5 = [1 -4 6 -4 1;
        -4 16 -24 16 -4;
        6 -24 36 -24 6;
        -4 16 -24 16 -4;
        1 -4 6 -4 1];
    
E5S5 = [-1 0 2 0 -1;
        -2 0 4 0 -2;
        0 0 0 0 0;
        2 0 -4 0 2;
        1 0 -2 0 1];
    
L5S5 = [-1 0 2 0 -1;
        -4 0 8 0 -4;
        -6 0 12 0 -6;
        -4 0 8 0 -4;
        -1 0 2 0 -1];


W5 = [ -1 2 0 -2 -1 ];


lawsMask = W5' * W5;


% lawsMask = L3L3;

convolvedImgR = ImageMaskFilter(imageR, lawsMask);
convolvedImgG = ImageMaskFilter(imageG, lawsMask);
convolvedImgB = ImageMaskFilter(imageB, lawsMask);


convolvedImgHue = ImageMaskFilter(imageHue, lawsMask);

convolvedImgGray = ImageMaskFilter(imageGray, lawsMask);

subplot(231); 
imshow(convolvedImgR); 
title('Convolved Image (Red)');

subplot(232);
imshow(convolvedImgG);
title('Convolved Image (Green)');

subplot(233); 
imshow(convolvedImgB); 
title('Convolved Image (Blue)');

subplot(234); 
imshow(convolvedImgHue); 
title('Convolved Image (HUE)');

subplot(235); 
imshow(convolvedImgGray); 
title('Convolved Image (Grayscale)');


display('Paused.');
display('Please press enter to see results with Mean, Absolute Mean and Standart Deviation');
pause;



% Laws Masks

% Mean Statistics

filterSize = 7;

% Apply Mean Statistics to each RGB channel
meanOutputR = FindImageMean(convolvedImgR, filterSize);
meanOutputG = FindImageMean(convolvedImgG, filterSize);
meanOutputB = FindImageMean(convolvedImgB, filterSize);

% Apply Mean Stats to Hue component
meanOutputHue = FindImageMean(convolvedImgHue, filterSize);

% Apply Mean Stats to grayscale image
meanOutputGray = FindImageMean(convolvedImgGray, filterSize);

% Combine RGB channels
meanOutput(:, :, 1) = meanOutputR;
meanOutput(:, :, 2) = meanOutputG;
meanOutput(:, :, 3) = meanOutputB;

figure; subplot(231); imshow(meanOutputR); title('Mean Statistics (Red)');
subplot(232); imshow(meanOutputG); title('Mean Statistics (Green)');
subplot(233); imshow(meanOutputB); title('Mean Statistics (Blue)');
subplot(234); imshow(meanOutputHue); title('Mean Statistics (HUE)');
subplot(235); imshow(meanOutputGray); title('Mean Statistics (Grayscale)');
subplot(236); imshow(meanOutput); title('Mean Statistics (Combined RGB)');

% Absolute Mean Statistics

% Apply Absolute Mean Statistics to each RGB channel
absMeanOutputR = FindImageMean(abs(convolvedImgR), filterSize);
absMeanOutputG = FindImageMean(abs(convolvedImgG), filterSize);
absMeanOutputB = FindImageMean(abs(convolvedImgB), filterSize);

% Apply Absolute Mean Stats to Hue component
absMeanOutputHue = FindImageMean(abs(convolvedImgHue), filterSize);

% Apply Absolute Mean Stats to grayscale image
absMeanOutputGray = FindImageMean(abs(convolvedImgGray), filterSize);

% Combine RGB channels
absMeanOutput(:,:,1) = absMeanOutputR;
absMeanOutput(:,:,2) = absMeanOutputG;
absMeanOutput(:,:,3) = absMeanOutputB;


figure; subplot(231); imshow(absMeanOutputR); title('Absolute Mean Statistics (Red)');
subplot(232); imshow(absMeanOutputG); title('Absolute Mean Statistics (Green)');
subplot(233); imshow(absMeanOutputB); title('Absolute Mean Statistics (Blue)');
subplot(234); imshow(absMeanOutputHue); title('Absolute Mean Statistics (HUE)');
subplot(235); imshow(absMeanOutputGray); title('Absolute Mean Statistics (Grayscale)');
subplot(236); imshow(absMeanOutput); title('Absolute Mean Statistics (Combined RGB)');


% Std. Dev. Statistics

% Apply Standard Deviation Statistics to each RGB channel
stdDevOutputR = FindImageStdDev(convolvedImgR);
stdDevOutputG = FindImageStdDev(convolvedImgG);
stdDevOutputB = FindImageStdDev(convolvedImgB);

% Apply Std. Dev. Stats to Hue component
stdDevOutputHue = FindImageStdDev(convolvedImgHue);

% Apply Std. Dev. Stats to grayscale image
stdDevOutputGray = FindImageStdDev(convolvedImgGray);

% Combine RGB channels
stdDevOutput(:,:,1) = stdDevOutputR;
stdDevOutput(:,:,2) = stdDevOutputG;
stdDevOutput(:,:,3) = stdDevOutputB;

figure; subplot(231); imshow(stdDevOutputR); title('Std Deviation Statistics (Red)');
subplot(232); imshow(stdDevOutputG); title('Std Deviation Statistics (Green)');
subplot(233); imshow(stdDevOutputB); title('Std Deviation Statistics (Blue)');
subplot(234); imshow(stdDevOutputHue); title('Std Deviation Statistics (HUE)');
subplot(235); imshow(stdDevOutputHue); title('Std Deviation Statistics (Grayscale)');
subplot(236); imshow(stdDevOutput); title('Std Deviation Statistics (Combined RGB)');   






toc;