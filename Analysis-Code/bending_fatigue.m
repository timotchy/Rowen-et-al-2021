function bending_impedance
%This function will take as hard-coded input the matlab-version of the 
%impedance measured during fatigue testing that Cami recorded at BMSEED. This function
%will create example plots, summary plots, and summary statistics. Figures 
%to be used in Rowan et al (2020) paper.
%
%
% Updated by TMO 12/21/20

%Data selection
mother = '/Users/tim/Desktop/Acute Recordings/Baseline Noise Recording';
filename = 'bending_fatigue.mat';

%Load data from file
load([mother, filesep, filename], 'cycles', 'meas_1', 'meas_2');
cycles = cycles;
impedance = cat(3, meas_1, meas_2);
impedance = mean(impedance, 3);

%Layer indices
L1 = 1:2:6;
L2 = 2:2:6;

%Next try...
figure(1); clf
set(gcf, 'Units', 'Inches', 'Position', [8, 11, 4.5, 3.5])

% subplot(2,1,1)
% for i = 1:numel(L1)
%    %Plot L1
%    semilogy(cycles/100000, impedance(L1(i),:), ':k'); hold on
%    %plot(cycles/100000, impedance(L1(i),:), ':k'); hold on
%    
%    %Plot L2
%    semilogy(cycles/100000, impedance(L2(i),:), '--k');
%    %plot(cycles/100000, impedance(L2(i),:), '--k');
%       
% end
% xlim([0, cycles(end)/100000]); %ylim([0, 50])
% set(gca, 'Box', 'off', 'TickDir', 'out', 'XTick', [0, 5.78, 15])% 'YTick', [1e4, 1e8])
% xlabel('100k Cycles'); ylabel('Impedance (k\Omega)')
% 
% subplot(2,1,2)
for i = 1:numel(L1)
   %Plot L1
   plot((cycles(8:end)-cycles(8))/100000, impedance(L1(i),8:end), ':k'); hold on
   
   %Plot L2
   plot((cycles(8:end)-cycles(8))/100000, impedance(L2(i),8:end), '--k');
      
end
xlim([0, (cycles(end)-cycles(8))/100000]); ylim([0, 300])
set(gca, 'Box', 'off', 'TickDir', 'out', 'XTick', 0:2:12, 'YTick', 0:100:300)
xlabel('100k Cycles'); ylabel('Impedance (kW)')

%Statistical significance
groups = true(1,6); groups(2:2:6) = false;
p = anova1(impedance', groups);

% Source       SS        df        MS         F     Prob>F
% --------------------------------------------------------
% Groups   3.00057e+07     1   3.00057e+07   3.68   0.058 
% Error    8.15675e+08   100   8.15675e+06                
% Total    8.45681e+08   101                                                     
