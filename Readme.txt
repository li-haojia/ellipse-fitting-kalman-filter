compare.m 是比较两种算法的效果的 直接运行这个就行了
KFcore.m 是卡尔曼滤波求椭圆方程 核心算法
lssquare.m 是最小二乘法求解椭圆方程系数 核心算法

plotEllipse.m 是画图的
Matrix2AngleForm.m 是根据椭圆方程系数 计算中心点和长轴短轴的
leastsquare_test.m 是最小二乘法求解椭圆方程测试
KalmanFilter_test.m 是卡尔曼滤波求椭圆方程


问题 ：
当李萨如图成直线的时候（相位相同）没有错误处理，拟合出来的方程不正确（特别是没有噪声时候，有噪声时候还可以拟合一个很小的值）。
