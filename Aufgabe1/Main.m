%Künstliche Intelligenz - Projekt 2 - Aufgabe 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen aller Gruppenmitglieder:


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lade einen der folgenden Datensätze
load('Dataset.mat');
%load('DatasetLarge.mat');

[knn_k_best,knn_acc,knn_pred] = optimise_k(1,200,X_train,Y_train,X_test,Y_test);
[nb_acc,nb_pred] = nb_accuracy(X_train, Y_train, Y_test, X_test);
nb_acc
knn_k_best
knn_acc
subplot(2,2,1);
gscatter(X_train(:,1),X_train(:,2),Y_train,'rgb','osd');
xlabel('Feature 1');
ylabel('Feature 2');

title("X_{train} with labels");

subplot(2,2,2);
gscatter(X_test(:,1),X_test(:,2),Y_test,'rgb','osd');
xlabel('Feature 1');
ylabel('Feature 2');

title("X_{test} with labels");

subplot(2,2,3);
gscatter(X_test(:,1),X_test(:,2),knn_pred,'rgb','osd');
xlabel('Feature 1');
ylabel('Feature 2');

title("X_{test} evaluated with knn");

subplot(2,2,4);
gscatter(X_test(:,1),X_test(:,2),nb_pred,'rgb','osd');
xlabel('Feature 1');
ylabel('Feature 2');
title("X_{test} evaluated with nb");





%gscatter(X_train(:,1),X_train(:,2),'rgb','osd');
function [k_best,best_acc,knn_pred] = optimise_k(k_begin,k_end,X_train,Y_train,X_test,Y_test)
    k_best =  -1;
    best_acc = -1;
    

    for iter=k_begin:k_end
        acc = 0;
        Y_pred = predict_kNN(X_train,Y_train,X_test,iter);
        for pred=1:size(Y_test,1)
            acc = acc + 1 - abs(Y_pred(pred) - Y_test(pred));
        end
        acc = acc/size(Y_test,1);
        if acc > best_acc
            best_acc = acc;
            k_best = iter;
            knn_pred = Y_pred;
            
        end
    end

end

function [acc,Y_pred] = nb_accuracy(X_train, Y_train, Y_test, X_test)
    Y_pred = predict_NB(X_train,Y_train,X_test);
    acc = 0;
    for pred=1:size(Y_test,1)
        acc = acc + 1 - abs(Y_pred(pred) - Y_test(pred));
    end
    acc = acc/size(Y_test,1);
end




