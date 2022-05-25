function SN = Deployment_SN(R,N)
%部署传感器节点
%R为部署区域的半径大小；N表示第一层部署节点的密度，经测试N=7效果较好。
%SN为部署节点的极坐标；

d=R/10;        %每层半径为3 修改
layer=R/d;  %部署区域大概可以分为layer层

SN_theta=[];
SN_rho=[];

for i=1:layer
     n=(2*i-1)*N;   %每一层部署的点数为n  
     rho=d*(i-1)+d*randperm(n)/n;  
     theta=2*pi*randperm(n)/n;
%      rho=3*(i-1)+3*rand(1,n);  
%      theta=2*pi*rand(1,n);
     SN_rho=[SN_rho rho];
     SN_theta=[SN_theta theta];
     
end
%for

SN=[SN_theta;SN_rho];
end %function