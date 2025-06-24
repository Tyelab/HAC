
function [Z, T, C, I, figh, outperm, cluster_order]=HAC(zdata, distance_method, distance_metric,cutoff,title_string)
% [Z, T, C, I, figh] = HAC(zdata, distance_method, distance_metric,cutoff,title_string)
% This function performs hierarchical clustering on zdata using
% distance-method for measuring the distances between points in zdata and
% distance-metric for measuring distances between clusters
% It plots a dendrogram and defines the clusters using a cutoff value of
% cutoff*max(Z).
%
% Input
%   zdata - matrix of data, should be normalized appropriately (i.e. zscored)
%   distance_method - (string) metric used to compute distances between points in
%                  zdata; this string is passed to matlab's internal pdist
%                  function
%   distance_method - (string) metric used to compute distances between clusters
%                  this string is passed to matlab's internal function,
%                  linkage
%   cutoff - (float) this number is used to set the cutoff height on the
%                  dendrogram and find the number of clusters; it is a
%                  percentage of the max value in zdata
%   title_string - (string) optional title to include over the full color
%                   plot of zdata
%   
%
% Outputs
%   Z - output of linkage function (matrix Z that encodes a tree containing
%       hierarchical clusters of the rows of the input data matrix, zdata)
%   T - output of cluster function (i.e. T defines clusters from the
%       agglomerative hierarchical cluster tree given by Z)
%   C - value of cophenitc coefficient
%   I - value of inconsistant
%   figh - figure handle to the figure created in this function
%   outperm - the permuted indices from zdata that match cluster
%   cluster_order 
% 
% Example usage
% 
% > zdata = rand(100,10)
% > [Z, T, C, I, figh, outperm, cluster_order]=HAC(zdata, 'ward', 'euclidean',.3,'random data')
% > T(outperm) % this gives you the order of the sorted clusters
%
%





if nargin<3
    distance_method = 'ward';%'average'; 'ward'
    distance_metric = 'euclidean';%'correlation'; %'euclidean';
end
if nargin<4,    cutoff = .6; end
if nargin<5,    title_string = 'Average FR (zscores)';end
% the following line passes the zscored data to pdist using the metric
% 'distance_metric' to compute distances
Z = linkage(zdata, distance_method, distance_metric);
T = cluster(Z, 'cutoff', cutoff*max(Z(:,3)), 'criterion', 'distance');
C= cophenet(Z,pdist(zdata,distance_metric));
I = inconsistent(Z);
% T = cluster(Z, 'maxclust', 12);
[N,M] = size(zdata);

figh=figure;
ax1 =subplot(1,3,1);
[H,leafN,outperm] = dendrogram(Z, 0, 'Orientation','left','ColorThreshold', cutoff*max(Z(:,3))); 

%plot cluster numbers by the dendrogram
t_op = T(outperm);
cluster_order = t_op(diff(t_op)~=0);
cluster_order(size(cluster_order,1)+1,1) = t_op(end,1);
for i = 1:size(cluster_order,1)
    text1 = string(cluster_order(i));
    y = mean(find(t_op==cluster_order(i)));
    text(max(Z(:,3)),y,text1)
end

set(gca,'YTick',[])
xlabel('Linkage'); ylabel('Neuronal Unit')
set(gca,'TickDir','out')
set(gca,'FontName','Arial')
%set(gca,'FontSize',7)
if ischar(distance_metric)
title(sprintf('(%s, %s, cutoff = %1.2f), coph=%1.3f',distance_method,distance_metric,cutoff,C))
else
    
title(sprintf('(%s, %s, cutoff = %1.2f), coph=%1.3f',distance_method,'rms',cutoff,C))
end
%set(gca, 'XTicklabel', []);

% 
% % reverse the zdata using the clustered indices
% zdatarev=zdata(outperm(end:-1:1),:);
zdatarev=zdata(outperm,:);
ax2=subplot(1,3,[2 3]);
imagesc(zdatarev)
% colormap(jet)
colormap(redbluecmap)
% colormap(rbbglowcmap)
title(title_string)
%set(gca,'XTick',1:2:M)
binwid = floor(M/4);
xmax= binwid/2;
%set(gca, 'XTickLabel',-xmax:1:xmax)
%set(gca,'XTickLabelRotation',0)
set(gca,'YTick',1:1:N);
set(gca,'YDir','normal')
set(gca,'YTickLabel',outperm)
set(gca,'TickDir','out')
set(gca,'FontName','Arial')
xlabel('Time (msec)'); 
ylabel('Neuronal Unit')
%caxis([-5 5]);
colorbar
%boldify

% link axes so they zoom together
% for some reason, the y axis is backwards!
 linkaxes([ax1,ax2],'y');
% %  set(ax1, 'Position', [0.13 0.13 0.74 0.74]);
% %  set(ax2, 'Position', get(ax1, 'Position'));

% make it full screen size
%set(gcf, 'Position', [1 41 1920 963])


end