cumPerf = zeros(length(HN),length(eta),length(epsilon),1,epochs);
for i=1:length(HN)
    for j=1:length(eta)
        for k=1:length(epsilon)
            for m=1:iterations             
                cumPerf(i,j,k,1,:) = cumPerf(i,j,k,1,:) + perf(i,j,k,m,:);
            end
            cumPerf(i,j,k,1,:) = cumPerf(i,j,k,1,:)/iterations;
            figure;
            plot(squeeze(cumPerf(i,j,k,1,:)));
        end
    end
end

