%% generate data

num_class=50;
num_sample=1000*ones(num_class,1); %number of samples in every class 
n=3; %dimension
miu=random('unif',-4,4,n,num_class);
X=zeros(sum(num_sample),n+1);
sigma=1*eye(n); % assume all sigma are the same
for i=1:num_class
    X( sum(num_sample(1:i))-num_sample(i)+1:sum(num_sample(1:i)) , 1:end-1)=mvnrnd(miu(:,i),sigma,num_sample(i));
    X( sum(num_sample(1:i))-num_sample(i)+1:sum(num_sample(1:i)) , end)=i; %class label
end
% plot scatter diagram for 5-class 3-d  example
% scatter3(X(1:100,1),X(1:100,2),X(1:100,3),[],'r'); hold on;
% scatter3(X(100:200,1),X(100:200,2),X(100:200,3),[],'b'); hold on;
% scatter3(X(200:300,1),X(200:300,2),X(200:300,3),[],'k'); hold on;
% scatter3(X(300:400,1),X(300:400,2),X(300:400,3),[],'m'); hold on;
% scatter3(X(400:500,1),X(400:500,2),X(400:500,3),[],'g'); hold on;
% save('data_highsep','X');

%% train bayesian classifier

% % assume we know n(dimension); num_class ; num_sample ;
% load('data_lowsep','X');
miu_s=zeros(n, num_class);
cov_m=zeros(n*num_class , n); %covarience matrix
for i=1:num_class
    miu_s(:,i)=(mean( X( sum(num_sample(1:i))-num_sample(i)+1:sum(num_sample(1:i)) , 1:end-1) ) )';
    cov_m(1+n*(i-1):n*i,:)=cov(X( sum(num_sample(1:i))-num_sample(i)+1:sum(num_sample(1:i)) , 1:end-1));
end

% 利用参数重构高斯分布，计算概率

% 先计算先验概率矩阵
prior_p=zeros(num_class,1);
for i=1:num_class
    prior_p(i)=num_sample(i)/sum(num_sample);
end
% 再计算似然函数
p=zeros(sum(num_sample),num_class); %每一行代表每个样本，每一列代表其属于对应类的未归一化概率
for s=1:sum(num_sample) % for every sample
    
    for i=1:num_class
        x_s=(X(s , 1:end-1))'; %列向量，代表当前样本
        p(s,i)=exp((x_s-miu_s(:,i))'*inv(cov_m(n*(i-1)+1:i*n,:))*(x_s-miu_s(:,i))/(-2)); %未乘以系数，表示未归一化
    end
    
end

%再计算未归一化的后验概率p=先验概率*似然函数
for i=1:num_class
    p(:,i)=p(:,i)*prior_p(i);
end
[~,index]=max(p'); %行向量，值代表对应样本分类结果

%% test classifier
%计算样本均值距离代表可分度
min_d=zeros(num_class,1);

for i=1:num_class
    current_min=inf;
    for j=1:num_class 
        if  j~=i && current_min>norm(miu_s(:,j)-miu_s(:,i));
            current_min=norm(miu_s(:,j)-miu_s(:,i));
        end
    end
    min_d(i)=current_min;
end

%计算正确率
rate=zeros(num_class,1); %正确率
for i=1:num_class
    rate(i)=sum(index(sum(num_sample(1:i))-num_sample(i)+1:sum(num_sample(1:i)))==i)/num_sample(i);
end

plot(min_d,rate,'Marker','o','LineStyle','none','MarkerEdgeColor','g'); hold on;
