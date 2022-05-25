function   BN=Backbone_Node(Backbone_Cell,cell,layer,center,cover_rate,crange)
%确定虚拟骨干节点,并将虚拟骨干节点按极角顺序进行排序
%Backbone_Node中存放虚拟骨干节点
Backbone_Node=[];
for i=1:1:size(Backbone_Cell,2)
    index=Backbone_Cell(i);
    [A,B,C]=Convex_Restruction(index,cell,layer,center);   %构建凸包A，B，C

    E1=[];E2=[];E3=[];    %构建凸包A，B，C的边集
    if(~isempty(A))
        DT1 = delaunayTriangulation(A(:,1),A(:,2));   %集合A
        C1 = convexHull(DT1);
        E1=Node2Edge(C1,A);
    end
    if(~isempty(B))
        DT2 = delaunayTriangulation(B(:,1),B(:,2));   %集合B
        C2 = convexHull(DT2);
        E2=Node2Edge(C2,B);
    end
    E_Union=[E1;E2];    %A∪B
    if(~isempty(C))
        DT3 =delaunayTriangulation(C(:,1),C(:,2));   %集合C
        C3 = convexHull(DT3);           
        E3=Node2Edge(C3,C);
    end
    if(~isempty(E_Union))    %当A或B中有元素，即不是case4，case5
        Convex=Intersection_convex(E3, E_Union);    %求凸包间的交集，即求缝合区域，边界搜寻区域
        Backbone_Node=[Backbone_Node;HI(Convex,cell,index,cover_rate,crange)];
    else
        Backbone_Node=[Backbone_Node;HI(C,cell,index,cover_rate,crange)];  %case4 case5
    end
    
end

%将虚拟骨干节点按极角进行排序
BN=Sort_Node(Backbone_Node,center);
