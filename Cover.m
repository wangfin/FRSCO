function circledot = Cover(Convex,cover_rate,r)
%根据覆盖率部署圆，得圆心
circledot=[];
mesh_range=300;
mesh_density=0.5; %0.05;
x=-mesh_range:mesh_density:mesh_range;
[X,Y] = meshgrid(x,x);
x_polygon = Convex(:,1); y_polygon = Convex(:,2);

%plot(x_polygon,y_polygon);hold on
%随机取多变形内的一点作为圆心
in_polygon = inpolygon(X,Y,x_polygon,y_polygon);
[m,n]=find(in_polygon==1);
ind=unidrnd(length(m));
inda=m(ind);indb=n(ind);
oa=X(inda,indb);ob=Y(inda,indb);
circledot=[oa,ob];
%下一步画圆
t=0:0.01:2*pi;
% r=1;
a=r*sin(t)+oa;
b=r*cos(t)+ob;
% plot(a,b);hold on
in_circle = inpolygon(X,Y,a,b);
in_both=in_circle & in_polygon;
Area=sum(sum(in_both))*mesh_density^2;%求相交部分的面积
cover_now=(Area)/(sum(sum(in_polygon))*mesh_density^2);%覆盖率
while cover_now<cover_rate
    ind=unidrnd(length(m));
    inda=m(ind);indb=n(ind);
    oa=X(inda,indb);ob=Y(inda,indb);
    flag=0;
    for i=1:length(circledot(:,1))
        if (oa-circledot(i,1))^2+(ob-circledot(i,2))^2 < 4*r^2
            flag=-1;
            break;
        end
    end
    if flag==0
        circledot=[circledot;oa,ob];
%         r=1;
        a=r*sin(t)+oa;
        b=r*cos(t)+ob;
%         plot(a,b);hold on
        in_circle = inpolygon(X,Y,a,b);
        in_both=in_circle & in_polygon;
        Area=Area+sum(sum(in_both))*mesh_density^2;
        cover_now=(Area)/(sum(sum(in_polygon))*mesh_density^2);
    end
end




end
           