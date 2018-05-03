%% generate data with diffenent size and dimension

clc; clear; close all;
m1=2500;% number of every set
m2=2500;
m=m1+m2;
n=50; %dimension
mu1=zeros(n,1);
sigma1=2*eye(n);
X1=mvnrnd(mu1,sigma1,m1);
% scatter3(X1(:,1), X1(:,2), X1(:,3),[],'b'); hold on; % plot to better observe the data intuitively

mu2=4*ones(n,1);
sigma2=2*eye(n);
X2=mvnrnd(mu2,sigma2,m2);
% scatter3(X2(:,1), X2(:,2), X2(:,3),[],'r'); hold on;

%% LABEL and reshape the data set
X=zeros(m,1+n+1);
X(:,1)=ones(m,1); %extend the vector to n+1 d
X(1:m1,2:n+1)=X1; X(1:m1,n+2)=ones(m1,1); %x1 for positive label
X(m1+1:m,2:n+1)=X2; %x2 for negative label
% rearrange the data randomly
rand_index = randperm( m );   
X = X( rand_index,: );   

save('data_skewed_11','X'); %500*2 10dimension 5miu