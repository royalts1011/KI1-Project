%Künstliche Intelligenz Projekt 3 Aufgabe 1: Am ROB rumfahren - Kalman
%machen, muss man nicht

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen aller Gruppenmitglieder:



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Lade Daten
load('KalmanData.mat');


%TODO: Berechne gefilterte Position
p_filtered=zeros(size(p)); %Die Null-Initialisierung dient nur der fehlerfreien Visualisierung und sollte durch die Filterung ersetzt werden.


%Visualization
figure
hold on
plot(p(1,:),p(2,:)) %Ground Truth
plot(odometry(1,:),odometry(2,:)) %Odometry data
plot(tracking(1,:),tracking(2,:)) %Tracking data
plot(p_filtered(1,:),p_filtered(2,:))   %Filtered Data
legend('Ground Truth','Odometrie','Tracking','Filtered')
plot(p(1,1),p(2,1),'x')    %Start point
plot(odometry(1,end),odometry(2,end),'x') %Odometry End Point
plot(tracking(1,end),tracking(2,end),'x') %Tracking End Point
plot(p_filtered(1,end),p_filtered(2,end),'x') %Filtered End Point
hold off



























