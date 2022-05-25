function Convex_edge=Node2Edge(k,Node)
%凸包的点集变边集
%k为凸包上顶点的索引号
% Convex_edge的每个元素为[X1,Y1,X2,Y2]  表示一条边上的两个顶点
Convex_edge=[];
n=size(k,1);%返回k的行数

Sorted=[Node(k,1),Node(k,2)];




for i=1:1:n-1
    Convex_edge=[Convex_edge;Sorted(i,:),Sorted(mod(i,n-1)+1,:)];
end