% Define the required parameters for sampling. 
Ts = 0.01;  
N_range = 100:300:10000; 
a_values = [0, 0.05, 0.10, 0.25, 0.5];  
n = -5000:5000;  

% Using a loop for varying values of coefficient a. 
for i = 1:length(a_values)
    a = a_values(i);
    if a == 0
        % Discrete-time integrator (a = 0).
        h = zeros(1, length(n));
        mid_point = length(n) / 2 + 1; 

        mid_point = round(mid_point);
        if mid_point < 1
            mid_point = 1;
        elseif mid_point > length(n)
            mid_point = length(n);
        end

        % Accumulate starting from the midpoint. 
        h(mid_point) = Ts;  
        for k = (mid_point+1):length(n)
            h(k) = h(k-1) + Ts;
        end
    else
        % Exponential decaying system for a > 0.
        h = exp(-a * abs(n) * Ts);
    end
    
    
    sum_array = sumElements(h, N_range);
    
    subplot(length(a_values), 1, i);
    plot(N_range, sum_array);
    title(['Summation results for a = ', num2str(a)]);
    xlabel('N');
    ylabel('Summation value.');
end
