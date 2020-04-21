%% singal phase calculate by KF
% Note:
% We draw the Lissajous figure of the same frequency signals.
% Then, fit the ellipse eqution and we can know the phase-difference
% through the eqution.
% 同频信号相位计算，先将信号采样，再将信号绘制成李萨如图
% 拟合图形方程，根据方程求相位差。
%
% Author:Li haojia
% DATE   2020.4.21


%generate and simple singal  采样信号
f=10; w=2*pi*f; %Frequency 
phase = pi/2;
s_t=[0:0.001:0.2];
SIGMA=0.01;
noisy=normrnd(0,SIGMA,[1,length(s_t)]);
s_x=sin(w*s_t);
s_y=sin(w*s_t+phase)+noisy;

state=[0,0,0,0,0]'; %initial ellipse coefficients 初始化系数
p_state=[
    1,0,0,0,0;
    0,1,0,0,0;
    0,0,1,0,0;
    0,0,0,1,0;
    0,0,0,0,1;];%initial covariance 初始化协方差系数一般不用改

for i=1:length(s_t)
    %sample 模拟信号采样
    t=s_t(1:i);
    x=s_x(1:i);
    y=s_y(1:i);
    %draw figure 画图
    subplot(3,2,1);
    plot(t,x);
    subplot(3,2,3);
    plot(t,y);
    subplot(3,2,5)
    plot(t,noisy(1:i))
    subplot(1,2,2);
    %KF 卡尔曼滤波
    [state,p_state]=KFcore(state,p_state,[x(i),y(i)]);
    A=state(1);B=state(2);C=1-state(1);D=state(3);E=state(4);F=state(5);  %ellipse coefficients 椭圆系数
    
    %Draw figure 
    [Xc,Yc,a,b,angle] = Matrix2AngleForm(state(1),state(2),1-state(1),state(3),state(4),state(5));
    plotEllipse(Xc, Yc, a, b, rad2deg(angle), 360,'Color','green','LineWidth',1);
    hold on
    plot(x,y,'.','MarkerSize',5,'Color','red');
    hold off
    drawnow;
end


%

