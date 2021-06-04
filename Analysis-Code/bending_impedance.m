function bending_impedance
%This function will take as hard-coded input the matlab-version of the 
%impedance measured during bending that Cami recorded at BMSEED. This function
%will create example plots, summary plots, and summary statistics. Figures 
%to be used in Rowan et al (2020) paper.
%
%
% Updated by TMO 12/21/20

%Data selection
mother = '/Users/tim/Desktop/Acute Recordings/Baseline Noise Recording';
filename = 'bending_radius.mat';

%Load data from file
load([mother, filesep, filename], 'impedance', 'bending_radius');
impedance = impedance;

%Location finding
flat_idx = find(bending_radius == inf);
bent_mask = true(size(bending_radius));
bent_mask(flat_idx) = false;
flat = 140;

%Average over repeats
mean_impedance = squeeze(mean(impedance, 3));
std_impedance = squeeze(std(impedance, 0, 3));

%Layer indices
L1 = 1:2:6;
L2 = 2:2:6;

%Summary accross layers
mean_imped_L1 = mean(mean_impedance(L1, :), 1);
std_imped_L1 = std(mean_impedance(L1, :), 0, 1);
mean_imped_L2 = mean(mean_impedance(L2, :), 1);
std_imped_L2 = std(mean_impedance(L2, :), 0, 1);

% %Plot the change in Impedance
% figure(1); clf
% set(gcf, 'Units', 'Inches', 'Position', [18.5, 13.5, 4.5, 3.5])
% 
% shadedErrorBar(bending_radius(bent_mask), mean_imped_L1(bent_mask), std_imped_L1(bent_mask), ':k', 0.5); hold on
% scatter(bending_radius(bent_mask), mean_imped_L1(bent_mask), 'xk');
% errorbar(flat+2, mean_imped_L1(~bent_mask), std_imped_L1(~bent_mask), 'xk');
% 
% shadedErrorBar(bending_radius(bent_mask), mean_imped_L2(bent_mask), std_imped_L2(bent_mask), '--k', 0.5); hold on
% scatter(bending_radius(bent_mask), mean_imped_L2(bent_mask), 'sk');
% errorbar(flat-2, mean_imped_L2(~bent_mask), std_imped_L2(~bent_mask), 'sk');
% 
% xlim([0, flat+10]); ylim([0, 300])
% set(gca, 'Box', 'off', 'TickDir', 'out', 'XTick', [0:20:120, flat], 'XTickLabels', {'0', '20', '40', '60', '80', '100', '120', 'Flat'}, 'YTick', [0:100:300])
% xlabel('Bend Radius (mm)'); ylabel('Impedance (kW)')


%Next try...
figure(2); clf
set(gcf, 'Units', 'Inches', 'Position', [8, 11, 4.5, 3.5])

for i = 1:numel(L1)
   %Plot L1
   plot(bending_radius(bent_mask), mean_impedance(L1(i),bent_mask), ':k'); hold on
   plot(flat, mean_impedance(L1(i), ~bent_mask),  'xk');
   
   %Plot L2
   plot(bending_radius(bent_mask), mean_impedance(L2(i),bent_mask), '--k'); hold on
   plot(flat, mean_impedance(L2(i), ~bent_mask),  'sk');
      
end
xlim([0, flat+10]); ylim([0, 300])
set(gca, 'Box', 'off', 'TickDir', 'out', 'XTick', [0:20:120, flat], 'XTickLabels', {'0', '20', '40', '60', '80', '100', '120', 'Flat'}, 'YTick', [0:100:300])
xlabel('Bend Radius (mm)'); ylabel('Impedance (kW)')

%Statistical significance
groups = true(1,6); groups(2:2:6) = false;
p = anova1(mean_impedance', groups);

% Source     SS      df     MS       F     Prob>F
% -----------------------------------------------
% Groups     12.59    1   12.5938   0.45   0.5058
% Error    2482.57   88   28.211                 
% Total    2495.16   89                          
