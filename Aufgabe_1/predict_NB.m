function [Y_pred] = predict_NB(X_train,Y_train,X_test)
%In dieser Funktion wird ein Naive Bayes Klassifikator genutzt, um auf
%Basis der Beobachtungen X_train und Y_train eine Klassifikation f�r X_test
%zu treffen.
X_train = quantify_data(X_train);
X_test = quantify_data(X_test);
[counterZero,counterOne,probZero,probOne] = global_prob(Y_train);
freq = calc_freq(X_train,Y_train,counterZero,counterOne);

Y_pred = zeros(size(X_test,1),1);
for entry=1:size(X_test,1)
    numerator_no = probZero;
    numerator_yes = probOne;
    
    for data_point=1:size(X_test,2)
        class = X_test(entry,data_point);
        numerator_no = numerator_no * freq(class,2,data_point); 
        numerator_yes = numerator_yes * freq(class,3,data_point);
    end
    if numerator_no > numerator_yes
        Y_pred(entry) = 0;
    else
        Y_pred(entry) = 1;
    end
end
end


function [counterZero,counterOne,probZero,probOne] = global_prob(Y_train)
counterZero = sum(Y_train(:)==0);
counterOne = sum(Y_train(:)==1);
probZero = counterZero/(size(Y_train,1));
probOne = counterOne/(size(Y_train,1));
end


function x_train = quantify_data(x_old)
    x_train = zeros(size(x_old,1),size(x_old,2));
    for pred=1:size(x_old,1)
        for var=1:size(x_old,2)
            if x_old(pred,var) < 0
                x_train(pred,var) = 1; %sehr klein
            
            elseif x_old(pred,var) <= 2
                x_train(pred,var) = 2; %klein
            
            elseif x_old(pred,var) <= 4
                x_train(pred,var) = 3; %gro�
            else
                x_train(pred,var) = 4; %sehr gro�
            end
        end
    end
end

function freq = calc_freq(X_train,Y_train,counterZero,counterOne)
    num_features = size(X_train,2);
    num_classes = 4;
    freq = zeros(num_classes,3,num_features);
    
    for feature=1:num_features
        for class=1:num_classes
            yes_cnt = 0;
            no_cnt = 0;
            for i=1:size(X_train,1)
                if X_train(i,feature) == class
                   if Y_train(i) == 0
                        no_cnt = no_cnt + 1;
                   else
                       yes_cnt = yes_cnt + 1;
                   end
                end
                freq(class,1,feature) = class;
                freq(class,2,feature) = no_cnt/counterZero;
                freq(class,3,feature) = yes_cnt/counterOne;
            end
            
            
            
        end
    
    end
    
end