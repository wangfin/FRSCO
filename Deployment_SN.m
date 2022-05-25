function SN = Deployment_SN(R,N)
%���𴫸����ڵ�
%RΪ��������İ뾶��С��N��ʾ��һ�㲿��ڵ���ܶȣ�������N=7Ч���Ϻá�
%SNΪ����ڵ�ļ����ꣻ

d=R/10;        %ÿ��뾶Ϊ3 �޸�
layer=R/d;  %���������ſ��Է�Ϊlayer��

SN_theta=[];
SN_rho=[];

for i=1:layer
     n=(2*i-1)*N;   %ÿһ�㲿��ĵ���Ϊn  
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