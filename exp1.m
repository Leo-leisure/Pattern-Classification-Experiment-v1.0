%% train perceptron
 %close all; clear; clc;
load('data','X');
max_iter=100;
yita=0.1;
% [ w, cost,num_misclass,iter ] = single_sample_perceptron( X, max_iter ,yita );
[ w, cost,num_misclass ,iter ] = batch_perceptron( X, max_iter ,yita );
%% draw scatter
scatter3(X( X(:,5)==0,2), X( X(:,5)==0,3), X( X(:,5)==0,4),[],'b'); hold on;
scatter3(X( X(:,5)==1,2), X( X(:,5)==1,3), X( X(:,5)==1,4),[],'r'); hold on;

%% draw the dividing surface
 x=floor(min(X(:,2))):1: ceil(max(X(:,2)));
 y=floor(min(X(:,3))):1: ceil(max(X(:,3)));
 [x,y]=meshgrid(x,y);
 z=-(w(2)*x+w(3)*y+w(1))./w(4);
 surf(x,y,z); zlim( [ floor(min(X(:,3))) , ceil( max(X(:,3)) )] );
 
 plot(cost,'b'); xlim([2 iter+1]); xlabel('iteration times'); ylabel('cost function value');hold on; title('separability=0.625');


