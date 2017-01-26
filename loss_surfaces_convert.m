%% Mess with a figure
% I want to use MATLAB image processing to mess with a figure that I don't
% like the coloring on.

image = imread('~/Documents/OH/spin-flip-writing/Loss_Surface_Chunks_0-320_0.jpeg');

red   = image(:,:,1);
green = image(:,:,2);
blue  = image(:,:,3);


imtool(image)

% for comparison
imagem = imread('~/Documents/OH/spin-flip-writing/blue-red-yellow-v2_CAD.png');
imtool(imagem)
%%
getplane = @(r1,r2,g1,g2,b1,b2) ...
    r1  < red   & red   < r2 & ...
    g1  < green & green < g2 & ...
    b1  < blue  & blue  < b2 ;

%red
plane = getplane(110,210,-1,80,-1,60);
red(plane) = 120;
green(plane) = 0;
blue(plane) = 0;

%orange
plane = getplane(200,256,81,163,-1,105);
red(plane) = 180;
green(plane) = 0;
blue(plane) = 0;

%yellow
plane = getplane(180,256,162,202,-1,43);
red(plane) = 150;
green(plane) = 150;
blue(plane) = 0;

%green
plane = getplane(52,152,151,195,6,186);
red(plane) = 0;
green(plane) = 0;
blue(plane) = 140;

%light blue
plane = getplane(-1,80,100,190,190,256);
red(plane) = 0;
green(plane) = 135;
blue(plane) = 255;

%dark blue
plane = getplane(-1,35,-1,101,-1,191);
red(plane) = 65;
green(plane) = 115;
blue(plane) = 205;

%background
plane = getplane(200,256,200,256,200,256);
red(plane) = 255;
green(plane) = 255;
blue(plane) = 255;




image2 = image;
image2(:,:,1) = red;
image2(:,:,2) = green;
image2(:,:,3) = blue;

%some clipping
image2 = image2(250:1450,:,:);

imtool(image2)

imwrite(image2,'~/Documents/OH/spin-flip-writing/Loss_Surface_Chunks_recolored.PNG')