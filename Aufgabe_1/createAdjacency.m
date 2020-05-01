%Berechnen Sie hier Ihre Adjazenzmatrix.
binaryLength = 12;                              % 3x4 Matrix
m_size = 4096;                                  % 2^12, da wir in der 3x4 Matrix jeweils 0 oder 1 an jeder Stelle haben können.

A=zeros(m_size);
for i = 1:m_size
    for j = 1:m_size
        
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