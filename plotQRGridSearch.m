clear all;
clc;
close all;

% Load the data file
load mlpekf_QRoptimization20110630_142948

[nodes,numQ,numR] = size(avgPerf);

for i=1:nodes
    figure;
    surf(squeeze(avgPerf(i,:,:))*100);
    title([{'Performance'},{[num2str(HN(i)) ' Hidden Nodes']}]);
    zlim([0 100]);
end