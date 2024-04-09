function [fsCoeffs] = FSAnalysis(x, k)

N = length(x);

fsCoeffs = zeros(1, 2* k + 1);

for n = -k : k

    sum = 0;
    for m = 1:N
        sum = sum + x(m) * exp(-1j * 2 * pi * n * (m-1) / N);
    end
    
    fsCoeffs(n + k + 1) = sum / N;
end
end


