function [ V, L ] = bfs_gs( A, startState, goalState )

%Implementieren Sie hier die Breitensuche als Graphsuche.

% Timeout initialisieren
timeout = 5000;

% Queue initialisieren
startState = reshape(startState, 1, []); % kann bei dir denke ich weg
startState = num2str(startState);
startState = strrep(startState, ' ', '');
goalState = reshape(goalState, 1, []);      % brauchst du auch nicht


L = [startState];

% Start wurde besucht
V = {startState};

while not(isempty(L)) > 0 && timeout > 0
    
    % ersten Knoten aus Schlange nehmen
    state = L(1:12);
    L(1:12) = [];
   
    % testen ob Ziel erreicht
    if state == goalState
        return
    end
    
    for i = 1:length(A)
        if A(bin2dec(state) + 1:i) == 1 
            if not(ismember(dec2bin(i,12)-1,V))
                
                child = dec2bin(i,12) - 1;
                V = [V,child];
                L = [L,child];
                
            end
        end
    end
    
    timeout = timeout - 1;
    
end

end