%Künstliche Intelligenz Projekt 3 Aufgabe 1: Am ROB rumfahren - Kalman
%machen, muss man nicht

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen aller Gruppenmitglieder:



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
%Lade Daten
load('KalmanData.mat');


%TODO: Berechne gefilterte Position
p_filtered=zeros(size(p)); %Die Null-Initialisierung dient nur der fehlerfreien Visualisierung und sollte durch die Filterung ersetzt werden.

% init - Prädiktion:
x_t = [0.0; 
        0.0; 
        0.0; 
        0.0];

F_t = [1, 0, 1, 0; 
        0, 1, 0, 1; 
        0, 0, 1, 0; 
        0, 0, 0, 1];

u_t = [0.0; 
        0.0];

B_t = [0.5, 0.0;
        0.0, 0.5;
        1, 0.0;
        0.0, 1];

P_t = [0.0, 0, 0, 0; 
        0, 0.0, 0, 0; 
        0, 0, 0.0, 0; 
        0, 0, 0, 0.0];
 
Q_t = [0.01, 0, 0, 0; 
        0, 0.01, 0, 0; 
        0, 0, 0.01, 0; 
        0, 0, 0, 0.01];


% init - Update:

z_t = [0.0; 
        0.0; 
        0.0; 
        0.0];

H_t =  [1, 0, 0, 0;
        0, 1, 0 ,0];
       

R_t = [0.5, 0; 
        0, 0.5];  
    

for t = 1:72
    
    % Prädiktion
    x_t = F_t * x_t + B_t * u_t;
    P_t = F_t * P_t * F_t' + Q_t;
    
    u_t = a(:,t);
    
    % Update
    z_t = tracking(:,t);
    
    K = (P_t * H_t') / (H_t * P_t * H_t' + R_t);
    
    x_t = x_t + K * (z_t - H_t * x_t);
    
    P_t = P_t - (K * H_t * P_t);
    
    p_filtered(:,t) = x_t(1:2);
   
end

% Euklidischer Abstand zwischen p_filtered und ground trouth
erg = (p_filtered - p).^2;
erg = sqrt(erg(1,:) + erg(2,:));
erg = sum(erg);

disp(['Error: ', num2str(erg)])

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



























