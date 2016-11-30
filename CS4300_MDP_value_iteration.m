function [U,U_trace] = CS4300_MDP_value_iteration(S,A,P,R,gamma,...
eta,max_iter)
% CS4300_MDP_value_iteration - compute policy using value iteration
% On input:
%     S (vector): states (1 to n)
%     A (vector): actions (1 to k)
%     P (nxk struct array): transition model
%       (s,a).probs (a vector with n transition probabilities
%       (from s to s_prime, given action a)
%     R (vector): state rewards
%     gamma (float): discount factor
%     eta (float): termination threshold
%     max_iter (int): max number of iterations
% On output:
%     U (vector): state utilities
%     U_trace (iterxn): trace of utility values during iteration
% Call:
%     [U,Ut] = Cs4300_MDP_value_iteration(S,A,P,R,0.999999,0.1,100);
%
%     Set up a driver function, CS_4300_run_value_iteration (see
%     below), which sets up the Markov Decision Problem and calls this
%     function.
%
%     Chapter 17 Russell and Norvig (Table p. 651)
%     [S,A,R,P,U,Ut] = CS4300_run_value_iteration(0.999999,1000)
%
%     U� =  0.7053 0.6553 0.6114 0.3879 0.7616 0 0.6600 -1.0000
%       0.8116 0.8678 0.9178 1.0000
%
%    Layout:               1
%                           �
%      9 10 11 12           |
%      5  6  7  8       2 <- ->  4
%      1  2  3  4           |
%                           V
%                           3
% Author:
%     Rajul Ramchandani & Conan Zhang
%     UU
%     Fall 2016
%

count = length(S);


if(count == 16)
    U = zeros(1,16);
    U_prime =zeros(1,16);
else
    U = zeros(1,12);
    U_prime = zeros(1,12);
end

U_trace(1,:) = U;
  

done = 0;
iter = 0;

while(done == 0 && iter < max_iter)
    iter = iter + 1;
    U = U_prime;
    delta = 0;
    
    s_length = length(S);  
    for s1 = 1:s_length
       best_action = 0;
       best_val = -Inf;

       a_length = length(A);
       for a = 1:a_length
          a_sum = 0;
          for s2 = 1:s_length     
           
             a_sum = a_sum + P(s1,a).probs(s2)* U(s2);
    
             if(a_sum > best_val)
                best_val = a_sum;
                best_action = a; 
             end
          end
       end
 
       U_prime(s1) = R(s1) + (gamma * best_val);

       if(abs(U_prime(s1) - U(s1)) > delta)
           delta = abs(U_prime(s1) - U(s1));
       end
    end
    
    U_trace(end+1,:) = U_prime;

    if(delta < (eta * (1 - gamma)/gamma))
        done = 1;
    end
end
    