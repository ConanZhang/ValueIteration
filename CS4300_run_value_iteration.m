function policy = CS4300_run_value_iteration()
% CS4300_MDP_value_iteration - compute policy using value iteration
% On input:
%     gamma (float): discount factor
%     max_iter (int): max number of iterations
% On output:
%     U (vector): state utilities
%     U_trace (iterxn): trace of utility values during iteration
% Call:
%     [U,Ut] = Cs4300_run_value_iteration(S,A,P,R,0.999999,0.1,100);
% Author:
%     Rajul Ramchandani & Conan Zhang
%     UU
%     Fall 2016
%


%4x4
S = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
A = [1,2,3,4];
P = CS4300_Probs44();
R = ones(1,16)*-1;
R(8) = -1000;
R(12) = -1000;
R(11) = -1000;
R(7) = -1000;
R(16) = 1000;

% 3x4
% S = [1,2,3,4,5,6,7,8,9,10,11,12];
% A = [1,2,3,4];
% P = CS4300_Probs34();
% R = ones(1,12)*-0.04;
% R(12) = 1;
% R(8) = -1;

gamma = 0.999999;
eta = 0.1;
max_iter = 1000;

[U,Ut] = CS4300_MDP_value_iteration(S,A,P,R, gamma, eta, max_iter);
time = [];
for t= 0:516
    time(end+1) = t;
end

plot(time, Ut(:,1), 'DisplayName', 'Actual vel in x');
text(length(Ut(:,1)),Ut(end,1),'(1,1)');
title('Utility Estimations with Gamma of 0.999999')
xlabel('Number of Iterations')
ylabel('Utility Estimates')
hold on;

plot(time, Ut(:,3), 'DisplayName', 'Actual vel in x');
text(length(Ut(:,3)),Ut(end,3),'(1,3)');
hold on;

plot(time, Ut(:,4), 'DisplayName', 'Actual vel in x');
text(length(Ut(:,4)),Ut(end,4),'(1,4)');
hold on;

plot(time, Ut(:,15), 'DisplayName', 'Actual vel in x');
text(length(Ut(:,15)),Ut(end,15),'(3,4)');