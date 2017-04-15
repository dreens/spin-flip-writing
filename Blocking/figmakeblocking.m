%% Majorana Loss Figure
%
% I want to make a figure that describes what I call the "blocking" effect
% for orthogonal E and B fields.
%


%% Unperturbed Zeeman Energies for OH
%
%
B = -1e-3:5e-5:0.025;
E = 1.5e5;
Hs = zeros(8,8,length(B));
HsE = Hs;
HsEO = Hs;
for i = 1:length(B)
    Hs(:,:,i) = OH_Ham_Lab_Fixed(B(i),0,0,0,0,0);
    HsE(:,:,i) = OH_Ham_Lab_Fixed(B(i),0,0,E,0,0);
    HsEO(:,:,i) = OH_Ham_Lab_Fixed(B(i),0,0,0,E,0);
end
[vs,ds] = eigenshuffle(Hs);
[vse,dse] = eigenshuffle(HsE);
[vseo,dseo] = eigenshuffle(HsEO);
ds = ds(:,21:end);
dse = dse(:,21:end);
dseo = dseo(:,21:end);
B = B(21:end);
%% Panel a
h = figure;
set(h,'Position',[50,100,700,400])
subplot(2,3,1)
hold on
blue = [0 0 170]/255;
gray = [135 135 135]/255;
red = [180 0 0]/255;

h = 6.6267e-34;
LD = 1.667358e9*h;
kb = 1.3806e-23;

dss = ds-LD/2;
dss = 1e3*dss/kb;

Bp = B*1e4;
plot(Bp,dss(1,:),'Color',red,'LineWidth',2);
plot(Bp,dss(2,:),'Color',gray,'LineWidth',2);
plot(Bp,dss(3,:),'Color',gray,'LineWidth',2);
plot(Bp,dss(4,:),'Color',blue,'LineWidth',2);
plot(Bp,dss(5,:),'Color',gray,'LineStyle','--','LineWidth',2);
plot(Bp,dss(6,:),'Color',gray,'LineStyle','--','LineWidth',2);

ylabel('Energy (mK)')
title('E=0','FontSize',14)
ylim([-10 30]);
xlim([0 200])
grid on
%% Panel b
subplot(2,3,2)
hold on

h = 6.6267e-34;
LD = 1.667358e9*h;
kb = 1.3806e-23;

dss = dse-LD/2;
dss = 1e3*dss/kb;

Bp = B*1e4;
plot(Bp,dss(3,:),'Color',gray,'LineWidth',2);
plot(Bp,dss(4,:),'Color',gray,'LineWidth',2);
plot(Bp,dss(5,:),'Color',gray,'LineStyle','--','LineWidth',2);
plot(Bp,dss(6,:),'Color',gray,'LineStyle','--','LineWidth',2);
plot(Bp,dss(1,:),'Color',blue,'LineWidth',2);
plot(Bp,dss(2,:),'Color',red,'LineWidth',2);

title('E || B','FontSize',14)
xlabel('Magnetic Field (G)')
ylim([-10 30]);
xlim([0 200])
grid on

%% Panel c
subplot(2,3,3)
hold on
ds2 = dseo-LD/2;
ds2 = 1e3*real(ds2)/kb;

plot(Bp,ds2(3,:),'Color',gray,'LineWidth',2);
plot(Bp,ds2(4,:),'Color',gray,'LineWidth',2);

plot(Bp,ds2(1,:),'Color',blue,'LineWidth',2);
plot(Bp,ds2(2,:),'Color',red,'LineWidth',2);

title('E\perp B','FontSize',14)
ylim([-10 30]);
xlim([0 200])
grid on

%% Panel d
subplot(2,3,4)
hold on

x = -100:.5:100; %micron
z = -50:.5:50;
[xx, zz] = meshgrid(x,z);
Bp = 2; %G/micron (T/cm)
Bp = Bp * 1e-4; % T/micron
EE = zeros(size(xx));
for i=1:length(xx(:))
    hh = OH_Ham_Lab_Fixed(-Bp*xx(i)/2,0,Bp*zz(i),0,0,0);
    gaps = diff(sort(eig(hh)));
    EE(i) = 3*gaps(end)/kb * 1e3;
end
levels = [2:2:10];
contour(xx,zz,EE,[0.5 0.5],'Color',red);
contour(xx,zz,EE,levels,'k');
ylabel('Strong Axis (\mum)')
xlabel('Weak Axis (\mum)')
title('E=0','FontSize',14)

grid on
xr = xx(1:50:end,1:50:end);
zr = zz(1:50:end,1:50:end);
quiver(xr,zr,xr,-2*zr,'Color',blue)
xlim([-100 100])
ylim([-50 50])

%% Panel e
subplot(2,3,5)
hold on

EE = zeros(size(xx));
for i=1:length(xx(:))
    hh = OH_Ham_Lab_Fixed(-Bp*xx(i)/2,0,Bp*zz(i),0,0,E);
    gaps = diff(sort(eig(hh)));
    EE(i) = gaps(end)/kb *1e3;
end
contour(xx,zz,EE,[0.5 0.5],'Color',red);
contour(xx,zz,EE,levels,'k');
grid on
xlabel('Weak Axis (\mum)')
title('E = 150 V/cm','FontSize',14)
uB = 9.72401e-24 * Bp * 1.4;
dE = 1.7 * 3.34e-30 * E;
xr = xx(1:66:end,1:50:end);
zr = zz(1:66:end,1:50:end);
mag = sqrt((uB*xr).^2 + (-2*uB*zr-sign(zr)*dE).^2);
s = (mag - dE)./mag;
s(isinf(s))=0;
quiver(xr,zr,s.*uB.*xr,-2*uB*zr.*s-sign(zr)*dE.*s,0.75,'Color',blue)
xlim([-100 100])
ylim([-50 50])

%% Panel f
subplot(2,3,6)
hold on
blue = [0 0 170]/255;
gray = [135 135 135]/255;
red = [180 0 0]/255;

h = 6.6267e-34;
LD = 1.667358e9*h;
kb = 1.3806e-23;

dss = ds-LD/2;
dss = 1e3*dss/kb;

Bp = B*1e4;
plot(Bp,dss(1,:),'Color',red,'LineWidth',2);
plot(Bp,dss(2,:),'Color',gray,'LineWidth',2);
plot(Bp,dss(3,:),'Color',gray,'LineWidth',2);
plot(Bp,dss(4,:),'Color',blue,'LineWidth',2);
plot(Bp,dss(5,:),'Color',gray,'LineStyle','-','LineWidth',2);
plot(Bp,dss(6,:),'Color',gray,'LineStyle','-','LineWidth',2);
plot(Bp,dss(7,:),'Color',gray,'LineStyle','-','LineWidth',2);
plot(Bp,dss(8,:),'Color',gray,'LineStyle','-','LineWidth',2);

ylabel('Energy (mK)')
xlabel('Magnetic Field (G)')
title('E=0','FontSize',14)
ylim([-100 30]);
xlim([0 200])
grid on


