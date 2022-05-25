function VB=Virtual_Boundary(BN,noise)
%提取流体边界，Sorted_Node为已经排序好的虚拟骨干节点,第一列为x，第二列为y
%分为上半部分，和下半部分，分别拟合出一个半环，加起来形成一整个环
n=size(BN,1);
middle=fix(n/4);%分4部分拟合
BN_theta1=BN(1:middle,1);
BN_rho1=BN(1:middle,2);
BN_theta2=BN(middle:middle*2,1);
BN_rho2=BN(middle:middle*2,2);
BN_theta3=BN(middle*2:middle*3,1);
BN_rho3=BN(middle*2:middle*3,2);
BN_theta4=[BN(middle*3:n,1);BN(1,1)+2*pi];
BN_rho4=[BN(middle*3:n,2);BN(1,2)];

% coefficient1=polyfit(BN_theta1,BN_rho1,3);  %用一次函数拟合曲线，想用几次函数拟合，就把n设成那个数
% y1=polyval(coefficient1,BN_theta1);
% coefficient2=polyfit(BN_theta2,BN_rho2,3);  %用一次函数拟合曲线，想用几次函数拟合，就把n设成那个数
% y2=polyval(coefficient2,BN_theta2);
% VB=[BN_theta1,BN_theta2;y1,y2];
%原
theta_middle1=BN(middle,1);
theta_middle2=BN(middle*2,1);
theta_middle3=BN(middle*3,1);
theta_first=BN(1,1);
VB_theta1=theta_first:0.1:theta_middle1;
VB_theta2=theta_middle1:0.1:theta_middle2;
VB_theta3=theta_middle2:0.1:theta_middle3;
VB_theta4=theta_middle3:0.1:theta_first+2*pi;

VB_rho1=polyfit(BN_theta1,BN_rho1,3);
y1=polyval(VB_rho1,VB_theta1);
VB_rho2=polyfit(BN_theta2,BN_rho2,3);
y2=polyval(VB_rho2,VB_theta2);
VB_rho3=polyfit(BN_theta3,BN_rho3,3);
y3=polyval(VB_rho3,VB_theta3);
VB_rho4=polyfit(BN_theta4,BN_rho4,3);
y4=polyval(VB_rho4,VB_theta4);
VB=[VB_theta1,VB_theta2,VB_theta3,VB_theta4;y1,y2,y3,y4];


% VB_rho1=polyfit(BN_theta1,BN_rho1,3);
% y2=polyval(VB_rho1,VB_theta1);
% VB_rho2=polyfit(BN_theta1,BN_rho1,3);
% y3=polyval(VB_rho2,VB_theta2);
% VB=[VB_theta1,VB_theta2;y2,y3];
% VB;
% VB_rho1 = normrnd(BN_rho1(1,1),noise*BN_rho1(1,1),[1,length(VB_theta1)]);
% VB_rho2 = normrnd(BN_rho2(1,1),noise*BN_rho2(1,1),[1,length(VB_theta2)]);

% VB_rho1=interp1(BN_theta1,BN_rho1,VB_theta1,'spline');
% VB_rho2=interp1(BN_theta2,BN_rho2,VB_theta2,'spline');
% 
% 
% VB=[VB_theta1,VB_theta2;VB_rho1,VB_rho2];
end
