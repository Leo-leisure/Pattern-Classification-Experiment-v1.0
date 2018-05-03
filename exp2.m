%% display data 
s1=[ -3.9847,-3.5549, -1.2401, -0.9780, -0.7932, -2.8531, -2.7605, -3.7287,... 
-3.5414, -2.2692,-3.4549, -3.0752, -3.9934,  -0.9780, -1.5799, -1.4885,...
-0.7431 , -0.4221 , -1.1186, -2.3462, -1.0826, -3.4196, -1.3193, -0.8367,...
-0.6579, -2.9683]; 
size1=size(s1,2);
s2=[2.8792,0.7932, 1.1882, 3.0682, 4.2532, 0.3271,0.9846,2.7648,2.6588];
size2=size(s2,2);
hist(s1); 
h=findobj(gca,'Type','patch');
set(h,'Facecolor',[0 .5 .5]);
hold on; hist(s2); set(h,'Facecolor',[0 0 .5]);

%% risk function for 2-class 1-d example
miu1=mean(s1);
var1=var(s1);
miu2=mean(s2);
var2=var(s2);
like_f1=@(x)(exp(-(x-miu1)^2/2/var1)/sqrt(2*pi*var1));
like_f2=@(x)(exp(-(x-miu2)^2/2/var2)/sqrt(2*pi*var2));

post_p1=@(x)(0.9*like_f1(x)/(0.9*like_f1(x)+0.1*like_f2(x)));
post_p2=@(x)(0.1*like_f2(x)/(0.9*like_f1(x)+0.1*like_f2(x)));

risk1=@(x)(0.5*post_p2(x));
risk2=@(x)(0.5*post_p1(x));

%% plot risk funtion for 2-class 1-d example
x=-4:0.1:5;
l_x=size(x,2);
riskf1=zeros(1,l_x);
riskf2=zeros(1,l_x);

for i=1:l_x
    riskf1(i)=risk1(x(i));
    riskf2(i)=risk2(x(i));
end

plot(x,riskf1,'b'); hold on;
plot(x,riskf2,'b'); hold on;

%% classification test using samples from dataset
sample1_risk=zeros(2,size1);
for i=1:size1
    sample1_risk(1,i)=risk1(s1(i));
    sample1_risk(2,i)=risk2(s1(i));
end

sample2_risk=zeros(2,size2);
for i=1:size2
    sample2_risk(1,i)=risk1(s2(i));
    sample2_risk(2,i)=risk2(s2(i));
end

stem(s1,sample1_risk(1,:),'b'); hold on;
stem(s1,sample1_risk(2,:),'m'); hold on;
stem(s2,sample2_risk(1,:),'r'); hold on;
stem(s2,sample2_risk(2,:),'g');