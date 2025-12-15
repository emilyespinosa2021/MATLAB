%%AE 168 HW2 Emily Espinosa
%DESCRIPTION: This code computes and plots the pitching moment coefficient versus angle of attack
%for an aircraft, comparing configurations with and without a horizontal tail. It visualizes how 
%the tail affects longitudinal stability by showing the difference in pitching moment curves.

alpha_deg = linspace(-5, 15, 100); 

Cm_with_ht = 0.0927 - 0.0035 .* alpha_deg;

Cm_no_ht = 0.05 - 0.0035 .* alpha_deg;

figure('Position', [100, 100, 800, 600]);
plot(alpha_deg, Cm_with_ht, 'b-', 'LineWidth', 2.5);
hold on;
plot(alpha_deg, Cm_no_ht, 'r--', 'LineWidth', 2.5);
hold off;

xlabel('Angle of Attack, \alpha (deg)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Pitching Moment Coefficient, C_M', 'FontSize', 12, 'FontWeight', 'bold');
title('Pitching Moment Characteristics: Effect of Horizontal Tail', ...
'FontSize', 14, 'FontWeight', 'bold');

legend('With Horizontal Tail', 'Without Horizontal Tail', ...
'Location', 'northeast', 'FontSize', 11);
grid on;
grid minor;
set(gca, 'FontSize', 11, 'GridAlpha', 0.3);

xlim([-5, 15]);
ylim([min(Cm_no_ht)-0.01, max(Cm_with_ht)+0.01]);
