function Convex_edge=Node2Edge(k,Node)
%͹���ĵ㼯��߼�
%kΪ͹���϶����������
% Convex_edge��ÿ��Ԫ��Ϊ[X1,Y1,X2,Y2]  ��ʾһ�����ϵ���������
Convex_edge=[];
n=size(k,1);%����k������

Sorted=[Node(k,1),Node(k,2)];




for i=1:1:n-1
    Convex_edge=[Convex_edge;Sorted(i,:),Sorted(mod(i,n-1)+1,:)];
end