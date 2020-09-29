clear; clc;

n = 8;  % # of States
k = -5; % Kappa
m = 1;
%% Loading Data
load("project_data");
p_s1 = sat_ECI_pos.pos_ECI_gps1;
p_s2 = sat_ECI_pos.pos_ECI_gps2;
p_s3 = sat_ECI_pos.pos_ECI_gps3;
p_s4 = sat_ECI_pos.pos_ECI_gps4;
p_R  = sat_ECI_pos.pos_ECI_rasat;
v_s1 = sat_ECI_vel.vel_ECI_gps1;
v_s2 = sat_ECI_vel.vel_ECI_gps2;
v_s3 = sat_ECI_vel.vel_ECI_gps3;
v_s4 = sat_ECI_vel.vel_ECI_gps4;
v_R  = sat_ECI_vel.vel_ECI_rasat;
a_R  = acc_ECI_rasat;


%% Initial Values
p_states(1,1)  = 2692.438741139469;
p_states(1,2)  = -1355.325338031282;
p_states(1,3)  = -6373.447919573494;
v_states(1,1)  = -6.848841423485515;
v_states(1,2)  = 0.661653015755064;
v_states(1,3)  = -3.027614310257790;
for i=1 : 36001
b_states(i,1)    = 0.015;
d_states(i,1)    = 0.0015;
end

p              = [100  0  0  0    0    0    0   0;
                  0   100  0  0    0    0    0   0;
                  0   0  100  0    0    0    0   0;
                  0   0   0 10    0    0    0   0;
                  0   0   0 0    10    0    0   0;
                  0   0   0 0    0   10    0   0;
                  0   0   0 0    0    0    10 0;
                  0   0   0 0    0    0    0   0.1] * (10^-4);              
              
Q               = [10  0  0  0    0    0    0   0;
                  0   10  0  0    0    0    0   0;
                  0   0  10  0    0    0    0   0;
                  0   0   0 1   0    0    0   0;
                  0   0   0 0    1  0    0   0;
                  0   0   0 0    0    1    0   0;
                  0   0   0 0    0    0   1  0;
                  0   0   0 0    0    0    0   0.01] * (10^-4);
              

R              = [9  0  0  0   0      0      0      0;
                  0  9  0  0   0      0      0      0;
                  0  0  9 0    0      0      0      0;
                  0  0  0 9    0      0      0      0;
                  0  0  0 0    0.5625 0      0      0;
                  0  0  0 0    0      0.5625 0      0;
                  0  0  0 0    0      0      0.5625 0;
                  0  0  0 0    0      0      0      0.5625] * 10^(-6);
%% Bias and Noise Terms
b_r      = 0.025;     % Bias in psuedo range mes.[km] 
sigma_r  = 0.003;     % Standart Deviation in  psuedo range mes.[km]
b_rr     = 0.003;     % Bias in psuedo range rate mes.[km/s] 
sigma_rr = 0.00075;   % Standart Deviation in  psuedo range rate mes.[km/s]

%% Psuedo Measurements at each second
for i=1 : 3599
    me_psu_r1(i,1)  = ((p_s1(i,1)-p_R(i,1))^2 + (p_s1(i,2)-p_R(i,2))^2 + (p_s1(i,3)-p_R(i,3))^2)^0.5 + b_r + normrnd(0,sigma_r);
    me_psu_r2(i,1)  = ((p_s2(i,1)-p_R(i,1))^2 + (p_s2(i,2)-p_R(i,2))^2 + (p_s2(i,3)-p_R(i,3))^2)^0.5 + b_r + normrnd(0,sigma_r);
    me_psu_r3(i,1)  = ((p_s3(i,1)-p_R(i,1))^2 + (p_s3(i,2)-p_R(i,2))^2 + (p_s3(i,3)-p_R(i,3))^2)^0.5 + b_r + normrnd(0,sigma_r);
    me_psu_r4(i,1)  = ((p_s4(i,1)-p_R(i,1))^2 + (p_s4(i,2)-p_R(i,2))^2 + (p_s4(i,3)-p_R(i,3))^2)^0.5 + b_r + normrnd(0,sigma_r);
    me_psu_rr1(i,1) = ((p_s1(i,1)-p_R(i,1))*(v_s1(i,1)-v_R(i,1)) + (p_s1(i,2)-p_R(i,2))*(v_s1(i,2)-v_R(i,2)) + (p_s1(i,3)-p_R(i,3))*(v_s1(i,3)-v_R(i,3))) / ((p_s1(i,1)-p_R(i,1))^2 + (p_s1(i,2)-p_R(i,2))^2 + (p_s1(i,3)-p_R(i,3))^2)^0.5 + b_rr + normrnd(0,sigma_rr);
    me_psu_rr2(i,1) = ((p_s2(i,1)-p_R(i,1))*(v_s2(i,1)-v_R(i,1)) + (p_s2(i,2)-p_R(i,2))*(v_s2(i,2)-v_R(i,2)) + (p_s2(i,3)-p_R(i,3))*(v_s2(i,3)-v_R(i,3))) / ((p_s2(i,1)-p_R(i,1))^2 + (p_s2(i,2)-p_R(i,2))^2 + (p_s2(i,3)-p_R(i,3))^2)^0.5 + b_rr + normrnd(0,sigma_rr);
    me_psu_rr3(i,1) = ((p_s3(i,1)-p_R(i,1))*(v_s3(i,1)-v_R(i,1)) + (p_s3(i,2)-p_R(i,2))*(v_s3(i,2)-v_R(i,2)) + (p_s3(i,3)-p_R(i,3))*(v_s3(i,3)-v_R(i,3))) / ((p_s3(i,1)-p_R(i,1))^2 + (p_s3(i,2)-p_R(i,2))^2 + (p_s3(i,3)-p_R(i,3))^2)^0.5 + b_rr + normrnd(0,sigma_rr);
    me_psu_rr4(i,1) = ((p_s4(i,1)-p_R(i,1))*(v_s4(i,1)-v_R(i,1)) + (p_s4(i,2)-p_R(i,2))*(v_s4(i,2)-v_R(i,2)) + (p_s4(i,3)-p_R(i,3))*(v_s4(i,3)-v_R(i,3))) / ((p_s4(i,1)-p_R(i,1))^2 + (p_s4(i,2)-p_R(i,2))^2 + (p_s4(i,3)-p_R(i,3))^2)^0.5 + b_rr + normrnd(0,sigma_rr);
end

%% Model Values at each 0.1 second
for i=2 : 36001
    for j=1 : 3
        p_states(i,j) = p_states(i-1,j) + v_states(i-1,j) * 0.1; % Position
        v_states(i,j) = v_states(i-1,j) + a_R(i-1,j) * 0.1;      % Velocity     
    end
end
m_states = [p_states v_states b_states d_states]';
%% Psuedo Values from Model
for i=1 : 3599
    m_psu_r1(i,1)  = ((p_s1(i,1)-p_states(m,1))^2 + (p_s1(i,2)-v_states(m,1))^2 + (p_s1(i,3)-p_states(m,3))^2)^0.5 + 0.015 + normrnd(0,sigma_r);
    m_psu_r2(i,1)  = ((p_s2(i,1)-p_states(m,1))^2 + (p_s2(i,2)-p_states(m,2))^2 + (p_s2(i,3)-p_states(m,3))^2)^0.5 + 0.015 + normrnd(0,sigma_r);
    m_psu_r3(i,1)  = ((p_s3(i,1)-p_states(m,1))^2 + (p_s3(i,2)-p_states(m,2))^2 + (p_s3(i,3)-p_states(m,3))^2)^0.5 + 0.015 + normrnd(0,sigma_r);
    m_psu_r4(i,1)  = ((p_s4(i,1)-p_states(m,1))^2 + (p_s4(i,2)-p_states(m,2))^2 + (p_s4(i,3)-p_states(m,3))^2)^0.5 + 0.015+ normrnd(0,sigma_r);
    m_psu_rr1(i,1) = ((p_s1(i,1)-p_states(m,1))*(v_s1(i,1)-v_states(m,1)) + (p_s1(i,2)-v_states(m,1))*(v_s1(i,2)-v_states(m,2)) + (p_s1(i,3)-p_states(m,3))*(v_s1(i,3)-v_states(m,3))) / ((p_s1(i,1)-p_states(m,1))^2 + (p_s1(i,2)-v_states(m,1))^2 + (p_s1(i,3)-p_states(m,3))^2)^0.5 + 0.0015 + normrnd(0,sigma_rr);
    m_psu_rr2(i,1) = ((p_s2(i,1)-p_states(m,1))*(v_s2(i,1)-v_states(m,1)) + (p_s2(i,2)-v_states(m,1))*(v_s2(i,2)-v_states(m,2)) + (p_s2(i,3)-p_states(m,3))*(v_s2(i,3)-v_states(m,3))) / ((p_s2(i,1)-p_states(m,1))^2 + (p_s2(i,2)-p_states(m,2))^2 + (p_s2(i,3)-p_states(m,3))^2)^0.5 + 0.0015 + normrnd(0,sigma_rr);
    m_psu_rr3(i,1) = ((p_s3(i,1)-p_states(m,1))*(v_s3(i,1)-v_states(m,1)) + (p_s3(i,2)-v_states(m,1))*(v_s3(i,2)-v_states(m,2)) + (p_s3(i,3)-p_states(m,3))*(v_s3(i,3)-v_states(m,3))) / ((p_s3(i,1)-p_states(m,1))^2 + (p_s3(i,2)-p_states(m,2))^2 + (p_s3(i,3)-p_states(m,3))^2)^0.5 + 0.0015 + normrnd(0,sigma_rr);
    m_psu_rr4(i,1) = ((p_s4(i,1)-p_states(m,1))*(v_s4(i,1)-v_states(m,1)) + (p_s4(i,2)-v_states(m,1))*(v_s4(i,2)-v_states(m,2)) + (p_s4(i,3)-p_states(m,3))*(v_s4(i,3)-v_states(m,3))) / ((p_s4(i,1)-p_states(m,1))^2 + (p_s4(i,2)-p_states(m,2))^2 + (p_s4(i,3)-p_states(m,3))^2)^0.5 + 0.0015 + normrnd(0,sigma_rr);
    m = 10 * i + 1;
end

%% Unscented Kalman Filter
for i=1 : 36001
    p_c_nk   = chol((n+k)*p);
%Set Sigma Points
    sigma_pt = [m_states(:,i) (m_states(:,i)+p_c_nk(:,1)) (m_states(:,i)-p_c_nk(:,1)) (m_states(:,i)+p_c_nk(:,2)) (m_states(:,i)-p_c_nk(:,2)) (m_states(:,i)+p_c_nk(:,3)) (m_states(:,i)-p_c_nk(:,3)) (m_states(:,i)+p_c_nk(:,4)) (m_states(:,i)-p_c_nk(:,4))...
            (m_states(:,i)+p_c_nk(:,5)) (m_states(:,i)-p_c_nk(:,5)) (m_states(:,i)+p_c_nk(:,6)) (m_states(:,i)-p_c_nk(:,6)) (m_states(:,i)+p_c_nk(:,7)) (m_states(:,i)-p_c_nk(:,7)) (m_states(:,i)+p_c_nk(:,8)) (m_states(:,i)-p_c_nk(:,8))];
    sigma_pt_prop   = sigma_prop(sigma_pt,a_R,i);            % Sigma Points Propogation
    pred_s          = pred_states(sigma_pt_prop,n,k);        % Predicted Mean (Xk+1-)
    pred_p          = pred_cov(sigma_pt_prop,pred_s,n,k) + Q;% Predicted Covariance (Pk+1-)
    upt_states(:,i) = pred_s;                                % Directly Update the States in the absence of GPS
    p = pred_p;
     if mod(i,10) == 1 && i ~= 36001 && i ~= 35991
            psu_sigma = obser_sigma_pt(sigma_pt_prop,p_s1,p_s2,p_s3,p_s4,v_s1,v_s2,v_s3,v_s4,i); % Predicted Observation, (yk+1-)(i)
            pred_mes = pred_measurement(psu_sigma,n,k);                                          % Predicted Mean Measurement (yk+1-)
            pred_p_yy = pred_cov_yy(psu_sigma,pred_mes,n,k);                                     % Predicted Covariance (Pk+1-)yy
            pred_p_vv = pred_p_yy + R;                                                           % Innovaton Covariance
            pred_p_xy = pred_cov_xy(sigma_pt_prop,pred_s,psu_sigma,pred_mes,n,k);                % Cross Correlation Matrix
            e  = residual(me_psu_r1,me_psu_r2,me_psu_r3,me_psu_r4,me_psu_rr1,me_psu_rr2,me_psu_rr3,me_psu_rr4,pred_mes,i); % Residual
            Kk = pred_p_xy * inv(pred_p_vv);                                                                                    % Kalman Gain Calculation
            upt_states(:,i) = pred_s + Kk * e;
            p = pred_p - Kk * pred_p_vv * Kk';
     end

end
t = 1:1:3599;
t2 = 1:1:36001;
for i=1: 3599
    comp_p_states_x(i,1) = p_states(10 * i -9,1);
    comp_upt_states(i,1) = upt_states(1,10 * i -9);
    comp_upt_states(i,2) = upt_states(2,10 * i -9);
    comp_upt_states(i,3) = upt_states(3,10 * i -9);
    comp_upt_states(i,4) = upt_states(4,10 * i -9);
    comp_upt_states(i,5) = upt_states(5,10 * i -9);
    comp_upt_states(i,6) = upt_states(6,10 * i -9);
    comp_upt_states_b(i,1) = upt_states(7,10 * i -9);
    comp_upt_states_b(i,2) = upt_states(8,10 * i -9);
end

% figure;
% plot(t, p_R(:,1));
% hold on
% plot(t, comp_p_states_x);
% legend('Real Position', 'modeled position');
% xlabel('t');
% ylabel('position in x direction');
% %% Model vs Real Data Check
% diff_x = p_R(:,1)- comp_p_states_x;
% figure;
% plot(t, diff_x);
% xlabel('t');
% ylabel('position in x direction');
% title('Difference Between Modeled Data and Real Data');

%% KF vs Real Data Results
diff_results = [p_R v_R] - comp_upt_states;
figure;
subplot(3,3,1);
plot(t, diff_results(:,1)*1000,'-r');
xlabel('t');
ylabel('Position m ');
title('Difference in x direction');
refline(0,9)
refline(0,-9)

subplot(3,3,2);
plot(t, diff_results(:,2)*1000,'-r');
xlabel('t');
% ylabel(' ');
title('Difference in y direction');
refline(0,9)
refline(0,-9)

subplot(3,3,3);
plot(t, diff_results(:,3)*1000,'-r');
xlabel('t');
% ylabel(' ');
title('Difference in z direction');
refline(0,9)
refline(0,-9)

subplot(3,3,4);
plot(t, diff_results(:,4)*1000,'-k');
xlabel('t');
ylabel('Velocity m / s]');
title('Difference in x direction');
refline(0,2.25)
refline(0,-2.25)

subplot(3,3,5);
plot(t, diff_results(:,5)*1000,'-k');
xlabel('t');
% ylabel('Velocity ');
title('Difference in y direction');
refline(0,2.25)
refline(0,-2.25)

subplot(3,3,6);
plot(t, diff_results(:,6)*1000,'-k');
xlabel('t');
% ylabel('Velocity ');
title('Difference in z direction');
refline(0,2.25)
refline(0,-2.25)

subplot(3,3,7);
plot(t,comp_upt_states_b(:,1)*1000,'-g');
xlabel('t');
ylabel('Bias m');
refline(0,34)
refline(0,16)

subplot(3,3,8);
plot(t,comp_upt_states_b(:,2)*1000,'-g');
xlabel('t');
ylabel('Bias m/s');
refline(0,0.25)
refline(0,5.75)
