function [EN,nEN] = polygon_intersect(CO,SN)
%该函数是求得事件节点
%CO_theta和CO_rho 为真实的边界上的点
%b_x,b_y表示在整个水域中部署的传感器节点
%EN_x,EN_y表示边界内的点，即流体覆盖过的点

[CO_x,CO_y]=pol2cart(CO(1,:),CO(2,:));
[SN_x,SN_y]=pol2cart(SN(1,:),SN(2,:));

EN_x = [];
EN_y = [];
nEN_x = [];
nEN_y = [];
for i=1:length(SN_x)
    in=inpolygon(SN_x(i),SN_y(i),CO_x,CO_y);
    %CO_x,CO_y为多边形的边界，b_x(i),b_y(i)为判断点是否在多边形内
    %返回值为布尔类型，在多边形内部则返回1
    
    if in==1
        EN_x = [EN_x SN_x(i)];  
        EN_y = [EN_y SN_y(i)];
    else
        nEN_x = [nEN_x SN_x(i)]; 
        nEN_y = [nEN_y SN_y(i)];
%     else
% 
%         %寻求边界点
%         %有一点疑惑，目的应该是把边界点上部署了传感器的节点的点加入，而不是随便把边界点加入
%         for j = 1:length(CO_x)
%            dis(j) = sqrt((CO_x(j)-b_x(i))^2+(CO_y(j)-b_y(i))^2);
%            %求解在边界以外的点与所有边界点的距离，返回的是一个列向量
%            
%         end
%         [val,pos] = min(dis);  
%         %val表示dis向量的最小值，pos表示最小值所对应的行号，即对应的边界点的位置
%             EN_x = [EN_x CO_x(pos)];   %将边界点加入方程。
%             EN_y = [EN_y CO_y(pos)];
    end
end

[EN_theta,EN_rho]=cart2pol(EN_x,EN_y);
[nEN_theta,nEN_rho]=cart2pol(nEN_x,nEN_y);
EN=[EN_theta;EN_rho];
nEN=[nEN_theta;nEN_rho];
end