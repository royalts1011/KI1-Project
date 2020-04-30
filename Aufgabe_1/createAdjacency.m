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
test = dec2bin(15)
test(2) = ~test(2)
for i = 1:size
    for j = 1:size
        
        i_bin = dec2bin(i-1,12);
        j_bin = dec2bin(j-1,12);
        number_of_similar_bits = sum(i_bin==j_bin);
        
        if 12 == number_of_similar_bits + 1
            A(i,j) = 1;
            A(j,i) = 1;
        end
    end    
end
fprintf("done");
save('Adjacency.mat','A')