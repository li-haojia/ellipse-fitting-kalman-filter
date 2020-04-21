
function state = lssquare(x, y)
%lssquare :fit the ellipse eqution using Ls-Square method
% input: x 
% input: y 
% output: state 系数
% note: 椭圆方程:state(1)*x^2+state(2)*(x*y)+(1-state(1))*y^2+state(3)*x+state(4)*y+state(5)=0 
%  最小二乘法拟和椭圆
    X=[(x.*x-y.*y); (x.*y); (x);(y); (ones(size(x)))];
    Y=(-y.*y);
    state=pinv(X*X')*X*Y';%这里转置与标准的最小二乘法正好相反，由于XY的格式原因
end

