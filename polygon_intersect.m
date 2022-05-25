function [EN,nEN] = polygon_intersect(CO,SN)
%�ú���������¼��ڵ�
%CO_theta��CO_rho Ϊ��ʵ�ı߽��ϵĵ�
%b_x,b_y��ʾ������ˮ���в���Ĵ������ڵ�
%EN_x,EN_y��ʾ�߽��ڵĵ㣬�����帲�ǹ��ĵ�

[CO_x,CO_y]=pol2cart(CO(1,:),CO(2,:));
[SN_x,SN_y]=pol2cart(SN(1,:),SN(2,:));

EN_x = [];
EN_y = [];
nEN_x = [];
nEN_y = [];
for i=1:length(SN_x)
    in=inpolygon(SN_x(i),SN_y(i),CO_x,CO_y);
    %CO_x,CO_yΪ����εı߽磬b_x(i),b_y(i)Ϊ�жϵ��Ƿ��ڶ������
    %����ֵΪ�������ͣ��ڶ�����ڲ��򷵻�1
    
    if in==1
        EN_x = [EN_x SN_x(i)];  
        EN_y = [EN_y SN_y(i)];
    else
        nEN_x = [nEN_x SN_x(i)]; 
        nEN_y = [nEN_y SN_y(i)];
%     else
% 
%         %Ѱ��߽��
%         %��һ���ɻ�Ŀ��Ӧ���ǰѱ߽���ϲ����˴������Ľڵ�ĵ���룬���������ѱ߽�����
%         for j = 1:length(CO_x)
%            dis(j) = sqrt((CO_x(j)-b_x(i))^2+(CO_y(j)-b_y(i))^2);
%            %����ڱ߽�����ĵ������б߽��ľ��룬���ص���һ��������
%            
%         end
%         [val,pos] = min(dis);  
%         %val��ʾdis��������Сֵ��pos��ʾ��Сֵ����Ӧ���кţ�����Ӧ�ı߽���λ��
%             EN_x = [EN_x CO_x(pos)];   %���߽����뷽�̡�
%             EN_y = [EN_y CO_y(pos)];
    end
end

[EN_theta,EN_rho]=cart2pol(EN_x,EN_y);
[nEN_theta,nEN_rho]=cart2pol(nEN_x,nEN_y);
EN=[EN_theta;EN_rho];
nEN=[nEN_theta;nEN_rho];
end