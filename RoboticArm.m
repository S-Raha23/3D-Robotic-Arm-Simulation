% Clear workspace
clear; clc; close all;

% Define link lengths (fixed)
L1 = 1; % Length of the first rotational link
L2 = 1; % Length of the second rotational link

% Define initial joint variables
d1 = 0.5;          % Prismatic joint displacement (along Z-axis)
theta2 = 0;        % Initial angle for Joint 2
theta3 = 0;        % Initial angle for Joint 3

% Create figure
figure;
axis([-3 3 -3 3 0 3]); % Set axis limits for X, Y, Z
grid on; hold on;
xlabel('X-axis'); ylabel('Y-axis'); zlabel('Z-axis');
title('3D Robotic Arm Simulation ');
view(3); % 3D view

% Animation loop
for t = 1:100
    % Update joint variables (simulating motion)
    %base = sin(0.1 * t); % Base oscillates left and right
    d1 = sin(0.1 * t);            % Prismatic joint displacement (fixed in this simulation)
    theta2 = 0.1 * t;    % Joint 2 rotates over time
    theta3 = 0.2 * sin(0.1 * t); % Joint 3 oscillates

    % Define joint positions
    joint1 = [0, 0, 0];                      % Base position
    joint2 = joint1 + [0, 0, d1];              % After prismatic joint (along Z-axis)
    joint3 = joint2 + [L1 * cos(theta2),0, abs(L1 * sin(theta2))]; % After first rotational link

    % Nested loop for end-effector rotation around Joint 3's axis
    for phi = linspace(0, 2 * pi, 10) % 20 steps for a full rotation
        % End-effector position with rotation around Joint 3's local axis
        end_effector = joint3 + ...
            [L2 * cos(theta2 + theta3) * cos(phi), ...
             L2 * cos(theta2 + theta3) * sin(phi), ...
             -abs(L2 * sin(theta2 + theta3))];

        % Clear previous plot
        cla;

        % Plot the robotic arm
        plot3([joint1(1), joint2(1), joint3(1), end_effector(1)], ...
              [joint1(2), joint2(2), joint3(2), end_effector(2)], ...
              [joint1(3), joint2(3), joint3(3), end_effector(3)], 'o-', 'LineWidth', 2);

        % Mark joints and end-effector
        scatter3(joint1(1), joint1(2), joint1(3), 100, 'k', 'filled'); % Base
        scatter3(joint2(1), joint2(2), joint2(3), 100, 'b', 'filled'); % Joint 2
        scatter3(joint3(1), joint3(2), joint3(3), 100, 'g', 'filled'); % Joint 3
        scatter3(end_effector(1), end_effector(2), end_effector(3), 150, 'r', 'filled'); % End-effector

        % Pause to create animation effect
        pause(0.01);
    end
end