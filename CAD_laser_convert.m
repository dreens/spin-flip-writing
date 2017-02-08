%% Mess with a figure
% I want to use MATLAB image processing to mess with a figure that I don't
% like the coloring on.

[~, map, alpha] = imread('~/Documents/OH/spin-flip-writing/blue-red-yellow-v2_CAD.png');
image = imread('~/Documents/OH/spin-flip-writing/blue-red-yellow-v2_CAD.png');



red   = image(:,:,1);
green = image(:,:,2);
blue  = image(:,:,3);

imtool(image)

%%
getregion = @(r1,r2,g1,g2,b1,b2) ...
    r1  < red   & red   < r2 & ...
    g1  < green & green < g2 & ...
    b1  < blue  & blue  < b2 ;

%laser
plane = getregion(-1,5,115,135,230,256);
plane = imdilate(plane,strel('diamond',2));
red(plane) = 230;
green(plane) = 0;
blue(plane) = 255;

%imtool2 r28 g106 b51
%imtool3 r0 g75 b10

t = 120;
red(alpha < t) = 230;%uint8(177+double(red(alpha < t)/2));
green(alpha < t) = 230;%uint8(177+double(green(alpha < t)/2));
blue(alpha < t) = 230;%uint8(177+double(blue(alpha < t)/2));

image2 = image;
image2(:,:,1) = red;
image2(:,:,2) = green;
image2(:,:,3) = blue;

%some clipping
%image2 = image2(250:1450,:,:);

imtool(image2)

imwrite(image2,'~/Documents/OH/spin-flip-writing/CAD_recolor_laser.PNG')%,'Alpha',double(alpha/255))