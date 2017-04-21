% HybridImage 
% Na Cui
clc; clear all; close all;

%% Read Raw images
image1 = imread('minion.jpg');    
figure('Name','raw minion');
imshow(uint8(image1));                

image2 = imread('cat.jpg');      
figure('Name','raw cat');
imshow(uint8(image2));                

%% Set Filtering
% low-pass filter 
cutoff_high = 3;    
% high-pass filter 
cutoff_low = 0.8;    
% low-pass filter
Filter_Gaussian = fspecial('gaussian', [40 40], cutoff_high);  
% high-pass filter
Filter_Laplacian = fspecial('laplacian', cutoff_low);           

image1 = rgb2hsv(image1);  
 % change it from uint8 to double
image1 = hsv2rgb(image1);                
% implement Gaussian low-pass filter to image 1
IG = imfilter(image1, Filter_Gaussian, 'same');     
figure('Name','filtered minion');
imshow(IG);                                 

 % convert image 2 from RGB to HSV
image2 = rgb2hsv(image2);                    
IL = image2;
% gray scale value
image2 = image2(:, :, 3);
% implement Laplacian high-pass filter to image 2
ILTemp = imfilter(image2, Filter_Laplacian, 'same');   

ILTemp_MIN = min(min(ILTemp));
ILTemp_MAX = max(max(ILTemp));
IL(:, :, 3) = (ILTemp-ILTemp_MIN)/(ILTemp_MAX - ILTemp_MIN);
% convert image 2 from HSV to RGB
IL = hsv2rgb(IL);                           
figure('Name','filtered cat');
imshow(IL);                                

%% Hybrid Imaging
% integrate hybrid image
H = 0.3*IG + 0.7*IL;
figure('Name','Hybrid Image');
imshow(H);                                 
