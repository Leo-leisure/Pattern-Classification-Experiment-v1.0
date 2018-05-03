%% compare dimension and size

max_iter=100;
yita=0.1;
load('data_skewed_19','X');
[ w, cost,~,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'b'); xlim([2 iter+1]); xlabel('iteration times'); ylabel('cost function value');title('dimension test with 1000 samples');hold on;

load('data_skewed_14','X');
[ w, cost,~ ,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'g'); xlim([2 iter+1]); hold on;
load('data_skewed_23','X');
[ w, cost,~ ,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'y'); xlim([2 iter+1]); hold on;

load('data_skewed_11','X');
[ w, cost,~ ,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'r'); xlim([1 100]); hold on;

load('data15002_50_4','X');
[ w, cost,~ ,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'m'); xlim([2 iter+1]); hold on;

load('data25002_50_4','X');
[ w, cost,~ ,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'c'); xlim([2 iter+1]); hold on;

load('data50002_50_4','X');
[ w, cost,~ ,iter ] = batch_perceptron( X, max_iter ,yita );
plot(cost,'b--'); xlim([2 200]); hold on;
