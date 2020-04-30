function [ V, L, found_node ] = dfs( A, startState, goalState )

%Implementieren Sie hier die einfache Tiefensuche.
  
% flatten the inputs and convert them to Ints:
startState = reshape(startState', 1, []);
startState = num2str(startState);
startState = strrep(startState, ' ', '');
% array starts at 1 not at zero
startState = bin2dec(startState) ;

goalState = reshape(goalState', 1, []);
goalState = num2str(goalState);
goalState = strrep(goalState, ' ', '');
goalState = bin2dec(goalState) ;


nodes = [];
discovered = [];
nodes(1) = startState;
iter = 0;
while iter < 10000
    iter = iter + 1;
    curr = nodes(end);
    visited = false;
    for i = 1: length(discovered)
        if discovered(i) == curr
            L = iter;
            V = discovered;
            visited = true;
        end
    end
    if visited
        break
    end
    discovered(end + 1) = curr;
    nodes(end) = [];
    
    if curr == goalState
        L = iter;
        found_node = dec2bin(curr, 12);
        V = discovered;
        break
        
    end
    
    for i = 0 : length(A) - 1
        if A(curr + 1,i + 1) == 1
            nodes(end + 1) = i;
        end
        
    end
end
       