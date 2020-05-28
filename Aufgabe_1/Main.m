%Künstliche Intelligenz - Projekt 2 - Aufgabe 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen aller Gruppenmitglieder:


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lade einen der folgenden Datensätze
load('Dataset.mat');
%load('DatasetLarge.mat');

[k_best,best_acc] = optimise_k(1,200,X_train,Y_train,X_test,Y_test);
k_best
best_acc

figure()
for i=1:size(X_train,1)         %1000 is the length of x_vector and y_vector
   plot(X_train(i,1), X_train(i,2), 'o')
   hold on
   axis([-3 7 -3 7]);
   set(gca, 'ydir', 'reverse', 'xaxislocation', 'top')
end




function [k_best,best_acc] = optimise_k(k_begin,k_end,X_train,Y_train,X_test,Y_test)
    k_best =  -1;
    best_acc = -1;
    acc = 0;

    for iter=k_begin:k_end
        Y_pred = predict_kNN(X_train,Y_train,X_test,iter);
        for pred=1:size(Y_test,1)
            acc = acc + 1 - abs(Y_pred(pred) - Y_test(pred));
        end
        acc = acc/size(Y_test,1);
        if acc > best_acc
            best_acc = acc;
            k_best = iter;
        end
    end
   
end













