function [p] = plotshaded(x,y,fstr,figh,TYPE)
% x: x coordinates
% y: either just one y vector, or 2xN or 3xN matrix of y-data
% fstr: format ('r' or 'b--' etc)
%
% example
% x=[-10:.1:10];plotshaded(x,[sin(x.*1.1)+1;sin(x*.9)-1],'r');
%
% this function was modified from the original taken from this website:
% http://jvoigts.scripts.mit.edu/blog/nice-shaded-plots/
% by Jakob Voigts on Jan 28, 2013.

if nargin<5, TYPE = 'std';end
if nargin<4, figh=figure;end
if nargin<3, fstr='c';end

figure(figh)
% if size(y,1)>size(y,2)
%     y=y';
% end

if size(y,1)==1 % just plot one line
    plot(x,y,'color',fstr);
end

if 0 % not using this option
    if size(y,1)==2 %plot shaded area
        px=[x,fliplr(x)]; % make closed patch
        py=[y(1,:), fliplr(y(2,:))];
        p=patch(px,py,1,'FaceColor',fstr,'EdgeColor','none', 'FaceAlpha',.2);
        hold on;
        plot(x,y,'color',fstr)
    end
end

if size(y,1)>=2 % also draw mean
    
    switch lower(TYPE)
        case 'minmax'
            px=[x,fliplr(x)];
            py = [min(y), fliplr(max(y))];
        case 'std'
            px=[x,fliplr(x)];
            py = [mean(y,1)+std(y,1), fliplr(mean(y,1)-std(y,1))];
        case 'sem'
            px=[x,fliplr(x)];
            py = [mean(y,1)+std(y,1)/sqrt(size(y,1)), fliplr(mean(y,1)-std(y,1)/sqrt(size(y,1)))];
            
        otherwise
            error('unknown type -- should be minmax, std, or sem')
    end
    p = patch(px,py,1,'FaceColor',fstr,'EdgeColor','none', 'FaceAlpha',.2);
    hold on;
    plot(x,mean(y,1),'color',fstr,'LineWidth',2);
    %     plot(x,mean(y,1),'color',fstr,'LineWidth',2,'Marker','o');
end

