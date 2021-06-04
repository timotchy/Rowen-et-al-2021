function pre_post_plating_EIS
%This function will take as hard-coded input the matlab-version of the EIS
%from the uPNI that Cami recorded at BMSEED. This function
%will create example plots, summary plots, and summary statistics. Figures 
%to be used in Rowan et al (2020) paper.
%
%
% Updated by TMO 11/15/20

%Data selection
mother = '/Users/tim/Desktop/Acute Recordings/Baseline Noise Recording';
pre_file = 'pre_plating_EIS.mat';
post_file = 'post_plating_EIS.mat';

%Load data from file
load([mother, filesep, pre_file], 'impedance', 'phase', 'frequency');
pre_impedance = impedance * 10^3;
pre_phase = phase;

load([mother, filesep, post_file], 'impedance', 'phase', 'frequency');
post_impedance = impedance * 10^3;
post_phase = phase;

clear('impedance', 'phase')

%Layer indices
L1 = 1:2:6;
L2 = 2:2:6;


%Plot the change in RMS
figure(1); clf
set(gcf, 'Units', 'Inches', 'Position', [10, 10.5, 4.5, 8])

subplot(2, 1, 1)
loglog(frequency, mean(pre_impedance(L1, :)), ':k', frequency, mean(pre_impedance(L2, :)), '--k', 'LineWidth', 3); hold on
loglog(frequency, pre_impedance(L1, :), ':k', frequency, pre_impedance(L2, :), '--k', 'LineWidth', 1);
loglog(frequency, mean(post_impedance(L1, :)), ':r', frequency, mean(post_impedance(L2, :)), '--r', 'LineWidth', 3);
loglog(frequency, post_impedance(L1, :), ':r', frequency, post_impedance(L2, :), '--r', 'LineWidth', 1); 

xlim([5*10^1, 2*10^4])
ylim([5*10^3, 10^6])
set(gca, 'Box', 'off', 'TickDir', 'out')%, 'XTick', [1, 2], 'XTickLabels', {'Pre', 'Post'}, 'YTick', [0, 15])
xlabel('Frequency (Hz)'); ylabel('Impedance (W)')


subplot(2, 1, 2)
semilogx(frequency, mean(pre_phase(L1, :)), ':k', frequency, mean(pre_phase(L2, :)), '--k', 'LineWidth', 3); hold on
loglog(frequency, pre_phase(L1, :), ':k', frequency, pre_phase(L2, :), '--k', 'LineWidth', 1);
semilogx(frequency, mean(post_phase(L1, :)), ':r', frequency, mean(post_phase(L2, :)), '--r', 'LineWidth', 3);
loglog(frequency, post_phase(L1, :), ':r', frequency, post_phase(L2, :), '--r', 'LineWidth', 1); 

xlim([5*10^1, 2*10^4])
ylim([-90, 0])
set(gca, 'Box', 'off', 'TickDir', 'out', 'YTick', [-90, -45, 0])
xlabel('Frequency (Hz)'); ylabel('Phase (W)')

