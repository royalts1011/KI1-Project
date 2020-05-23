%KI Projekt 2 Aufgabe 2
%--------------------------------------------------------------------------
%Unterscheiden Sie gute von nicht so guten Weinen. 
%Ein Wein zählt als gut wenn er einen Score von 7 oder mehr erreicht.

%Lade Datensatz
load('Data.mat');


%Beipsielhaftes Training einer SVM. Hier wird ein linearer Kernel
%verwendet.

%training
C=1;
SVMModel_linear=fitcsvm(X_train,Y_train,'BoxConstraint',C);

%test
Y_pred=predict(SVMModel_linear,X_test);
















































