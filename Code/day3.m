% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert h�sten 2006 av Jostein Bakkeheim
% Oppdatert h�sten 2008 av Arnfinn Aas Eielsen
% Oppdatert h�sten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]
V_s0 = 7.5; %stable voltate when e=0 [V]

%%%%%%%%%%% Task 1.1 Mathematical modeling
K_f = (-l_c*m_c*g + 2*l_h*m_p*g)/(l_h*V_s0); %Motor force constant [N/V]
J_p = 2*m_p*(l_p)^2;
J_e = m_c*(l_c)^2 + 2*m_p*(l_h)^2;
J_l = m_c*(l_c)^2 + 2*m_p*((l_h)^2 + (l_p)^2); 
K_1 = K_f*l_p/J_p;
K_2 = l_h*K_f/J_e;
K_3 =l_h*K_f/J_l;
lambda_1 = -1 + 1i;
lambda_2 = -1 - 1i;
K_pd = -(lambda_1 + lambda_2)/K_1;
K_pp = lambda_1*lambda_2/K_1;
gyro_offset = [-0.018; 0.054; 0.005];

PORT = 6; %Arduino port
%% Task 2.3.4
A= [0 1 0 0 0;
    0 0 0 0 0;
    0 0 0 1 0;
    0 0 0 0 0;
    K_3 0 0 0 0];

B = [0 0;
     0 K_1;
     0 0;
     K_2 0;
     0 0];
    
C = [1 0 0 0 0;
     0 1 0 0 0;
     0 0 1 0 0;
     0 0 0 1 0;
     0 0 0 0 1];

%p = [-8 -8+1i -8-1i -8 -8]; %Poles task 2.3.4.1

p = [-80 -80+10i -80-10i -80 -80]; %Poles task 2.3.4.2

L = place(A', C', p)';


A_i = [0 1 0 0 0; 
     0 0 0 0 0;
     0 0 0 0 0;
     1 0 0 0 0;
     0  0 1 0 0];
 
 B_i = [0 0;
       0 K_1;
       K_2 0;
       0 0;
       0 0];

CT = [B_i A_i*B_i A_i*A_i*B_i];

C_i = [1 0 0 0 0; 0 0 1 0 0];

G_i = [0 0;
       0 0;
       0 0;
      -1 0;
       0 -1];

Q_i = [ 5 0 0 0 0;
        0 5 0 0 0; 
        0 0 10 0 0;
        0 0 0 40 0;
        0 0 0 0 90];
  

R_i = [1 0;
       0 0.5];
 

K_i = lqr(A_i, B_i, Q_i, R_i);

%F_i = inv([C_i*inv(B_i*K_i - A_i)*B_i]);
% F_i = [K_i(1,1) K_i(1,3);
%        K_i(2,1) K_i(2,3)];
F_i = [0 1;
       1 0];
   

