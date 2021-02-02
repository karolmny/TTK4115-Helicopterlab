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

%% Day 2


% %%%%%%%%
 A = [0 1 0 ; 
      0 0 0 ;
      0 0 0];
 
B = [0 0;
     0 K_1;
     K_2 0];
  
CT = [B A*B A*A*B];

C = [1 0 0; 0 0 1];

pole = [-0.7 -1.1+1i -1.1-1i];

%K = place(A, B, pole);

Q = [ 75 0 0;
     0 3 0; 
      0 0 25];

R = [1 0;
     0 1];

K = lqr(A, B, Q, R);

 F = inv([C*inv(B*K - A)*B]);


%%%% TASK 2.2.4
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

% %F_i = inv([C_i*inv(B_i*K_i - A_i)*B_i]);
 F_i = [K_i(1,1) K_i(1,3);
        K_i(2,1) K_i(2,3)];
% F_i = [0 1;
%        1 0];