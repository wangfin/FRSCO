function BN_Sorted=Sort_Node(Backbone_Node,C)
%���ڵ㰴���Ǵ�С��������

Cx=C(1);
Cy=C(2);
n=size(Backbone_Node,1);
[BN_theta,BN_rho]=cart2pol(Backbone_Node(:,1),Backbone_Node(:,2)); 
BN=[BN_theta,BN_rho];   %��1��Ϊtheta ����2��Ϊrho����3�м�¼���Ǵ�С
for i=1:1:n
        k=atan((Backbone_Node(i,2)-Cy)/(Backbone_Node(i,1)-Cx));   %���б��
        if(Backbone_Node(i,2)>Cy&&k<0)    %��ʱ���ڵڶ����ޣ�
            k=k+pi;
        elseif(Backbone_Node(i,2)<Cy&&k>0)   %��ʱ���ڵ�������
            k=k+pi;
            BN(i,1)=BN(i,1)+2*pi;
        elseif(Backbone_Node(i,2)<Cy && k<0)   %�����ڵ������ޣ���ֹkΪ����
            k=k+2*pi;
            BN(i,1)=BN(i,1)+2*pi;
        end
        BN(i,3)=k;
end
BN_Sorted=sortrows(BN,3);       %�������н�������





 
