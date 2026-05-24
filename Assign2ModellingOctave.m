% =========================================================================
% EMERGENCY DEPARTMENT TRIAGE SIMULATION
% Models Patient Utility, SoftMax Routing, and Health Deterioration
% =========================================================================

% 1. INITIAL SYSTEM STATE & PATIENT DATA
patient_id = 1:10;
S_old = [8.8, 7.5, 6.8, 5.5, 4.8, 4.2, 3.5, 2.8, 1.5, 0.8]; % Initial Severity
unit_names = {'ICU', 'ER', 'Fast Track'};

% Initial waiting times constraint (minutes)
W_ICU_init = 180;
W_ER_init = 90;
W_FT_init = 25;

% 2. UTILITY MODEL (Ui = Beta1*S - Beta2*W)
% Beta1 is unit-specific to prioritize severity correctly. Beta2 is 0.06.
U_ICU = (2.0 .* S_old) - (0.06 * W_ICU_init);
U_ER  = (1.2 .* S_old) - (0.06 * W_ER_init);
U_FT  = (0.2 .* S_old) - (0.06 * W_FT_init);

% 3. SOFTMAX MODEL (Convert Utility to Probability)
exp_ICU = exp(U_ICU);
exp_ER  = exp(U_ER);
exp_FT  = exp(U_FT);
sum_exp = exp_ICU + exp_ER + exp_FT;

P_ICU = exp_ICU ./ sum_exp;
P_ER  = exp_ER  ./ sum_exp;
P_FT  = exp_FT  ./ sum_exp;

% 4. ASSIGNMENT (Find highest probability)
% assign_idx will be 1 for ICU, 2 for ER, 3 for FT
[max_prob, assign_idx] = max([P_ICU; P_ER; P_FT]);

% 5. QUEUE WAITING TIMES (Based on Arrival & Service Rates)
% Assigning the specific queue wait times experienced by the patients
W_assigned = zeros(1, 10);
W_assigned(assign_idx == 1) = 120;  % ICU Congested Wait
W_assigned(assign_idx == 2) = 60;   % ER Standard Wait
W_assigned(assign_idx == 3) = 7.5;  % Fast Track Wait

% 6. DETERIORATION RULE (S_new = S_old + gamma * W)
gamma = 0.02; % Severity points added per minute of waiting
S_new = S_old + (gamma .* W_assigned);

% =========================================================================
% OUTPUT 1: GRAPHICAL POP-OUT DATA TABLE (OCTAVE COMPATIBLE)
% =========================================================================
% Create a new window for the table
f_table = figure('Name', 'Triage Simulation Data Table', 'Position', [100, 100, 800, 300]);

% Define the column names
colNames = {'Patient ID', 'Old Severity', 'P(ICU) %', 'P(ER) %', 'P(FT) %', 'Assigned Unit', 'Wait Time (min)', 'New Severity'};

% Format the data into a cell array so the table can read it
data_cell = cell(10, 8);
for i = 1:10
    % Using sprintf instead of round to prevent Octave version errors
    data_cell{i,1} = sprintf('P%d', patient_id(i));
    data_cell{i,2} = sprintf('%.2f', S_old(i));
    data_cell{i,3} = sprintf('%.2f', P_ICU(i)*100);
    data_cell{i,4} = sprintf('%.2f', P_ER(i)*100);
    data_cell{i,5} = sprintf('%.2f', P_FT(i)*100);
    data_cell{i,6} = unit_names{assign_idx(i)};
    data_cell{i,7} = sprintf('%.1f', W_assigned(i));
    data_cell{i,8} = sprintf('%.2f', S_new(i));
end

% Generate the pop-out table
t = uitable(f_table, 'Data', data_cell, 'ColumnName', colNames, 'Position', [20 20 760 260]);


% =========================================================================
% OUTPUT 2: DATA VISUALIZATION (PLOT) - OCTAVE COMPATIBLE
% =========================================================================
figure('Name', 'Patient Health Deterioration Over Time');

% Create grouped bar chart
bar_data = [S_old', S_new'];
b = bar(patient_id, bar_data, 'grouped');

% Safe color styling for Octave
set(b(1), 'FaceColor', [0.2, 0.6, 0.8]); % Blue for Old Severity
set(b(2), 'FaceColor', [0.9, 0.3, 0.3]); % Red for New Severity

% Add title and labels BEFORE the hold command
title('Patient Health Deterioration Due to Queue Waiting Times', 'FontSize', 14);
xlabel('Patient ID', 'FontSize', 12);
ylabel('Clinical Severity Score (S)', 'FontSize', 12);

% Safe way to draw the threshold line (Replaces yline)
hold on;
plot([0, 11], [8.0, 8.0], '--k', 'LineWidth', 2);
hold off;

% Add legend
legend('Arrival Severity (S_{old})', 'Severity After Waiting (S_{new})', 'Critical Threshold (ESI 1)', 'Location', 'northwest');

% Clean up the axes and grid
set(gca, 'XTick', patient_id);
grid on;
