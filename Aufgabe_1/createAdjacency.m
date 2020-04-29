%Berechnen Sie hier Ihre Adjazenzmatrix.

size = 4096;
sqrtSize = sqrt(size);
A = zeros(size, size);

% Graph definitiont insges. 4096 = 64 x 64 
% o - o - o - ...
% |   |   |   ...
% o - o - o - ...
% |   |   |   ...
% ...

for i = 1:length(A)
    A(i,i) = 1;
    % nach rechts begrenzen:
    if (mod(i, sqrtSize) ~= 0) 
        A(i, i + 1) = 1;
        A(i + 1, i) = 1;
    end
    
    % nach links begrenzt
    if (mod(i, sqrtSize) ~= 1) 
        A(i, i - 1) = 1;
        A(i - 1, i) = 1;
    end
    
    % nach oben begrenzt:
    if (i - sqrtSize >= 1)
        A(i, i - sqrtSize) = 1;
        A(i - sqrtSize, i) = 1;
    end     
    
    % nach unten begrenzen:
    if (i <= length(A) - sqrtSize)
        A(i, i + sqrtSize) = 1;
        A(i + sqrtSize, i) = 1;
    end     
end

save('Adjacency.mat','A')