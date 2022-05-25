function tag=Collinear(Node)
%判断节点是否共线

tag=1;   %默认共线

%计算线段斜率
if(Node(1,1)~=Node(2,1))  %即不会是垂直于x轴的直线
    k=(Node(1,2)-Node(2,2))/(Node(1,1)-Node(2,1));
    for i=3:1:size(Node,1)
        if( k~=(Node(1,2)-Node(i,2))/(Node(1,1)-Node(i,1)))
            tag=0;    %如果该点与线段斜率不同，则不共线，则结束循环。
            break;
        end
    end
else
    for i=3:1:size(Node,1)
        if(Node(i,1)~=Node(1,1))
            tag=0;
            break;
        end
    end
end

