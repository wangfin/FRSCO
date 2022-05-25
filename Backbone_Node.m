function   BN=Backbone_Node(Backbone_Cell,cell,layer,center,cover_rate,crange)
%ȷ������Ǹɽڵ�,��������Ǹɽڵ㰴����˳���������
%Backbone_Node�д������Ǹɽڵ�
Backbone_Node=[];
for i=1:1:size(Backbone_Cell,2)
    index=Backbone_Cell(i);
    [A,B,C]=Convex_Restruction(index,cell,layer,center);   %����͹��A��B��C

    E1=[];E2=[];E3=[];    %����͹��A��B��C�ı߼�
    if(~isempty(A))
        DT1 = delaunayTriangulation(A(:,1),A(:,2));   %����A
        C1 = convexHull(DT1);
        E1=Node2Edge(C1,A);
    end
    if(~isempty(B))
        DT2 = delaunayTriangulation(B(:,1),B(:,2));   %����B
        C2 = convexHull(DT2);
        E2=Node2Edge(C2,B);
    end
    E_Union=[E1;E2];    %A��B
    if(~isempty(C))
        DT3 =delaunayTriangulation(C(:,1),C(:,2));   %����C
        C3 = convexHull(DT3);           
        E3=Node2Edge(C3,C);
    end
    if(~isempty(E_Union))    %��A��B����Ԫ�أ�������case4��case5
        Convex=Intersection_convex(E3, E_Union);    %��͹����Ľ��������������򣬱߽���Ѱ����
        Backbone_Node=[Backbone_Node;HI(Convex,cell,index,cover_rate,crange)];
    else
        Backbone_Node=[Backbone_Node;HI(C,cell,index,cover_rate,crange)];  %case4 case5
    end
    
end

%������Ǹɽڵ㰴���ǽ�������
BN=Sort_Node(Backbone_Node,center);
