%% Script for analyzing results from scriptGridSearch
clear all;
close all;
clc;

%% Load the data file
load mlpekf_gridSearch20110725_202008.mat

%% Plot the average results for each number of hidden nodes
avgPerfHN = zeros(epochs,length(HN));
legendHN = cell(length(HN),1);
for i=1:length(HN)
    for j=1:length(eta)
        for k=1:length(epsilon)
            avgPerfHN(:,i) = avgPerfHN(:,i) + squeeze(perf(i,j,k,:));
        end
    end
    avgPerfHN(:,i) = avgPerfHN(:,i)/(length(eta)*length(epsilon));
    legendHN{i} = [num2str(HN(i)) ' HN'];
end

figure;
plot(avgPerfHN);
title('Average Performance as a Function of the Number of Hidden Nodes');
legend(legendHN,'Location','BestOutside');
xlabel('Epochs');
ylabel('Performance');
ylim([0.4 1]);

%% Plot the average results for each value of eta
avgPerfEta = zeros(epochs,length(eta));
legendEta = cell(length(eta),1);
for j=1:length(eta)
    for i=1:length(HN)
        for k=1:length(epsilon)
            avgPerfEta(:,j) = avgPerfEta(:,j) + squeeze(perf(i,j,k,:));
        end
    end
    avgPerfEta(:,j) = avgPerfEta(:,j)/(length(HN)*length(epsilon));
    legendEta{j} = ['\eta = ' num2str(eta(j))];
end

figure;
plot(avgPerfEta);
title('Average Performance as a Function of Eta');
legend(legendEta,'Location','BestOutside');
xlabel('Epochs');
ylabel('Performance');
ylim([0.4 1]);

%% Plot the average results for each value of epsilon
avgPerfEpsilon = zeros(epochs,length(eta));
legendEpsilon = cell(length(eta),1);
for k=1:length(epsilon)
    for i=1:length(HN)
        for j=1:length(eta)
            avgPerfEpsilon(:,k) = avgPerfEpsilon(:,k) + squeeze(perf(i,j,k,:));
        end
    end
    avgPerfEpsilon(:,k) = avgPerfEpsilon(:,k)/(length(HN)*length(eta));
    legendEpsilon{k} = ['\epsilon = ' num2str(epsilon(k))];
end

figure;
plot(avgPerfEpsilon);
title('Average Performance as a Function of Epsilon');
legend(legendEpsilon,'Location','BestOutside');
xlabel('Epochs');
ylabel('Performance');
ylim([0.4 1]);

%% Plot the average eta results for each number of hidden nodes
for i=1:length(HN)
    avgPerf = zeros(epochs,length(eta));
    legendStrings = cell(length(eta),1);
    
    for j=1:length(eta)
        for k=1:length(epsilon)
            avgPerf(:,j) = avgPerf(:,j) + squeeze(perf(i,j,k,:));
        end
        avgPerf(:,j) = avgPerf(:,j)/length(epsilon);
        legendStrings{j} = ['\eta = ' num2str(eta(j))];
    end
    
    % One figure per number of hidden nodes
    figure;
    plot(avgPerf);
    title(['Average Performance of \eta for ' num2str(HN(i)) ' HN']);
    legend(legendStrings,'Location','BestOutside');
    xlabel('Epochs');
    ylabel('Performance');
    ylim([0.4 1]);
end

%% Plot the average epsilon results for each number of hidden nodes
for i=1:length(HN)
    avgPerf = zeros(epochs,length(epsilon));
    legendStrings = cell(length(epsilon),1);
    
    for j=1:length(epsilon)
        for k=1:length(eta)
            avgPerf(:,j) = avgPerf(:,j) + squeeze(perf(i,k,j,:));
        end
        avgPerf(:,j) = avgPerf(:,j)/length(eta);
        legendStrings{j} = ['\epsilon = ' num2str(epsilon(j))];
    end
    
    % One figure per number of hidden nodes
    figure;
    plot(avgPerf);
    title(['Average Performance of \epsilon for ' num2str(HN(i)) ' HN']);
    legend(legendStrings,'Location','BestOutside');
    xlabel('Epochs');
    ylabel('Performance');
    ylim([0.4 1]);
end