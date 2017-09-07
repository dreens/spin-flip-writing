%%
% Edit Old Figures for Publication
%
% Want to do some shaded confidence regions, etc.
%
f = openfig('Two Body Loss with Slow turn-on compared with sim fitting.fig');
a = gca(f);
traces = get(a,'Children');
sn =    traces(3);
s5 =    traces(2);
s50 =   traces(4);
s100 =  traces(1);
none =  traces(5);
t5 =    traces(8);
t50 =   traces(7);
t100 =  traces(6);

%%

h0 = figure(60);
hold off
h4 = rplot(sn,'k-');
hold on
h1 = rplot(s5,'b--');
h2 = rplot(s50,'r-.');
h3 = rplot(s100,'g:');

hl = legend('show');
hl.FontSize = 13;

[nx, ny, nu] = skipPoints(none.XData,none.YData,none.UData);
h5 = errorbar(nx,ny,nu,'ko');
[t5x, t5y, t5u] = skipPoints(t5.XData,t5.YData,t5.UData);
[t5x, t5y, t5u] = skipPoints(t5x,t5y,t5u);
h6 = errorbar(t5x,t5y,t5u,'bs');
[t50x, t50y, t50u] = skipPoints(t50.XData,t50.YData,t50.UData);
[t50x, t50y, t50u] = skipPoints(t50x,t50y,t50u);
h7 = errorbar(t50x,t50y,t50u,'r*');
[t100x, t100y, t100u] = skipPoints(t100.XData,t100.YData,t100.UData);
[t100x, t100y, t100u] = skipPoints(t100x,t100y,t100u);
h8 = errorbar(t100x,t100y,t100u,'g.');

hs = {h5, h6, h7, h8};
for i=1:length(hs)
    hs{i}.CapSize = 2;
    hs{i}.MarkerSize = 8;
    hs{i}.LineWidth = 0.5;
end

h5.MarkerSize = 6;
h8.MarkerSize = 20;


ylim([30 100])
set(gca,'YScale','log')
set(gca,'FontSize',12)
xlim([0 180])
xlabel('Time (ms)','FontSize',13)
ylabel('Population','FontSize',13)


%% What if we average some points together
function varargout = skipPoints(a,b,c)
    m = abs(diff(a))<6;
    m = [m 0];
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

function hhh = rplot(hk,cc) 
    hhh = plot(hk.XData(1:100:end)',hk.YData(1:100:end)',cc);
end
