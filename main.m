%
%FRSCO--89-20-22
%
clear all
close all
clf

%在水域部署传感器节点 
%部署区域为半径为30的圆，第一层部署节点单位面积密度为5
%clear SN C CO COx COy EN nEN BN cell VBx VBy X Y;
SN = Deployment_SN(300,9);%300 9 
crange=30;


%流体覆盖并且加边界
%边界上，加入15个噪声大小0.1的噪声，边界大致为半径160的圆
%绘制边界
noise=0.1;
CO = COboundary(15,160,noise);%噪声个数 实际边界半径 noise
h1=polarplot(CO(1,:),CO(2,:),'r-','LineWidth',1.5);%第一行角度，第二行半径
hold on;


%获取事件节点和非事件节点，并绘制
[EN,nEN] = polygon_intersect(CO,SN);
h2=polarplot(EN(1,:),EN(2,:),'r.'); % 绘制 ,'Markersize',9
hold on;
h3=polarplot(nEN(1,:),nEN(2,:),'b.'); % 绘制 ,'Markersize',9
hold on;


%确定椭圆包络，并建立二叉树
layer=6;  %层数自主决定
[C,R,h0] = Envelop(EN);
binarytree(C,R,layer);
delete(h0);

%确定事件晶胞和骨干晶胞，其中cell表示晶胞中各个节点的分布，Backbone_Cell记录骨干晶胞的索引号
cell =  Event_Cell(EN,nEN,layer,C,R);

[cell,Backbone_Cell] =  Backbone_Cell(cell,layer);


%确定虚拟骨干节点
 cover_rate=0.1; %覆盖率
 BN=Backbone_Node(Backbone_Cell,cell,layer,C,cover_rate,crange);%生成边界节点

 VB=Virtual_Boundary(BN,noise);%极坐标
 h4=polarplot(BN(:,1),BN(:,2),'k^','LineWidth', 0.5, 'MarkerSize', 7,'markerFaceColor','g');
 hold on;
 VB_rho=VB(1,:);
 VB_theta=VB(2,:);
 VB_len=length(VB_rho);
 VB_rho(VB_len+1)=VB_rho(1);
 VB_theta(VB_len+1)=VB_theta(1);
 h5=polarplot(VB_rho,VB_theta,'b-','LineWidth',1.5);
 
% legend([h1,h2,h3,h4,h5],'真实边界','事件节点','非事件节点','虚拟骨干节点','流体边界提取');  %标注


