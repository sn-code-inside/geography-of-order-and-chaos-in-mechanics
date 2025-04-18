% Get file "LSD.mat" holding variable "LSD"
load FMI1_4900.dat; load FMI1_4925.dat; load FMI1_4950.dat; load FMI1_4975.dat;
load FMI1_5000.dat; load FMI1_5025.dat; load FMI1_5050.dat; load FMI1_5075.dat;
load FMI1_5100.dat; load FMI1_5125.dat; load FMI1_5150.dat; load FMI1_5175.dat;
load FMI1_5200.dat; load FMI1_5225.dat; load FMI1_5250.dat; load FMI1_5275.dat;
load FMI1_5300.dat; load FMI1_5325.dat; load FMI1_5350.dat; load FMI1_5375.dat;
load FMI1_5400.dat; load FMI1_5425.dat; load FMI1_5450.dat; load FMI1_5475.dat;
load FMI1_5500.dat; load FMI1_5525.dat; load FMI1_5550.dat; load FMI1_5575.dat;
load FMI1_5600.dat; load FMI1_5625.dat; load FMI1_5650.dat; load FMI1_5675.dat;
load FMI1_5700.dat; load FMI1_5725.dat; load FMI1_5750.dat; load FMI1_5775.dat;
load FMI1_5800.dat; load FMI1_5825.dat; load FMI1_5850.dat; load FMI1_5875.dat;
load FMI1_5900.dat; load FMI1_5925.dat; load FMI1_5950.dat; load FMI1_5975.dat;
load FMI1_6000.dat; load FMI1_6025.dat; load FMI1_6050.dat; load FMI1_6075.dat;
load FMI1_6100.dat; load FMI1_6125.dat; load FMI1_6150.dat; load FMI1_6175.dat;
load FMI1_6200.dat; load FMI1_6225.dat; load FMI1_6250.dat; load FMI1_6275.dat;
load FMI1_6300.dat; load FMI1_6325.dat; load FMI1_6350.dat; load FMI1_6375.dat;
load FMI1_6400.dat; load FMI1_6425.dat; load FMI1_6450.dat; load FMI1_6475.dat;
load FMI1_6500.dat; load FMI1_6525.dat; load FMI1_6550.dat; load FMI1_6575.dat;
load FMI1_6600.dat; load FMI1_6625.dat; load FMI1_6650.dat; load FMI1_6675.dat;
load FMI1_6700.dat; load FMI1_6725.dat; load FMI1_6750.dat; load FMI1_6775.dat;
load FMI1_6800.dat;
%
%
LSD = cat(3, FMI1_4900, FMI1_4925, FMI1_4950, FMI1_4975,...
             FMI1_5000, FMI1_5025, FMI1_5050, FMI1_5075,...
             FMI1_5100, FMI1_5125, FMI1_5150, FMI1_5175,...
             FMI1_5200, FMI1_5225, FMI1_5250, FMI1_5275,...
             FMI1_5300, FMI1_5325, FMI1_5350, FMI1_5375,...
             FMI1_5400, FMI1_5425, FMI1_5450, FMI1_5475,...
             FMI1_5500, FMI1_5525, FMI1_5550, FMI1_5575,...
             FMI1_5600, FMI1_5625, FMI1_5650, FMI1_5675,...
             FMI1_5700, FMI1_5725, FMI1_5750, FMI1_5775,...
             FMI1_5800, FMI1_5825, FMI1_5850, FMI1_5875,...
             FMI1_5900, FMI1_5925, FMI1_5950, FMI1_5975,...
             FMI1_6000, FMI1_6025, FMI1_6050, FMI1_6075,...
             FMI1_6100, FMI1_6125, FMI1_6150, FMI1_6175,...
             FMI1_6200, FMI1_6225, FMI1_6250, FMI1_6275,...             
             FMI1_6300, FMI1_6325, FMI1_6350, FMI1_6375,...
             FMI1_6400, FMI1_6425, FMI1_6450, FMI1_6475,...
             FMI1_6500, FMI1_6525, FMI1_6550, FMI1_6575,...
             FMI1_6600, FMI1_6625, FMI1_6650, FMI1_6675,...
             FMI1_6700, FMI1_6725, FMI1_6750, FMI1_6775,...             
             FMI1_6800);
save('LSD','LSD');