%% Task 2.4.1

load groundNoise
load flyingNoise

Covar_still = groundNoise(10:14, 1000:(end-1000));
R_d_still = cov(Covar_still');

Covar_running = flyingNoise(10:14, 6000:(end-1000));
R_d_running = cov(Covar_running');
R_d = R_d_running;

% figure(1)
% plot(flyingNoise(1,:), flyingNoise(10,:), 'g')
% hold on
% plot(groundNoise(1,:), groundNoise(10,:), 'r')
% 
% 
% figure(2)
% plot(flyingNoise(1,:), flyingNoise(10,:), 'r')
% hold on
% plot(flyingNoise(1,1:end), flyingNoise(11,1:end), 'g')
% hold on
% plot(flyingNoise(1,1:end), flyingNoise(12,1:end), 'm')
% hold on
% plot(flyingNoise(1,1:end), flyingNoise(13,1:end), 'b')
% hold on
% 
% figure(3)
% plot(groundNoise(1,1:end), groundNoise(10,1:end), 'r')
% hold on
% plot(groundNoise(1,1:end), groundNoise(11,1:end), 'g')
% hold on
% plot(groundNoise(1,1:end), groundNoise(12,1:end), 'm')
% hold on
% plot(groundNoise(1,1:end), groundNoise(13,1:end), 'b')
% hold on

%% Task 2.4.2

%gyro_offset1 = [-0.018; 0; 0.005];

Ac = [0 1 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 1 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 1;
     K_3 0 0 0 0 0];

Bc = [0 0;
     0 K_1;
     0 0;
     K_2 0;
     0 0;
     0 0];
    
Cc = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0;
     0 0 0 1 0 0;
     0 0 0 0 0 1];
 
Dc = 0;
  
sysC = ss(Ac,Bc,Cc,Dc);
Ts = 0.002;
sysD = c2d(sysC, Ts);

Ad = sysD.A;
Bd = sysD.B;
Cd = sysD.C;
Dd = sysD.D;

P_init = [0.0122 0 0 0 0 0;
          0 0.0114 0 0 0 0;
          0 0 0.0234 0 0 0;
          0 0 0 0.0151 0 0;
          0 0 0 0 63.6004 0;
          0 0 0 0 0 0.01646];
    

x_init = [0;0;-0.54;0;0;0];


% Q_d = [0.05 0 0 0 0 0;
%        0 0.05 0 0 0 0;
%        0 0 0.05 0 0 0;
%        0 0 0 0.05 0 0;
%        0 0 0 0 0.05 0;
%        0 0 0 0 0 0.05];


Q_d = [0.01 0 0 0 0 0;
       0 0.1 0 0 0 0;
       0 0 1 0 0 0;
       0 0 0 0.1 0 0;
       0 0 0 0 1 0;
       0 0 0 0 0 1].*(10^(-04));


