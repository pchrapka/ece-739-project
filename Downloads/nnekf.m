function [theta,P,e]=nnekf(theta,P,x,y,Q,R)
% NNEKF     A function using the EKF to training a MLP NN
% [theta,P,z]=nnekf(theta,P,x,y,Q,R) searches the optimal parameters, theta 
% of  a MLP NN based on a set of training data with input x and output y.
% Input:
%   theta: initial guess of MLP NN parameter. The network structure is
%   determined by the number of parameters, ns, the number of inputs (size of
%   x),nx and the number of output (size of y), ny. The euqation of the NN
%   is: y = W2 * tanh( W1 * x + b1) + b2, and theta = [W1(:);b1;W2(:);b2].
%   Therefore, ns = nx * nh + nh + nh * ny + ny, which gives the number of
%   hidden nodes is nh = (ns - ny) / (nx + ny + 1);
%   P: the covariance of the initial theta. Needs to be tuned to get good
%   training performance.
%   x and y: input and output data for training. For batch training, x and
%   y should be arranged in such a way that each observation corresponds to 
%   a column.
%   Q: the virtual process covariance for theta, normally set to very small
%   values.
%   R: the measurement covariance, dependen on the noise level of data, tunable. 
%
% Example: a NN model to approximate the sin function
% rand('state',0)
% % Initialize number of epochs
% N=20;
% % Initialize number of samples
% Ns=100;
% % Generate a random matrix [epochs,samples] from 0 to 1.2
% % This is the input to the NN, which is basically time
% x=1.2*randn(N,Ns);
% % Generate a sin signal based on x with some associated randomness
% % This would be the desired output of the NN
% y=sin(x)+0.1*randn(N,Ns);
% % Make a copy of y
% z=y;
% % FIXME Probably the number of hidden nodes
% nh=4;
% % Initialize ns which is the number of weights
% ns=nh*2+nh+1;
% % Generate a random weight vector ns long
% theta=randn(ns,1);
% % Initialize the covariance matrix of the weight vector
% P=diag([100*ones(1,nh*2) 10000*ones(1,nh+1)]);
% % Initialize the process covariance
% Q=0.001*eye(ns);
% % Initialize the measurement process covariance
% R=500*eye(Ns);
% % alpha=0.8;
% % I believe T1 selects the first half of epochs as training data
% T1=1:N/2;
% % Loop for each element in T1 and run the ekf training routine on the nn,
% % supplying an updated version of P and theta on each iteration, different
% % epochs from x and y, Q and R stay the same
% for k=T1
%     [theta,P,z(k,:)]=nnekf(theta,P,x(k,:),y(k,:),Q,R);
% end
% % Extract the weights from theta
% % W1 is 4x2
% W1=reshape(theta(1:nh*2),nh,[]);
% % W2 is 1x5
% W2=reshape(theta(nh*2+1:end),1,[]);
% % T2 selects the second half of the data for testing
% T2=N/2+1:N;
% % Evaluates the neural using the trained weights and the testing data
% for k=T2
%     z(k,:)=W2(:,1:nh)*tanh(W1(:,1)*x(k,:)+W1(:,2+zeros(1,Ns)))+W2(:,nh+ones(1,Ns));
% end
% subplot(211)
% plot(x(T1,:),y(T1,:),'ob',x(T1,:),z(T1,:),'.r')
% title('training results')
% subplot(212)
% plot(x(T2,:),y(T2,:),'ob',x(T2,:),z(T2,:),'.r')
% title('testing results')
%
% By Yi Cao at Cranfield University on 10 January 2008
%

f=@(u)u;                                % dumy process function to update parameters  
h=@(u)nn(u,x,size(y,1));                % NN model
[theta,P]=ekf(f,theta,P,h,y(:),Q,R);    % the EKF
e=h(theta);                             % returns trained model output

% The NN model. It can be modified for different NN structure.
function y=nn(theta,x,ny)
[nx,N]=size(x);
ns=numel(theta);                            
nh=(ns-ny)/(nx+ny+1);                   % calculate number of hidden nodes
W1=reshape(theta(1:nh*(nx+1)),nh,[]);   % extract weights from theta
W2=reshape(theta(nh*(nx+1)+1:end),ny,[]);
                                        % the NN model
y=W2(:,1:nh)*tanh(W1(:,1:nx)*x+W1(:,nx+ones(1,N)))+W2(:,nh+ones(1,N));
y=y(:);                                 % correct vector orientation for EKF

