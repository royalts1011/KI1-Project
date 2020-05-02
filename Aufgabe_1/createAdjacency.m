%Berechnen Sie hier Ihre Adjazenzmatrix.

size = 4096;
A = zeros(size, size);

for n = 1:size
        
   n_bin = de2bi(n-1,12);
   for i = 1:12
      m_bin = n_bin;
      m_bin(i) = ~m_bin(i);
      A(n,bi2de(m_bin)+1) = 1;
      A(bi2de(m_bin)+1,n) = 1;
   end
    
end
save('Adjacency.mat','A')
