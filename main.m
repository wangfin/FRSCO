%
%FRSCO--89-20-22
%
clear all
close all
clf

%��ˮ���𴫸����ڵ� 
%��������Ϊ�뾶Ϊ30��Բ����һ�㲿��ڵ㵥λ����ܶ�Ϊ5
%clear SN C CO COx COy EN nEN BN cell VBx VBy X Y;
SN = Deployment_SN(300,9);%300 9 
crange=30;


%���帲�ǲ��Ҽӱ߽�
%�߽��ϣ�����15��������С0.1���������߽����Ϊ�뾶160��Բ
%���Ʊ߽�
noise=0.1;
CO = COboundary(15,160,noise);%�������� ʵ�ʱ߽�뾶 noise
h1=polarplot(CO(1,:),CO(2,:),'r-','LineWidth',1.5);%��һ�нǶȣ��ڶ��а뾶
hold on;


%��ȡ�¼��ڵ�ͷ��¼��ڵ㣬������
[EN,nEN] = polygon_intersect(CO,SN);
h2=polarplot(EN(1,:),EN(2,:),'r.'); % ���� ,'Markersize',9
hold on;
h3=polarplot(nEN(1,:),nEN(2,:),'b.'); % ���� ,'Markersize',9
hold on;


%ȷ����Բ���磬������������
layer=6;  %������������
[C,R,h0] = Envelop(EN);
binarytree(C,R,layer);
delete(h0);

%ȷ���¼������͹Ǹɾ���������cell��ʾ�����и����ڵ�ķֲ���Backbone_Cell��¼�Ǹɾ�����������
cell =  Event_Cell(EN,nEN,layer,C,R);

[cell,Backbone_Cell] =  Backbone_Cell(cell,layer);


%ȷ������Ǹɽڵ�
 cover_rate=0.1; %������
 BN=Backbone_Node(Backbone_Cell,cell,layer,C,cover_rate,crange);%���ɱ߽�ڵ�

 VB=Virtual_Boundary(BN,noise);%������
 h4=polarplot(BN(:,1),BN(:,2),'k^','LineWidth', 0.5, 'MarkerSize', 7,'markerFaceColor','g');
 hold on;
 VB_rho=VB(1,:);
 VB_theta=VB(2,:);
 VB_len=length(VB_rho);
 VB_rho(VB_len+1)=VB_rho(1);
 VB_theta(VB_len+1)=VB_theta(1);
 h5=polarplot(VB_rho,VB_theta,'b-','LineWidth',1.5);
 
% legend([h1,h2,h3,h4,h5],'��ʵ�߽�','�¼��ڵ�','���¼��ڵ�','����Ǹɽڵ�','����߽���ȡ');  %��ע


