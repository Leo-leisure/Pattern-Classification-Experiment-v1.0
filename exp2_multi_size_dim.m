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

% ���ò����ع���˹�ֲ����������

% �ȼ���������ʾ���
prior_p=zeros(num_class,1);
for i=1:num_class
    prior_p(i)=num_sample(i)/sum(num_sample);
end
% �ټ�����Ȼ����
p=zeros(sum(num_sample),num_class); %ÿһ�д���ÿ��������ÿһ�д��������ڶ�Ӧ���δ��һ������
for s=1:sum(num_sample) % for every sample
    
    for i=1:num_class
        x_s=(X(s , 1:end-1))'; %������������ǰ����
        p(s,i)=exp((x_s-miu_s(:,i))'*inv(cov_m(n*(i-1)+1:i*n,:))*(x_s-miu_s(:,i))/(-2)); %δ����ϵ������ʾδ��һ��
    end
    
end

%�ټ���δ��һ���ĺ������p=�������*��Ȼ����
for i=1:num_class
    p(:,i)=p(:,i)*prior_p(i);
end
[~,index]=max(p'); %��������ֵ�����Ӧ����������

%% test classifier
%����������ֵ�������ɷֶ�
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

%������ȷ��
rate=zeros(num_class,1); %��ȷ��
for i=1:num_class
    rate(i)=sum(index(sum(num_sample(1:i))-num_sample(i)+1:sum(num_sample(1:i)))==i)/num_sample(i);
end

plot(min_d,rate,'Marker','o','LineStyle','none','MarkerEdgeColor','g'); hold on;
