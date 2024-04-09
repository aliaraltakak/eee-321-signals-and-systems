function [y] = CrossCorrFUNC(x, h)
    Nx = length(x);
    Nh = length(h);
    
    % Length of the output sequence.
    Ny = Nx + Nh - 1;
    
    % Initialize the output sequence.
    y = zeros(1, Ny);
    
    % Perform cross-correlation by using the definition 
    % derived in defining the convolution function. 
    for n = 1:Ny
        for k = 1:Nx
            if (n - k + 1 > 0) && (n - k + 1 <= Nh)
                y(n) = y(n) + x(k) * h(n - k + 1);
            end
        end
    end
end
