%%----------------------频谱分析
    % 信号产生
    y=gyrox(1:1024);
    Fs = 200;   % 采样频率
    L = length(y);
    Y=fft(y);       %傅里叶变换
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;         
    figure;
    plot(f,P1); 
    title('Single-Sided Amplitude Spectrum of y(t)');
    xlabel('f (Hz)');
    ylabel('|P1(f)|');
    
    
%% -------------------功率谱计算
%按照200Hz采样，仿真1小时白噪声，方差为3e-6
X = wgn(740000,1,3e-6,'linear');         %  'linear'  表示power代表的是方差

X=z;
fs = 100; %采样频率
N = length(X); %采样点数
t = [0:N-1]*1/fs;  
xn = X(1:N); % 直流+周期信号+白噪声
figure;
subplot(121), plot(t,xn); grid, xlabel('t / s'); ylabel('x(t)');
% 直接法求功率谱(周期图法)
Xk = fft(xn,N);
S1 = abs(Xk).^2/N/fs;  S1(2:end) = S1(2:end)*2; % 计算单边功率谱
subplot(122), hold off, 
N2 = floor(N/2);
semilogy([0:N2-1]*fs/N, S1(1:N2)); grid, xlabel('f / Hz'); ylabel('PSD');

%依据功率谱密度进行方差计算
Sigma2 = mean(S1(2:end))*fs/2
var(X)
    