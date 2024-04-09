function [sum_array] = sumElements(h, N_range)
    
    % Initialize the array for storing the sums. 
    sum_array = zeros(length(N_range), 1); 
    h_len = length(h);
    mid = ceil(h_len / 2);

    for i = 1:length(N_range)

        N = N_range(i);
        
        start_idx = max(1, mid - N);  
        end_idx = min(h_len, mid + N);  
        sum_array(i) = sum(abs(h(start_idx:end_idx)));

    end
end

