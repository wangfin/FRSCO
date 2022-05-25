function Convex=Intersection_convex(E1,E2)
%��͹���Ľ��������������򣬱߽���Ѱ����

A=setdiff(E1,E2,'rows');
B=setdiff(E2,E1,'rows');
Edge=union(A,B,'rows');    %�ҳ��������ڵ���������

%����������ı߼�תΪ�㼯
Node_Begin=[];
Node_End=[];
for i=1:1:size(Edge,1)
  Node_Begin=[Node_Begin;Edge(i,1),Edge(i,2)];
  Node_End=[Node_End;Edge(i,3),Edge(i,4)];
end

Node_Begin=unique(Node_Begin,'rows');
Node_End=unique(Node_End,'rows');

Convex=union(Node_Begin,Node_End,'rows');




    