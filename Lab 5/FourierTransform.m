function [frequency_array] = FourierTransform(x,t,Ts)

    N = length(x);
    Fs = 1 / Ts;
    F = linspace(-Fs/2, Fs/2, N);
    frequency_array = zeros(1,N);

    for k = 1:N
        omega = 2 * pi * F(k);
        sumOf = 0;
        
        for n = 1:N
            sumOf = sumOf + x(n) * exp(-1j * omega * t(n));
        end

        frequency_array(k) = sumOf * Ts;
    end
end



