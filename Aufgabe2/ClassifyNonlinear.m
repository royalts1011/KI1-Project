%KI Projekt 2 Aufgabe 2
%--------------------------------------------------------------------------
%Unterscheiden Sie gute von nicht so guten Weinen. 
%Ein Wein zählt als gut wenn er einen Score von 7 oder mehr erreicht.

%Lade Datensatz
load('Data.mat');


%Beipsielhaftes Training einer SVR. Hier wird ein radial basis function (rbf) Kernel
%verwendet.
C=1;
gamma=10;

%training
SVMModel_nonlinear=fitcsvm(X_train,y_train,'BoxConstraint',C,'KernelFunction','rbf','KernelScale',gamma);

%test
y_pred=predict(SVMModel_nonlinear,X_test);















































