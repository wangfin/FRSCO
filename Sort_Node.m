function BN_Sorted=Sort_Node(Backbone_Node,C)
%将节点按极角大小进行排序

Cx=C(1);
Cy=C(2);
n=size(Backbone_Node,1);
[BN_theta,BN_rho]=cart2pol(Backbone_Node(:,1),Backbone_Node(:,2)); 
BN=[BN_theta,BN_rho];   %第1列为theta ，第2列为rho，第3列记录极角大小
for i=1:1:n
        k=atan((Backbone_Node(i,2)-Cy)/(Backbone_Node(i,1)-Cx));   %算出斜率
        if(Backbone_Node(i,2)>Cy&&k<0)    %此时点在第二象限，
            k=k+pi;
        elseif(Backbone_Node(i,2)<Cy&&k>0)   %此时点在第三象限
            k=k+pi;
            BN(i,1)=BN(i,1)+2*pi;
        elseif(Backbone_Node(i,2)<Cy && k<0)   %即点在第四象限，防止k为负数
            k=k+2*pi;
            BN(i,1)=BN(i,1)+2*pi;
        end
        BN(i,3)=k;
end
BN_Sorted=sortrows(BN,3);       %按第三列进行排序





 
