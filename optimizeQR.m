close all;
clc;
clear all;
Q = linspace(0.01,100,100);
R = linspace(0.01,200,100);
HN = round(linspace(5,1000,100));

% NOTE This takes forever

avgPerf = zeros(length(Q),length(R),length(HN));
for i=1:length(Q)
    for j=1:length(R)
        for k=1:length(HN)
            avgPerf(i,j,k) = runEKFMLP(50,200, HN(k), Q(i),R(j));
            disp(['Average performance: ' num2str(avgPerf(i,j,k)*100) '%']);
        end
    end
end

dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['mlpekf_QRoptimization' dateString];
save(fileName);