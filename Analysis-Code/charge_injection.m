function charge_injection
%This function will take as hard-coded input the matlab-version of the 
%impedance measured during charge injection testing that Cami recorded at BMSEED. This function
%will create example plots, summary plots, and summary statistics. Figures 
%to be used in Rowan et al (2021) paper.
%
%
% Updated by TMO 5/31/21

%Data selection
mother = '/Users/tim/Desktop/Acute Recordings/Baseline Noise Recording';
filename = 'charge_injection.mat';

%Load data from file
load([mother, filesep, filename], 'pulses', 'impedance');
pulses = pulses';
impedance = impedance';

%Layer indices
L1 = 1:2:4;
L2 = 2:2:4;

%Next try...
figure(1); clf
set(gcf, 'Units', 'Inches', 'Position', [8, 11, 4.5, 3.5])

for i = 1:numel(L1)
   %Plot L1
   plot(1:length(pulses), impedance(L1(i),:), ':k'); hold on
   
   %Plot L2
   plot(1:length(pulses), impedance(L2(i),:), '--k');
      
end
xlim([1, length(pulses)]); ylim([0, 300])
set(gca, 'Box', 'off', 'TickDir', 'out', 'XTick', 1:length(pulses), 'XTickLabels', pulses, 'YTick', 0:100:300, 'XTickLabelRotation', 45)
% gca.xtickangle(45)
xlabel('Pulses'); ylabel('Impedance (k\Omega)')

%Statistical significance
groups = true(1,4); groups(2:2:4) = false;
p = anova1(impedance', groups);

% Source      SS      df     MS      F     Prob>F
% -----------------------------------------------
% Groups     625       1   625      3.26   0.0743
% Error    18815.04   98   191.99                
% Total    19440.04   99                         
