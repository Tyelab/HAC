
%% add the HAC functions to your path
addpath(genpath("../src/HAC"))

% load the demo data
load('punish_trials.mat')
load('reward_trials.mat')

% parameters for the baseline period before start of CS-onset (pre_ref) and
% the 4 second experimental window following CS-onset (post_ref)
pre_ref = 2000; % msec
post_ref= 4000; % msec
binWid = 100;   

%% normalize to baseline for each protocol using our special zscore function
cue_start_index = pre_ref/binWid;
E_zdata = special_Zscore(Epsth,1, cue_start_index);  % cue onset at 20 if bin wid = 100
A_zdata = special_Zscore(Apsth,1, cue_start_index);
% note: the special_zscore function allows you to use a specific baseline
% period as a reference.

% smooth the data using a gaussian window
smooth_window = [10 0];
E_zdata_smooth = smoothdata(E_zdata,2, 'gaussian', smooth_window);
A_zdata_smooth = smoothdata(A_zdata,2, 'gaussian', smooth_window);
zdata_smooth = [E_zdata_smooth A_zdata_smooth];

%% Hierarchical clustering algorithm parameters
linkage_metric = 'ward';
dist_metric = 'euclidean';
thisCutoff = .23; % this value may be tuned by the user
title_string = 'Results of Clustering';


% set the ticklabels and other information for plotting
xt.xticklabelrotation = 0;
xt.xtick = [1 20 40 60 80 100 120 121 140 160 180 200 220 240];
xt.xticklabel= [-2 -1 0 1 2 3 4 -2 -1 0 1 2 3 4];
xt.xlabel='Time (s)';

%% plot the original data

figure; 
imagesc(zdata_smooth)
colormap jet
title('Trial-averaged neural response to reward and punishment (unsorted)', 'FontSize',14)
set(gca,'XTick',xt.xtick)
set(gca,'XTickLabel',xt.xticklabel)
set(gca, 'XTickLabelRotation',xt.xticklabelrotation)
xlabel(xt.xlabel)
set(gca, 'YTick', 1:1:size(zdata_smooth,1)) 
ylabel('Neuronal Unit (#)')
set(gca, 'TickDir','out')
caxis([-10 10])
colorbar

% run hierarchical clustering and produce image with dendrogram and heatmap
[Z, T, ~,  f3]=HAC(zdata_smooth, linkage_metric,dist_metric, thisCutoff,title_string,xt);
caxis([-10 10])

% if you don't want to use the xtick and ytick information, you can call it
% this way:
%[Z, T, ~,  f3,outperm]=HAC(zdata_smooth, linkage_metric,dist_metric, thisCutoff, title_string);





%%  plot individual cluster averages

%% make supporting plots of the data in each cluster
% start fresh with dendrogram so you can get color info
figure
[H,~,outperm] = dendrogram(Z, 0, 'Orientation','left','ColorThreshold', thisCutoff*max(Z(:,3)));
clusterID = unique(T);

% get the color matrix correspoding to your dendrogram
for i=1:size(H,1)
    for j=H(i).YData(H(i).XData==0)
        cluster_colors(outperm(j),:)=H(i).Color;  %#ok<SAGROW>
    end
end

%for ii = [9 4 8 3 6 1 7] % this will plot traces in sorted order
for ii = 1:numel(clusterID)
    % if there is only one neuron represented in the cluster, skip plotting it
    if sum(T==clusterID(ii))==1, continue;end
    
    % get the color
    cluster_color=cluster_colors(T==ii,:);
    cluster_color = cluster_color(1,:);


    % if you want additional details on the cluster, you can uncomment the
    % following lines:
    %     % plot each trace within the cluster as a line on one figure
    %     f2=figure; clf;
    %     plot(zdata_smooth(T ==clusterID(ii) ,:)','Color',cluster_color(1,:))
    %     title(sprintf('Firing Rates from %d neurons in Cluster %d',sum(T ==clusterID(ii)),clusterID(ii)))
    %     xlabel(xl.xlabel)
    %     set(gca,'XTick',xl.xtick)
    %     set(gca,'XTickLabel',xl.xticklabel)
    %     set(gca,'TickDir','out')
    %     set(gca,'FontName','Arial')
    % %     set(gca,'TickLength',[0 0])
    %     axis tight
    

    % plot shaded trace and show average trace in darker line
    f3=figure; clf
    %figure(f3); hold on;
    y = zdata_smooth(T ==clusterID(ii),:);
    %                 y = zdata_smooth(T ==clusterID(ii),:) + dp;
    %                 dp = max(max(y));
    x = 1:size(y,2);
    plotshaded(x,y,cluster_color(1,:),f3,'std') % this shows the overall error around the average 
    title(sprintf('Firing Rates from %d neurons in Cluster %d',sum(T ==clusterID(ii)),clusterID(ii)))
    xlabel(xt.xlabel)
    set(gca,'XTick',xt.xtick)
    set(gca,'XTickLabel',xt.xticklabel)
    set(gca,'TickDir','out')
    set(gca,'FontName','Arial')
%     set(gca,'TickLength',[0 0])
    axis tight
    ylim([-10 20])
    
   
end











