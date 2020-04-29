function [ V, L, found_node ] = bfs_gs( A, startState, goalState )

%Implementieren Sie hier die Breitensuche als Graphsuche.

% flatten the inputs and convert them to Ints:
startState = reshape(startState', 1, []);
startState = num2str(startState);
startState = strrep(startState, ' ', '');
% array starts at 1 not at zero
startState = bin2dec(startState) + 1 ;

goalState = reshape(goalState', 1, []);
goalState = num2str(goalState);
goalState = strrep(goalState, ' ', '');
goalState = bin2dec(goalState);

found = false;
node_list = [];
node_list(1) = startState;
old_nodes = [];
L = 0;

while ~found
  
  % -1, da der vorherige den Knoten Codiert, weil idx mit 1 beginnt  
  if node_list(1) - 1 == goalState
      % bei found node den +1 offset wieder rausrechenen
      found_node = dec2bin(node_list(1) - 1);
      found = true;
      V = old_nodes;
      V(end + 1) = node_list(1);
  else
      idx_ls = A(node_list(1),:);
      old_nodes(end + 1) = node_list(1);
      for i = 1:length(idx_ls)
        if idx_ls(i) == 1 & ~(in_array(i, old_nodes)) & ~(in_array(i, node_list)) 
            node_list(end + 1) =  i;
        end     
      end
      node_list(1) = [];
      
      L = L + 1;
      if L == 4096
        L = 'Not Found';
        V = 'Not Found';
        break
      end
  end
  
  
end
        
end

function [bool] = in_array(e, A)
    bool = false;    
    for i = 1:length(A)
        if e == A(i)
            bool = true;          
        end
    end
end
