function [ w, cost,num_misclass , iter ] = single_sample_perceptron( X, max_iter , yita )
% 

m=size(X,1); % number of samples
n=size(X,2)-1; % dimension include offset
%w=random('norm',0,1,n,1); % initialzation
w=0.1*ones(n,1);
cost=zeros(max_iter+1,1);
num_misclass=cost;

iter=0;
flag=0;
indx=1;
sum_of_rightclasssample=0;


while iter<max_iter % && ( iter==0 || cost(iter)-cost(iter+1)>-50 )
    t=indx;
    while 1
        if X(t,1:end-1)*w<=0 && X(t,end)==1
            flag=1; % there is positive misclassification
            indx=t;
            sum_of_rightclasssample=0;
            break;
        elseif X(t,1:end-1)*w>0 && X(t,end)==0
            flag=2; % there is negative misclassification
            indx=t;
            sum_of_rightclasssample=0;
            break;
        else
            sum_of_rightclasssample=sum_of_rightclasssample+1;
            t=mod(t,m)+1;
        end
        
        if sum_of_rightclasssample==m
            flag=0;
            break;
        end
    end
    
    if flag==0 %test if it is  done
        break;
    else
        iter=iter+1;
    end
    for i=1:m %if not done, record cost before update
        if  X(i,5)==0 && X(i,1:end-1)*w>0 
            cost(iter)=cost(iter)+X(i, 1:4)*w;
            num_misclass(iter)=num_misclass(iter)+1;
        elseif  X(i,5)==1 && X(i,1:end-1)*w<0 
            cost(iter)=cost(iter)-X(i, 1:4)*w;
            num_misclass(iter)=num_misclass(iter)+1;
        end
    end
    cost(iter)=cost(iter)/norm(w);
    % update w
    if flag==1
        w=w+yita*(X(indx,1:end-1))';
        flag=0;
    elseif flag==2
        w=w-yita*(X(indx,1:end-1))';
        flag=0;
    end
    
end

end

