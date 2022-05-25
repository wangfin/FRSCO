function Convex=Intersection_convex(E1,E2)
%求凸包的交集，即求缝合区域，边界搜寻区域

A=setdiff(E1,E2,'rows');
B=setdiff(E2,E1,'rows');
Edge=union(A,B,'rows');    %找出质心所在的搜索区域

%将搜索区域的边集转为点集
Node_Begin=[];
Node_End=[];
for i=1:1:size(Edge,1)
  Node_Begin=[Node_Begin;Edge(i,1),Edge(i,2)];
  Node_End=[Node_End;Edge(i,3),Edge(i,4)];
end

Node_Begin=unique(Node_Begin,'rows');
Node_End=unique(Node_End,'rows');

Convex=union(Node_Begin,Node_End,'rows');




    