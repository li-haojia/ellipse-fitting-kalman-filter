%% singal phase calculate compare two method
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
s_t=(0:0.001:0.1);
SIGMA=0.04;
noisy=normrnd(0,SIGMA,[1,length(s_t)])+0.1*sin(10*w*s_t);%噪声
s_x=sin(w*s_t)+1;
s_y=sin(w*s_t+phase)+noisy;

state=[0,0,0,0,0]';
p_state=[
    0.1,0,0,0,0;
    0,0.1,0,0,0;
    0,0,0.1,0,0;
    0,0,0,0.1,0;
    0,0,0,0,0.1;];

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
  % KF    
    [state,p_state]=KFcore(state,p_state,[x(i),y(i)]);
  %least square method 最小二乘法
    state2=lssquare(x,y);
    %equ:p(1)*x^2+p(2)*(x*y)+(1-p(1))*y^2+p(3)*x+p(4)*y+p(5)=0
   
    
    %Draw figure 
    [Xc,Yc,a,b,angle] = Matrix2AngleForm(state2(1),state2(2),1-state2(1),state2(3),state2(4),state2(5));
    plotEllipse(Xc, Yc, a, b, rad2deg(angle), 360,'Color','blue','LineWidth',1);
    [Xc,Yc,a,b,angle] = Matrix2AngleForm(state(1),state(2),1-state(1),state(3),state(4),state(5));
    hold on
    plotEllipse(Xc, Yc, a, b, rad2deg(angle), 360,'Color','green','LineWidth',1);
    plot(x,y,'.','MarkerSize',5,'Color','red');
    legend('LS-SQUARE','KF','Data');
    hold off

    drawnow;
end


%

