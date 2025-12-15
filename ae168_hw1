%%AE 168 HW 1 Emily Espinosa 
%DESCRIPTION:This code constructs the state-space model of a Learjet 24’s 
%longitudinal dynamics using given aerodynamic stability derivatives. 
%It then computes and displays the system poles, evaluates stability, and 
%plots the pole locations on the complex plane.
clear all; close all; clc;
% Given Parameters
g = 32.17405;
h = 0;
U1 = 169.98;
Xu = -0.0589;
Xw = 11.3367;
Xde = 0;
Zu = -0.3818;
Zw = -103.5160;
Zde = -7.8184;
Mu = -0.0002;
Mw = -1.9408;
Mq = -0.3027;
Mw_dot = -0.8174;
Mde = -2.8818;
% A
A = zeros(4,4);
A(1,1) = Xu;
A(1,2) = Xw;
A(1,3) = 0;
A(1,4) = -g;
A(2,1) = Zu/U1;
A(2,2) = Zw/U1;
A(2,3) = 1;
A(2,4) = 0;
A(3,1) = Mu + Mw_dot*Zu/U1;
A(3,2) = Mw + Mw_dot*Zw/U1;
A(3,3) = Mq + Mw_dot;
A(3,4) = 0;
A(4,1) = 0;
A(4,2) = 0;
A(4,3) = 1;
A(4,4) = 0;
% B matrix
B = zeros(4,1);
B(1,1) = Xde;
B(2,1) = Zde/U1;
B(3,1) = Mde + Mw_dot*Zde/U1;
B(4,1) = 0;
% C matrix
C = eye(4);
% D matrix
D = zeros(4,1);
% Display matrices
disp('=== Part (a) - State-Space Matrices ===');
disp('A matrix:');
disp(A);
disp('B matrix:');
disp(B);
disp('C matrix:');
disp(C);
disp('D matrix:');
disp(D);
% Create state-space system
sys_long = ss(A, B, C, D);
%b
% Calculate poles
poles = eig(A);
disp('Open-loop poles:');
disp(poles);
% Calculate damping ratios and natural frequencies
for i = 1:length(poles)
if imag(poles(i)) ~= 0 && real(poles(i)) < 0
wn = abs(poles(i));
zeta = -real(poles(i))/wn;
fprintf('Pole %d: %.4f + %.4fi | wn = %.4f rad/s, zeta = %.4f\n', ...
i, real(poles(i)), imag(poles(i)), wn, zeta);
elseif imag(poles(i)) == 0
fprintf('Pole %d: %.4f | Real pole\n', i, poles(i));
end
end
% Stability determination
unstable_poles = sum(real(poles) > 0);
if unstable_poles > 0
fprintf('\n*** OPEN-LOOP SYSTEM: UNSTABLE!!! ***\n');
fprintf('Reason: %d poles in the right-half plane\n', unstable_poles);
else
fprintf('\n*** OPEN-LOOP SYSTEM: STABLE!!! ***\n');
fprintf('Reason: All poles in the left haf plane\n');
end
% pole locations
figure;
plot(real(poles), imag(poles), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
grid on;
xlabel('Real Axis');
ylabel('Imaginary Axis');
title('Pole Locations of Learjet 24 Longitudinal Dynamics');
% Add stability boundary
line([0 0], ylim, 'Color', 'k', 'LineStyle', '--', 'LineWidth', 1);
line(xlim, [0 0], 'Color', 'k', 'LineStyle', '--', 'LineWidth', 1);
legend('System Poles', 'Stability Boundary', 'Location', 'best');
