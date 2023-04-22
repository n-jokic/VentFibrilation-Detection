clear all;
close all;
clc;
% This script changes all interpreters from tex to latex. 

list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));

for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

save = 1;
plot_fig = 1;

Primer2_1('1.txt',1,511, 'direct',16, 64 , plot_fig, save);
Primer2_1('2.txt',1,511, 'direct',16, 64 , plot_fig, save);

%% Zadatak 4

n = 12;
save = 1;
fs = 125;

direct = '.\1ZadatakSnimciEKG\';
k = length(direct) + 1;

VTp_name = [direct 'pt' num2str(n) 'b vt.pa'];
VTb_name = [direct 'pt' num2str(n) 'b vt.bi'];

VFp_name = [direct 'pt' num2str(n) 'a vf.pa'];
VFb_name = [direct 'pt' num2str(n) 'a vf.bi'];

VTp = load(VTp_name)/1000;
N = length(VTp);
VTb = load(VTb_name)/1000;
N = min(length(VTb), N);

VFp = load(VFp_name)/1000;
N = min(length(VFp), N);
VFb = load(VFb_name)/1000;
N = min(length(VFb), N);

fs = 125;
t = (0:N-1) / fs;

figure();
    subplot(2, 1, 1);
    plot(t, VTb(1:N), 'black');
        title(VTb_name(k:end)); 
        xlabel('time [s]'); 
        ylabel('Amplitude [mV]');
        grid('on');
        xlim([min(t), max(t)]);
        ylim([-1.1, 1.1]);
        
    subplot(2, 1, 2);
    plot(t, VTp(1:N), 'black');
        title(VTp_name(k:end)); 
        xlabel('time [s]'); 
        ylabel('Amplitude [mV]');
        grid('on');
        xlim([min(t), max(t)]);
        ylim([-1.1, 1.1]);
        if(save)
            saveas(gcf,['.\izvestaj\slike\VT' num2str(n)],'epsc');
        end
        
figure();
    subplot(2, 1, 1);
    plot(t, VFb(1:N), 'black');
        title(VFb_name(k:end)); 
        xlabel('time [s]'); 
        ylabel('Amplitude [mV]');
        grid('on');
        xlim([min(t), max(t)]);
        ylim([-1.1, 1.1]);
        
    subplot(2, 1, 2);
    plot(t, VFp(1:N), 'black');
        title(VFp_name(k:end)); 
        xlabel('time [s]'); 
        ylabel('Amplitude [mV]');
        grid('on');
        xlim([min(t), max(t)]);
        ylim([-1.1, 1.1]);
        if(save)
            saveas(gcf,['.\izvestaj\slike\VF' num2str(n)],'epsc');
        end
%% Zadatak 5
direct = '.\1ZadatakSnimciEKG\';
k = length(direct) + 1;
save = 0;
plot_fig = 0;
lag = 16;
max_lag = 64;
modes = {'direct', 'hybrid', 'modif_hybrid', 'relative_mag'};
[peak, index, fp, rho, x] = Primer2_1(VTp_name ,1,511, 'direct',lag, max_lag , plot_fig, save);
full_title = {};
fs = 125;
N = length(x);
t= (0:N-1) / fs;
name = {'Direct', 'Hybrid Sign', ' Mod. Hybrid Sign', 'Rel. Magnitude'};

figure();
    subplot(5, 1, [1 2]);
        plot(t, x, 'black');
                title(['Original Data, Interval = ' num2str(N/125) ' seconds, Data File = ' VTp_name(k:end)]); xlabel('Time [s]');
                xlim([min(t) max(t)]); ylabel('Amplitude [mV]'); grid('on');
    
    subplot(5, 1, [4 5]);
    n = lag : max_lag;
    hold on;
    for k = 1 : length(modes)
        [peak, index, fp, rho, x] = Primer2_1(VTp_name ,1,511, modes{k},lag, max_lag , plot_fig, save);
        full_title{k} = ['(' name{k} ')' 'peak = ' num2str(peak) ' at lag ' num2str(index)];
        plot(n, rho);
    end
        title(full_title);
        xlabel('lags'); xlim([min(n), max(n)]); 
        grid('on');
        legend(name,'Location' ,'eastoutside');
        legend boxoff ;
        hold off;
        
        save = 1;
        if(save)
            saveas(gcf,['.\izvestaj\slike\comparison'],'epsc');
        end
        

 %% Zadatak 6

save = 1;
plot_fig = 0;
lag = 16;
max_lag = 64;
modes = {'direct', 'hybrid', 'modif_hybrid', 'relative_mag'};
name = {'Direct', 'Hybrid Sign', ' Mod. Hybrid Sign', 'Rel. Magnitude'};

full_title = {'BI', 'PA'};
legend_names = {'VT', 'VF'};

peakVT = zeros(length(modes), 1);
peakVF = zeros(length(modes), 1);

data = {VTp_name, VFp_name, VTb_name, VFb_name};

for j = 1 : 2
    for k = 1 : length(modes)
        [peak, ~, ~, ~, ~] = Primer2_1(data{j} ,1,511, modes{k},lag, max_lag , plot_fig);
        peakVT(k) = peak;
        [peak, ~, ~, ~, ~] = Primer2_1(data{j+1} ,1,511, modes{k},lag, max_lag , plot_fig);
        peakVF(k) = peak;
    end
    figure();
        plot(1: 4, peakVT, 'blacko');
        hold on;
        plot(1 : 4, peakVF, 'black*');
            legend(legend_names, 'Location','southeast');
            legend boxoff ;
            xlim([0.5, 4.5]);
            grid('on')
            ylim([0, 1]);
            title(full_title{j});
            set(gca,'xtick',[1:4],'xticklabel', name)
            ylabel('Magnitude autocorrelation coeficient');
        if(save)
            saveas(gcf,['.\izvestaj\slike\' full_title{j}],'epsc');
        end
end


    
