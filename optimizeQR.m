close all;
clc;
clear all;
samples = 10;
Q = linspace(0.001,100,samples);
R = linspace(0.001,200,samples);
HN = round(linspace(5,1000,samples));

% NOTE This takes forever

avgPerf = zeros(length(HN),length(Q),length(R));
for i=1:length(HN)
    for j=1:length(Q)
        for k=1:length(R)
            disp(['HN: ' num2str(HN(i)) ' Q: ' num2str(Q(j)) ' R: ' num2str(R(k))]);
            avgPerf(i,j,k) = runEKFMLP(50,200, HN(i), Q(j),R(k));
            disp(['Average performance: ' num2str(avgPerf(i,j,k)*100) '%']);
        end
    end
end

dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['mlpekf_QRoptimization' dateString];
save(fileName);