function [ V, L, found_node ] = dfs( A, startState, goalState )

%Implementieren Sie hier die einfache Tiefensuche.
  
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
    L = L + 1;
    if L == 4096
        L = old_nodes;
        V = 'Not Found';
        break
    end
    
    % curr_idx is last element in queue
    curr_idx = length(node_list);
  % -1, da der vorherige den Knoten Codiert, weil idx mit 1 beginnt  
  if node_list(curr_idx) - 1 == goalState
      % bei found_node den +1 offset wieder rausrechenen
      found_node = dec2bin(node_list(curr_idx) - 1);
      found = true;
      V = old_nodes;
      V(end + 1) = node_list(curr_idx);
  else
       % circle detection:
      if in_array(node_list(curr_idx),old_nodes)
          L = old_nodes;
          V = 'circle detected';
          break
      end
 
      idx_ls = A(node_list(curr_idx),:);
      old_nodes(end + 1) = node_list(curr_idx);
      for i = 1:length(idx_ls)
        node_list(end + 1) =  i;   
      end
      node_list(curr_idx) = [];
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