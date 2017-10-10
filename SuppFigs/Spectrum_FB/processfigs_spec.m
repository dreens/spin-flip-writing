%%
% Edit Old Figures for Publication
%
% Want to do some shaded confidence regions, etc.
%
open('Forward vs Backward 1663.7MHz Sawtooth Evap after Normalization .fig')
pause(2)
fff = gcf;
a = gca(fff);
traces = get(a,'Children');
un = traces(1);
fw = traces(3);
bw = traces(2);

% Now we need for each trace:
% x, y, error, 
% area, scatter, background, 
% area error, scatter error, background error.
% a single point pre-norm to back out adjustment
unx = un.XData;
unyr = un.YData;
uner = un.UData;
unyr = unyr(unx>=0);
uner = uner(unx>=0);
unx = unx(unx>=0);

fwx = fw.XData;
fwyr = fw.YData;
fwer = fw.UData;
fwyr = fwyr(fwx>=0);
fwer = fwer(fwx>=0);
fwx = fwx(fwx>=0);

bwx = bw.XData;
bwyr = bw.YData;
bwer = bw.UData;
bwyr = bwyr(bwx>=0);
bwer = bwer(bwx>=0);
bwx = bwx(bwx>=0);

%standard error
sterr = @(x) std(x)./sqrt(max(size(x)));

%unevap dataset:
undata = importdata('nonevap.dat');
scatter = undata(undata(:,1)==-2,2);
backgnd = undata(undata(:,1)==-1,2);
onepoint = undata(undata(:,1)==1667.359,2);
uno = mean(onepoint);
unb = mean(backgnd);
post = unyr(unx==0); pre = unb - uno;
uny = unyr*pre/post;
une = uner*pre/post;
una = abs(trapz(unx,uny));
uns = mean(scatter);
unse = sterr(scatter);
unbe = sterr(backgnd);

%fw dataset:
fwdata = importdata('forward1663p7.dat');
backgnd = fwdata(fwdata(:,1)==-1,2);
onepoint = fwdata(fwdata(:,1)==1667.359,2);
fwo = mean(onepoint);
fwb = mean(backgnd);
post = fwyr(fwx==0); pre = fwb - fwo;
fwy = fwyr*pre/post;
fwe = fwer*pre/post;
fwa = abs(trapz(fwx,fwy));
scatter = importdata('scatter.dat');
scatter = scatter(:,2);
fws = mean(scatter);
fwse = sterr(scatter);
fwbe = sterr(backgnd);

%bw dataset:
bwdata = importdata('backward1663p7.dat');
backgnd = bwdata(bwdata(:,1)==-1,2);
onepoint = bwdata(bwdata(:,1)==1667.359,2);
bwo = mean(onepoint);
bwb = mean(backgnd);
post = bwyr(bwx==0); pre = bwb - bwo;
bwy = bwyr*pre/post;
bwe = bwer*pre/post;
bwa = abs(trapz(bwx,bwy));
scatter = importdata('scatter.dat');
scatter = scatter(:,2);
bws = mean(scatter);
bwse = sterr(scatter);
bwbe = sterr(backgnd);

% Now we get some uncertainties and plot the relevant window:
ar = @(x,y) abs(trapz(x,y));
gs = @(x) [0 cumsum(diff(x).^2)];
unae = sqrt(ar(gs(unx),une.^2));
fwae = sqrt(ar(gs(fwx),fwe.^2));
bwae = sqrt(ar(gs(bwx),bwe.^2));
unbse = sqrt(unbe.^2+unse.^2);
fwbse = sqrt(fwbe.^2+fwse.^2);
bwbse = sqrt(bwbe.^2+bwse.^2);

unyn = uny/ar(unx,uny)*(unb-uns);
unen = sqrt(...
    (une/ar(unx,uny)*(unb-uns)).^2 + ...
    (uny/ar(unx,uny)*unbse).^2 + ...
    (uny*(unb-uns)*unae/ar(unx,uny)/ar(unx,uny)).^2 ...
    );
fwyn = fwy/ar(fwx,fwy)*(fwb-fws);
fwen = sqrt(...
    (fwe/ar(fwx,fwy)*(fwb-fws)).^2 + ...
    (fwy/ar(fwx,fwy)*fwbse).^2 + ...
    (fwy*(fwb-fws)*fwae/ar(fwx,fwy)/ar(fwx,fwy)).^2 ...
    );
bwyn = bwy/ar(bwx,bwy)*(bwb-bws);
bwen = sqrt(...
    (bwe/ar(bwx,bwy)*(bwb-bws)).^2 + ...
    (bwy/ar(bwx,bwy)*bwbse).^2 + ...
    (bwy*(bwb-bws)*bwae/ar(bwx,bwy)/ar(bwx,bwy)).^2 ...
    );



% figure(3)
% hold off
% h1 = errorbar(unx,100*unyn,100*unen,'ko--','CapSize',0);
% hold on
% h2 = errorbar(fwx+25,100*fwyn,100*fwen,'rx--','CapSize',0);
% h3 = errorbar(bwx+50,100*bwyn,100*bwen,'bs--','CapSize',0);
% %errorbar(fwx+mean(diff(fwx))/4,fwyn,fwe/ar(fwx,fwy)*(fwb-fws))
% grid on
% %hh = fill([fwx fliplr(fwx)],[fwyup fliplr(fwydown)],'r');
% %set(hh,'facealpha',0.5)
%%
figure(4)
hold off
[ux,uy,ue] = skipPoints(unx,unyn,unen);
h1 = errorbar(ux,100*uy,100*ue,'ko','CapSize',0);
hold on
[fx,fy,fe] = skipPoints(fwx,fwyn,fwen);
h2 = errorbar(fx+20,100*fy,100*fe,'rx','CapSize',0);
[bx,by,be] = skipPoints(bwx,bwyn,bwen);
h3 = errorbar(bx-20,100*by,100*be,'bs','CapSize',0);
hs = {h1, h2, h3};
for i=1:length(hs)
    hs{i}.CapSize = 2;
    hs{i}.MarkerSize = 8;
    hs{i}.LineWidth = 0.5;
end


% Let's fit all the traces too.
ft = fittype( 'a*x*x*exp(-1.4*9.27401e-28*x/1.38e-23/t)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [1e-5 .05];

opts.Weights = 1./ue.^2;
[ufit, gof] = fit( ux', 100*uy', ft, opts );
plot(linspace(0,max(ux)*1.03,200),ufit(linspace(0,max(ux),200)),'k-');

opts.Weights = 1./fe.^2;
[ffit, gof] = fit( fx', 100*fy', ft, opts );
plot(linspace(0,max(fx)*1.1,200),ffit(linspace(0,max(fx),200)),'r-');

opts.Weights = 1./be.^2;
[bfit, gof] = fit( bx', 100*by', ft, opts );
plot(linspace(0,max(bx)*1.1,200),bfit(linspace(0,max(bx),200)),'b-');

xlabel('Magnetic Field (G)')
ylabel('Population')

%% What if we average some points together
function varargout = skipPoints(a,b,c)
    a = fliplr(a);
    b = fliplr(b);
    c = fliplr(c);
    m = abs(diff(a))<=110;
    m = [m 0] | [0 m];
    m2 = m;
    for i=2:length(m2)
        if m2(i-1)
            m2(i)=0;
        end
    end
    a2 = [a(1)];
    b2 = [b(1)];
    c2 = [c(1)];
    for i=2:length(a)
        if m2(i-1)
            a2(end) = (a2(end) + a(i) )/2;
            b2(end) = (b2(end) + b(i) )/2;
            c2(end) = sqrt(c2(end)^2 + c(i)^2)/2;
        else
            a2(end+1) = a(i);
            b2(end+1) = b(i);
            c2(end+1) = c(i);
        end
    end
    varargout = {a2,b2,c2};
end

