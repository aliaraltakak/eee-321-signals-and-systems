function [y] = ConvFUNC(x, h)
    Nx = length(x);
    Nh = length(h);
    
    % Length of the output sequence. 
    Ny = Nx + Nh - 1;
    
    % Initialize the output sequence. 
    y = zeros(1, Ny);
    
    % Perform convolution. 
    for n = 1:Ny
        % Calculate valid range. 
        rangeMin = max(1, n - Nh + 1);
        rangeMax = min(n, Nx);
        
        % Using dot product, calculate the convolution. 
        y(n) = sum(x(rangeMin:rangeMax) .* h(1:rangeMax - rangeMin + 1));
    end
end

