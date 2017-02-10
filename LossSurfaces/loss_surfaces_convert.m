%% Mess with a figure
% I want to use MATLAB image processing to mess with a figure that I don't
% like the coloring on.

image = imread('~/Documents/OH/spin-flip-writing/Loss_Surface_Chunks_0-320_0.jpeg');

red   = image(:,:,1);
green = image(:,:,2);
blue  = image(:,:,3);

red2   = image(:,:,1);
green2 = image(:,:,2);
blue2  = image(:,:,3);


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
red2(plane) = 120;
green2(plane) = 0;
blue2(plane) = 0;

%orange
plane = getplane(200,256,81,163,-1,105);
red2(plane) = 180;
green2(plane) = 0;
blue2(plane) = 0;

%yellow
plane = getplane(180,256,162,202,-1,63);
red2(plane) = 150;
green2(plane) = 150;
blue2(plane) = 0;

%green
plane = getplane(52,152,151,195,6,186);
red2(plane) = 135;
green2(plane) = 135;
blue2(plane) = 135;

%light blue
plane = getplane(-1,80,100,190,190,256);
red2(plane) = 0;
green2(plane) = 0;
blue2(plane) = 140;

%dark blue
plane = getplane(-1,35,-1,101,-1,161);
red2(plane) = 65;
green2(plane) = 115;
blue2(plane) = 205;

%background
plane = getplane(200,256,200,256,200,256);
red2(plane) = 255;
green2(plane) = 255;
blue2(plane) = 255;




image2 = image;
image2(:,:,1) = red2;
image2(:,:,2) = green2;
image2(:,:,3) = blue2;

%some clipping
image2 = image2(250:1450,:,:);

imtool(image2)

imwrite(image2,'~/Documents/OH/spin-flip-writing/Loss_Surface_Chunks_recolored.PNG')