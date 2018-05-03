function [ w, cost ,num_misclass , iter ] = batch_perceptron( X, max_iter , yita )
% 下一步优化更新过程，使得跳出局部小循环 threshold

m=size(X,1); % number of samples
n=size(X,2)-1; % dimension include offset
%w=random('norm',0,1,n,1); % initialzation
w=0.1*ones(n,1);
cost=zeros(max_iter+1,1);
num_misclass=cost;


iter=0;


while iter<max_iter % && ( iter==0 || cost(iter)-cost(iter+1)>-50 )
    sum_of_mis=0;
    w_change=0;
    for t=1:m
        if X(t,1:end-1)*w<0 && X(t,end)==1% there is positive misclassification
           w_change=w_change+yita*(X(t,1:end-1))';
           sum_of_mis=sum_of_mis+1;
        elseif X(t,1:end-1)*w>0 && X(t,end)==0% there is negative misclassification
            w_change=w_change-yita*(X(t,1:end-1))';     
            sum_of_mis=sum_of_mis+1;
        end
       
    end
    if sum_of_mis==0 %test if done
        break;
    end
    iter=iter+1;
    num_misclass(iter)=sum_of_mis;
     for i=1:m
         if  X(i,end)==0 && X(i,1:end-1)*w>0 
            cost(iter)=cost(iter)+X(i, 1:end-1)*w;
         elseif  X(i,end)==1 && X(i,1:end-1)*w<0 
            cost(iter)=cost(iter)-X(i, 1:end-1)*w;
         end
     end
    
    cost(iter)=cost(iter)/norm(w);
    
    w=w+w_change;
  
   
end

end

