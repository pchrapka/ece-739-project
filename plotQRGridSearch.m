clear all;
clc;
close all;

% Load the data file
load mlpekf_QRoptimization20110705_092525

[numNodes,numEta,numEp,numQ] = size(avgPerf);

% Plot all of the performance data as a function of the number of hidden
% nodes
figure;
for i=1:numEta
    for j=1:numEp
        for k=1:numQ
            plot(HN,avgPerf(:,i,j,k),'+');
            hold on;
        end
    end
end
sumAll = sum(sum(sum(avgPerf(:,:,:,:),4),3),2);
plot(HN,sumAll/(numQ*numEp*numEta),'-xr');
hold off;
title('Performance vs. Number of Nodes');
ylabel('Performance');
xlabel('Nodes');

% Plot the data for each number of nodes
for k=1:numNodes
    figure;
    subplot(2,2,4);
    title(['Performance Data: ' num2str(HN(k)) ' Nodes']);
    
    % Plot performance vs. eta
    subplot(2,2,1);
    for i=1:numEp
        for j=1:numQ
            plot(eta,squeeze(avgPerf(k,:,i,j)),'+');
            hold on;
        end
    end
    sumEta = sum(sum(sum(avgPerf(k,:,:,:),4),3),1);
    plot(eta,sumEta/(numQ*numEp),'-xr');
    hold off;
    title('Eta');
    ylabel('Performance');
    xlabel('Eta');

    % Plot performance vs. epsilon
    subplot(2,2,2);
    for i=1:numEta
        for j=1:numQ
            plot(epsilon,squeeze(avgPerf(k,i,:,j)),'+');
            hold on;
        end
    end
    sumEp = sum(sum(sum(avgPerf(k,:,:,:),4),2),1);
    plot(epsilon,squeeze(sumEp/(numQ*numEta)),'-xr');
    hold off;
    title('Epsilon');
    ylabel('Performance');
    xlabel('Epsilon');

    % Plot performance vs. q
    subplot(2,2,3);
    for i=1:numEta
        for j=1:numEp
            plot(q,squeeze(avgPerf(k,i,j,:)),'+');
            hold on;
        end
    end
    sumQ = sum(sum(sum(avgPerf(k,:,:,:),3),2),1);
    plot(q,squeeze(sumQ/(numEta*numEp)),'-xr');
    hold off;
    title('Q');
    ylabel('Performance');
    xlabel('Q');
end


% % Plot surfaces of data
% for i=1:numNodes
%     figure;
%     surf(squeeze(avgPerf(i,:,:,:))*100);
%     title([{'Performance'},{[num2str(HN(i)) ' Hidden Nodes']}]);
%     zlim([0 100]);
% end