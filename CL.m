function  Backbone_Node =  CL(Convex)
%�����ģ�convex����Ϊ͹���Ķ���
x_sum=0;
y_sum=0;

for i=1:1:size(Convex,1)
    x_sum=Convex(i,1)+x_sum;
    y_sum=Convex(i,2)+y_sum;
end
Backbone_Node=[x_sum/size(Convex,1),y_sum/size(Convex,1)];
