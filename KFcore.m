function [new_state,new_p] = KFcore(last_state,last_p,new_observation)
%KFcore use Kalman filter to sovle ellipse coefficient
% useage: 
% input: last_state 上一次计算的系数
% input: last_p 上一次的协方差矩阵
% input: new_observation 新的测量值，就是李萨如图新增的点
% output: new_state 新的系数
% output: new_p 新的协方差矩阵
% note: 椭圆方程:state(1)*x^2+state(2)*(x*y)+(1-state(1))*y^2+state(3)*x+state(4)*y+state(5)=0 
% 这是一个标准的卡尔曼滤波器，论文中的说法有误，这个不是扩展卡尔曼滤波，但是的确经过了线性化。

sigma_o=1e-4;      %observation model convariance  测量模型协方差
sigma_w=1e-10*eye(5);  %prediction model convariance   预测模型协方差  给成0也行 

state=last_state;  

p= last_p+sigma_w;
x=new_observation(1);y=new_observation(2);  %new data. It is not KF observation.这里笔试卡尔曼滤波器的观测
Z_obs=-y^2;                                 %This is the KF observation    这个才是卡尔曼滤波器的观测

H=[x*x-y*y,x*y,x,y,1];
Z_hat=H*state;
%%论文中的协方差计算方法，用不用没啥区别，但是我觉得他的推导不正确
%A=state(1);B=state(2);C=1-state(1);D=state(3);E=state(4);F=state(5);  %ellipse coefficients 椭圆系数
%Q=sigma_o*((2*A*x+B*y+D)^2+(2*C*y+B*x+E)^2);

Q=sigma_o;
K=p*(H')/(H*p*(H')+Q); % K coefficient 观测值的修正系数

new_state=state+K*(Z_obs-Z_hat);
new_p=(eye(5)-K*H)*p;


end

