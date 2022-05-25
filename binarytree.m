function binarytree(C,R,layer)
%建立二叉树
%Cx,Cy为圆心，R1，R2为椭圆（圆形）的长短轴
%绘制同心椭圆（包括特殊情况 同心圆）
x0=max(R)/layer;    %最内层的椭圆的横轴x0和纵轴y0, 
y0=min(R)/layer;
Cx=C(1);
Cy=C(2);

for i=layer:-1:1
        t=0:0.001*pi:2*pi;
        x=Cx+i*x0*cos(t);
        y=Cy+i*y0*sin(t);
        [theta,rho]=cart2pol(x,y);
        polarplot(theta,rho,'-k','LineWidth',1);
        hold on;                                                           
end

%绘制将圆环分区的直线
for i=layer:-1:2
    for j=0:1:2^(i-1)-1  %每层需要的分区直线数 2^(i-1) 

        
        t=2*pi*j/(2^(i-1)); %theta为 [2*pi*j/(2^(i-1)),2*pi*j/(2^(i-1))]
        x=[Cx+(i-1)*x0*cos(t),Cx+i*x0*cos(t)];        %确认在这个角度上的椭圆对应的横纵轴，进而求得这个角度上的长度
        y=[Cy+(i-1)*y0*sin(t),Cy+i*y0*sin(t)];
        [theta,rho]=cart2pol(x,y);
        polarplot(theta,rho,'-k','LineWidth',1);
        hold on; 
    end
end

end

