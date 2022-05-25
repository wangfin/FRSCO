function  cell =  Event_Cell(EN,nEN,layer,C,R)
%确定事件晶胞和非事件晶胞,
%cell为结构体，包括type——指定晶胞类型，element.EN——存储晶胞中的事件节点，element.nEN——存储晶胞中的非事件节点
%通过结构体中的type进行确认，0为非事件晶胞；1为事件晶胞；2为骨干晶胞
% cell=zeros(2*layer-1,2);  %共2*layer-1个晶胞
Cx=C(1);
Cy=C(2);
R1=R(1);
R2=R(2);
EN_theta=EN(1,:);
EN_rho=EN(2,:);
nEN_theta=nEN(1,:);
nEN_rho=nEN(2,:);
[EN_x,EN_y]=pol2cart(EN_theta,EN_rho); 
[nEN_x,nEN_y]=pol2cart(nEN_theta,nEN_rho); 

for i=1:1:2^layer-1    %初始化type类型为-1
    cell(i).type=-1;
    cell(i).element.EN=[];
    cell(i).element.nEN=[];
end

%从事件节点开始逐一归类
for s=1:1:size(EN,2)
    point_d=sqrt((EN_x(s)-Cx)^2+(EN_y(s)-Cy)^2);   %该点到圆心的距离
    Elip_x=R1*cos(EN_theta(s))+Cx;      %计算对应的角度在最外层包络上对应的点，并计算该对应点到圆心的距离
    Elip_y=R2*sin(EN_theta(s))+Cy;
    Elip_d=sqrt((Elip_x-Cx)^2+(Elip_y-Cy)^2);    
    j=fix(point_d/(Elip_d/layer))+1;   %计算出该点应该在第j层
    n=2^(j-1);   %n为该层晶胞数量
    theta0=2*pi/n;   % 每个晶胞的角度大小
    
    if(EN_x(s)~=Cx)  %防止角度90，tan无穷的情况
      k=atan((EN_y(s)-Cy)/(EN_x(s)-Cx));   %算出斜率
      if(EN_y(s)>Cy&&k<0)    %此时点在第二象限，
          k=k+pi;
     
      elseif(EN_y(s)<Cy&&k>0)   %此时点在第三象限
          k=k+pi;
      elseif(EN_y(s)<Cy && k<0)   %即点在第四象限，防止k为负数
          k=k+2*pi;
      end
      a=fix(k/theta0);   %第j层的第a+1的晶胞
      cell(2^(j-1)+a).type=1;
      cell(2^(j-1)+a).element.EN=[cell(2^(j-1)+a).element.EN;EN_x(s),EN_y(s)];  %将该事件节点加入晶胞的事件节点集合
      
    end      
end

%处理非事件节点
for t=1:1:size(nEN,2)
    point_d=sqrt((nEN_x(t)-Cx)^2+(nEN_y(t)-Cy)^2);   %该点到圆心的距离
    Elip_x=R1*cos(nEN_theta(t))+Cx;
    Elip_y=R2*sin(nEN_theta(t))+Cy;
    Elip_d=sqrt((Elip_x-Cx)^2+(Elip_y-Cy)^2); 
    j=fix(point_d/(Elip_d/layer));   %计算出该点应该在第j+1层
    j=j+1;     
    if(j>layer)
        continue;
    end
    n=2^(j-1);   %n为该层晶胞数量
    theta0=2*pi/n;   % 每个晶胞的角度大小
    if(nEN_x(t)~=Cx)
      k=atan((nEN_y(t)-Cy)/(nEN_x(t)-Cx));   %算出当前k的角度
      if((nEN_y(t)>Cy && k<0)  ||( nEN_y(t)<Cy&&k>0 ))
          k=k+pi;
      elseif(nEN_y(t) < Cy&&k<0)
          k=k+2*pi;
      end
      a=fix(k/theta0);   %第j层的第a+1的晶胞
      if( cell(2^(j-1)+a).type==-1)
        cell(2^(j-1)+a).type=0;
      end
      cell(2^(j-1)+a).element.nEN=[cell(2^(j-1)+a).element.nEN;nEN_x(t),nEN_y(t)];
      
    end      
end
    
    
    
    


