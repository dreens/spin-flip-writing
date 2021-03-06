%% Mess with a figure
% I want to use MATLAB image processing to mess with a figure that I don't
% like the coloring on.

image = imread('Loss_Surface_Chunks_0-320_0.jpeg');

red   = image(:,:,1);
green = image(:,:,2);
blue  = image(:,:,3);

red2   = image(:,:,1);
green2 = image(:,:,2);
blue2  = image(:,:,3);


imtool(image)

% for comparison
%imagem = imread('~/Documents/OH/spin-flip-writing/Geometry/blue-red-yellow-v2_CAD.png');
%imtool(imagem)
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

red3 = red2;
green3 = green2;
blue3 = blue2;

getplane = @(r1,r2,g1,g2,b1,b2) ...
    r1  < red2   & red2   < r2 & ...
    g1  < green2 & green2 < g2 & ...
    b1  < blue2  & blue2  < b2 ;


%red
plane = getplane(119,121,-1,1,-1,1);
red3(plane) = 250;
green3(plane) = 250;
blue3(plane) = 0;

%orange
plane = getplane(179,181,-1,1,-1,1);
red3(plane) = 250;
green3(plane) = 150;
blue3(plane) = 0;

%yellow
plane = getplane(149,151,149,151,-1,1);
red3(plane) = 250;
green3(plane) = 50;
blue3(plane) = 0;

%green
plane = getplane(134,136,134,136,134,136);
red3(plane) = 200;
green3(plane) = 0;
blue3(plane) = 0;

%light blue
plane = getplane(-1,1,-1,1,139,141);
red3(plane) = 100;
green3(plane) = 0;
blue3(plane) = 0;

%dark blue
plane = getplane(64,66,114,116,204,206);
red3(plane) = 0;
green3(plane) = 0;
blue3(plane) = 0;

%% Now let's do some more spiffy image processing.
% Goal is to clean out the few corrupted pixels.
rgblabel = uint16(bitshift(red3,-3))*(2^10) + uint16(bitshift(green3,-3))*(2^5) + uint16(bitshift(blue3,-3));
thismax = ones(16,1);
if exist('flabel.mat','file')
    flabel = open('flabel.mat');
    flabel = flabel.flabel;
else
    flabel = ones(size(red3),'uint64');
    for i=1:30
        disp(i)
        if i<=15
            conncomp = bwconncomp(bitget(rgblabel,i));
        else
            conncomp = bwconncomp(~bitget(rgblabel,i-15));
        end
        thislabelmatrix = labelmatrix(conncomp);
        numlabels = max(flabel(:));
        thismax(i) = max(thislabelmatrix(:));
        flabel = flabel + uint64(thislabelmatrix)*(numlabels+1);
        if ~mod(i,3)
            u = unique(flabel(:));
            disp(length(u))
            for j=1:length(u)
                flabel(flabel==u(j))=j;
                if ~mod(j,100)
                    disp(j/length(u))
                end
            end
        end
    end
    flabel = uint32(flabel);
    save('flabel.mat','flabel')
end
%regions = regionprops(rgblabel,'PixelIdxList','Area','Centroid');
regions = regionprops(flabel,'PixelIdxList','Area');
%regions = regions([regions.Area]>0);

mask = false(size(red2));
for i=1:length(regions)
    listpix = regions(i).PixelIdxList;
    if length(listpix)<10
        mask(listpix) = true;
    end
end
%imtool(mask)
h = fspecial('disk',5);
red4 = imfilter(red3,h);
red3(mask) = red4(mask);

green4 = imfilter(green3,h);
green3(mask) = green4(mask);

blue4 = imfilter(blue3,h);
blue3(mask) = blue4(mask);

image2 = image;
image2(:,:,1) = red3;
image2(:,:,2) = green3;
image2(:,:,3) = blue3;

image3 = image;
image3(:,:,1) = red4;
image3(:,:,2) = green4;
image3(:,:,3) = blue4;
%imtool(image3)

%some clipping
image2 = image2(250:1450,:,:);

imtool(image2)

imwrite(image2,'Loss_Surface_Chunks_recolored_heat.PNG')