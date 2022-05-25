function [C,R,h] = Envelop(EN)
%求事件节点的包络
%R=[R1;R2] R1,R2为椭圆的长轴和短轴，C=[Cx;Cy]Cx、Cy为椭圆的圆心 , h为图像的句柄

%求外接矩形
[EN_x,EN_y]=pol2cart(EN(1,:),EN(2,:));


%凸包、旋转卡壳、绘制外接矩形
p=rand(length(EN_x),2);
p(:,1)=EN_x;
p(:,2)=EN_y;
ind=convhull(p(:,1),p(:,2));
l=length(ind);

hull=p(ind,:);          %随机点凸包

area=inf;
for i=2:l
    p1=hull(i-1,:);     %凸包上两个点
    p2=hull(i,:);
   
    k1=(p1(2)-p2(2))/(p1(1)-p2(1));     %连接两点的直线，作为矩形的一条边
    b1=p1(2)-k1*p1(1);
   
    d=abs(hull(:,1)*k1-hull(:,2)+b1)/sqrt(k1^2+1);  %所有凸包上的点到k1,b1直线的距离
    
    [hh ind]=max(d);                     %得到距离最大的点距离，即为高，同时得到该点坐标
    b2=hull(ind,2)-k1*hull(ind,1);      %相对k1,b1直线相对的另一条平行边k1,b2;
       
    k2=-1/k1;                           %以求得的直线的垂线斜率
 
    b=hull(:,2)-k2*hull(:,1);           %过凸包所有点构成的k2,b直线系
    x1=-(b1-b)/(k1-k2);                 %凸包上所有点在已求得的第一条边的投影
    y1=-(-b*k1+b1*k2)/(k1-k2);
   
    x2=-(b2-b)/(k1-k2);                 %凸包上所有点在已求得的第二条边的投影
    y2=-(-b*k1+b2*k2)/(k1-k2);
   
    [junk indmax1]=max(x1);             %投影在第一条边上x方向最大与最小值
    [junk indmin1]=min(x1);
                                        
    [junk indmax2]=max(x2);             %投影在第二条边上x方向最大与最小值
    [junk indmin2]=min(x2);
   
    w=sqrt((x1(indmax1)-x1(indmin1))^2+(y1(indmax1)-y1(indmin1))^2);    %矩形的宽

    if area>=hh*w                        %使面积最小
        area=hh*w;
        pbar=[x1(indmax1) y1(indmax1);  %矩形四个角点
              x2(indmax2) y2(indmax2);        
              x2(indmin2) y2(indmin2);
              x1(indmin1) y1(indmin1)];            
    end
end
%pbar(5,:)=pbar(1,:);


Rx=max(hh,w)/2;
Ry=min(hh,w)/2;
R1=sqrt(2)*Rx;R2=sqrt(2)*Ry;
R=[R1;R2];
CL2=CL(pbar);
Cx=CL2(1);
Cy=CL2(2);
C=[Cx;Cy];

% [t,r]=cart2pol(p(:,1),p(:,2));
% polarplot(t,r,'.');hold on;
% [t2,r2]=cart2pol(pbar(:,1),pbar(:,2));
% polarplot(t2,r2,'.');hold on;
% pXmin=min(pbar(:,1));
% pXmax=max(pbar(:,1));
% pYmin=min(pbar(:,2));
% pYmax=max(pbar(:,2));

uu1=[pbar(1,1),pbar(2,1)];vv1=[pbar(1,2),pbar(2,2)];
result1=polyfit(uu1,vv1,1);
a=result1(1);
b=result1(2);
syms xx1 yy1;
xx1=min(uu1):0.01:max(uu1);
yy1=a*xx1+b;

uu2=[pbar(2,1),pbar(3,1)];vv2=[pbar(2,2),pbar(3,2)];
result2=polyfit(uu2,vv2,1);
a=result2(1);
b=result2(2);
syms xx2 yy2;
xx2=min(uu2):0.01:max(uu2);
yy2=a*xx2+b;

uu3=[pbar(3,1),pbar(4,1)];vv3=[pbar(3,2),pbar(4,2)];
result3=polyfit(uu3,vv3,1);
a=result3(1);
b=result3(2);
syms xx3 yy3;
xx3=min(uu3):0.01:max(uu3);
yy3=a*xx3+b;

uu4=[pbar(4,1),pbar(1,1)];vv4=[pbar(4,2),pbar(1,2)];
result4=polyfit(uu4,vv4,1);
a=result4(1);
b=result4(2);
syms xx4 yy4;
xx4=min(uu4):0.01:max(uu4);
yy4=a*xx4+b;

[t1,r1]=cart2pol(xx1,yy1);
[t2,r2]=cart2pol(xx2,yy2);
[t3,r3]=cart2pol(xx3,yy3);
[t4,r4]=cart2pol(xx4,yy4);
h=polarplot(t1,r1,'-y',t2,r2,'-y',t3,r3,'-y',t4,r4,'-y');
hold on

end