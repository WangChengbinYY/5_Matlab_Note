% 常用函数记录
%% 输出显示
    disp('1. IMU数据存储成功！');

%% 矢量运算相关--------------------------------
    % 矢量点乘
        C = dot(A,B);
    % 矢量叉乘
        C = cross(A,B);
    % 矢量求模 归一化
        C = A./norm(A);
        C = normalize(A,'norm',2);      %和上面效果一样
        
        
        
%% 随机数--------------------------------
    a=rand(n)  %n个"均匀分布"随机数字，取值范围默认是(0,1)
    r = randi([10 50],1,5)   %返回 1x5 的"均匀分布"随机数字，取值范围(10,50)
    r = randn(5) % 返回5个正态分布的随机数字
    
    % mxn 个高斯白噪声 功率为power  单位 dBW     
    noise = wgn(m,n,power)
    a=wgn(3*60*200,1,3e-7,'linear');         %  'linear'  表示power代表的是方差
    