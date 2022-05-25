function CO = COboundary(s_no,R,noise)  
%绘制流体边界,CO为边界节点的极坐标
%s_no 表示噪声的个数，R表示边界的半径，noise表示噪声的大小
%思想：在半径为R的圆的边界上加上s_no个噪声，使其形成不规则的流体边界。

for i=1:s_no           %设置采样极角s_theta从pi到-pi，等差递减  
    s_theta(i)=pi-2*pi*(i-1)/s_no;
end
s_theta(s_no+1)=-s_theta(1);   %保证是一个环形
% s_rho = normrnd(R,noise*R,[1,s_no]);    %此处为噪声的添加  圆
a=R;b=R+12;   %椭圆
abr=a*b./sqrt(a^2*sin(s_theta).^2+b^2*cos(s_theta).^2);
for i=1:length(abr)
    s_rho(i) = abr(i)-noise*b + 2*noise*b * rand(1,1);
end
%采样极径符合 均值为R,标准差为noise*R的 正态分布的 随机数 矩阵
%[1,s_no]表示矩阵的行与列数

s_rho(s_no+1)=s_rho(1);
CO_theta=-pi:0.01:pi;

%二次样条插值
%插值法：已知在某区间的若干点函数值，作出适当的函数

CO_rho=interp1(s_theta,s_rho,CO_theta,'spline');
% （s_theta,s_rho）插值点，CO_rho为被插值点CO_theta处的插值结果
%   spline为采用三次样条插值方法


CO=[CO_theta;CO_rho];
end