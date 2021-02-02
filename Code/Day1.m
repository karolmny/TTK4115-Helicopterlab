%% Labday 1

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
