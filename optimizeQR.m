close all;
clc;
clear all;
samples = 10;
eta = linspace(0.01,1,samples);
epsilon = linspace(0.001,0.01,samples);
q = linspace(1e-6,0.1,samples);
HN = round(linspace(5,1000,samples));

% NOTE This takes forever

avgPerf = zeros(length(HN),length(eta),length(epsilon),length(q));
for i=1:length(HN)
    for j=1:length(eta)
        for k=1:length(epsilon)
            for l=1:length(q)
                disp(['HN: ' num2str(HN(i)) ' eta: ' num2str(eta(j)) ' epsilon: ' num2str(epsilon(k)) ' q: ' num2str(q(l))]);
                avgPerf(i,j,k,l) = runEKFMLP(50,200, HN(i), eta(j), epsilon(k), q(l), false);
                disp(['Average performance: ' num2str(avgPerf(i,j,k,l)*100) '%']);
            end
        end
    end
end

dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['mlpekf_QRoptimization' dateString];
save(fileName);