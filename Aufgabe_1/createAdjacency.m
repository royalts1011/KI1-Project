%Berechnen Sie hier Ihre Adjazenzmatrix.

size = 4096;                    % 2^12 = 4096 mögliche Bilder / Knoten
A = zeros(size, size);          %Initialisierung der Adjazenzmatrix
    
for n = 1:size                  %Iterieren über alle möglichen Knoten
        
   n_bin = de2bi(n-1,12);       %Umwandlung von Dezimal in eine 12-Stellige Binärzahl
   for i = 1:12                 %Iterieren über alle bit-Positionen
      m_bin = n_bin;            %und flippen immer genau ein Bit / ein Pixel
      m_bin(i) = ~m_bin(i);     %Hier wird das i-te bit geflippt
      A(n,bi2de(m_bin)+1) = 1;
      A(bi2de(m_bin)+1,n) = 1;
   end
    
end
                                %Wir rechnen +1 bei den Indizes  der Matrix
                                %da diese bei eins und nicht wie unsere
                                %Knoten bei null anfängt
save('Adjacency.mat','A')
