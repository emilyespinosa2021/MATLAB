%%HW 3 AE 168 Emily Espinosa
%DESCRIPTION: This code analyzes a transport aircraft’s longitudinal dynamics by forming 
%full and reduced-order (short-period and phugoid) state-space models, then comparing their 
%step and frequency responses. It also derives the elevator-to-pitch-rate transfer function 
%and computes autopilot gain parameters and implementation details for a Simulink control model.
clear; close all; clc;
% Aircraft Parameters
gravity = 32.17405;
V = 169.98;
% Longitudinal derivatives
Xu_val = -0.0589;
Xa_val = 11.3367;
Xde_val = 0;
Zu_val = -0.3818;
Za_val = -103.5160;
Zde_val = -7.8184;
Mu_val = -0.0002;
Ma_val = -1.9408;
Mq_val = -0.8174;
Mde_val = -2.8818;
%1a
fprintf('=== Part 1a: Short Period Approximation ===\n');
A_long = [Xu_val, Xa_val, 0, -gravity;
Zu_val/V, Za_val/V, 1, 0;
Mu_val+(Ma_val*Zu_val)/V, Ma_val+(Ma_val*Za_val)/V, Mq_val+Mu_val, 0;
0, 0, 1, 0];
B_long = [Xde_val; Zde_val/V; Mde_val+(Ma_val*Zde_val)/V; 0];
C_a = [0 1 0 0];
D_long = 0;
sys_long_a = ss(A_long, B_long, C_a, D_long);
% Short period
A_sp = [Za_val/V, 1;
Ma_val+(Ma_val*Za_val)/V, Mq_val+Mu_val];
B_sp = [Zde_val/V;
Mde_val+(Ma_val*Zde_val)/V];
C_sp = [1 0];
D_sp = 0;
sys_sp = ss(A_sp, B_sp, C_sp, D_sp);
% Plot comparison
figure('Position', [50 50 1000 400]);
subplot(1,2,1);
step(sys_long_a, 'b-', sys_sp, 'r--', 60);
grid on; title('Step Response - α');
ylabel('α (rad)'); xlabel('Time (s)');
legend('Full Model', 'SP Approx', 'Location', 'southeast');
subplot(1,2,2);
bode(sys_long_a, 'b', sys_sp, 'r--'); grid on;
title('Bode Plot - α');
sgtitle('Part 1a: Short Period Comparison');
% Comment on approximation
fprintf('The short period approximation matches the high-frequency response well.\n\n');
%1b
fprintf('=== Part 1b: Phugoid Approximation ===\n');
% Full system with theta output
C_th = [0 0 0 1]; % theta output
sys_long_th = ss(A_long, B_long, C_th, D_long);
% Phugoid approximation
A_ph = [Xu_val, -gravity;
-Zu_val/V, 0];
B_ph = [Xde_val; -Zde_val/V];
C_ph = [0 1];
D_ph = 0;
sys_ph = ss(A_ph, B_ph, C_ph, D_ph);
figure('Position', [50 50 1000 400]);
subplot(1,2,1);
step(sys_long_th, 'b-', sys_ph, 'm--', 60);
grid on; title('Step Response - θ');
ylabel('θ (rad)'); xlabel('Time (s)');
legend('Full Model', 'Phugoid Approx', 'Location', 'southeast');
subplot(1,2,2);
bode(sys_long_th, 'b', sys_ph, 'm--'); grid on;
title('Bode Plot - θ');
sgtitle('Part 1b: Phugoid Comparison');
fprintf('Phugoid approximation captures low-frequency behavior.\n\n');
%1c
fprintf('=== Part 1c: Autopilot Parameters ===\n');
% Transfer function
s = tf('s');
N1 = V*Mde_val + Zde_val*Mu_val;
N0 = Mu_val*Zde_val - Zu_val*Mde_val;
D2 = V; % s^2 coefficient
D1 = -V*(Ma_val + Mu_val + Zu_val/V);
D0 = V*(Mu_val*Zu_val/V - Ma_val);
G_q = (N1*s + N0)/(D2*s^2 + D1*s + D0);
fprintf('TF δe → q:\n');
G_q
K_outer = 0.28;
K_inner = 0.18;
K_rate = 0.55;
theta_cmd_rad = 5 * pi/180;
delta_max_rad = 15 * pi/180;
fprintf('\nController Gains:\n');
fprintf('K1 (outer) = %.3f\n', K_outer);
fprintf('K2 (inner) = %.3f\n', K_inner);
fprintf('K_q (rate) = %.3f\n', K_rate);
fprintf('\nFor Simulink Model:\n');
fprintf('Step input: %.4f rad (5°)\n', theta_cmd_rad);
fprintf('Elevator limits: ±%.4f rad (±15°)\n', delta_max_rad);
fprintf('Actuator TF: 10/(s+10)\n');
fprintf('Aircraft TF num: [%.6f, %.6f]\n', N1, N0);
fprintf('Aircraft TF den: [%.6f, %.6f, %.6f]\n', D2, D1, D0);
% Save data
prob1_data.A_long = A_long;
prob1_data.B_long = B_long;
prob1_data.G_q = G_q;
prob1_data.K1 = K_outer;
prob1_data.K2 = K_inner;
prob1_data.Kq = K_rate;
prob1_data.theta_cmd = theta_cmd_rad;
prob1_data.delta_max = delta_max_rad;
