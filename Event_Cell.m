function  cell =  Event_Cell(EN,nEN,layer,C,R)
%ȷ���¼������ͷ��¼�����,
%cellΪ�ṹ�壬����type����ָ���������ͣ�element.EN�����洢�����е��¼��ڵ㣬element.nEN�����洢�����еķ��¼��ڵ�
%ͨ���ṹ���е�type����ȷ�ϣ�0Ϊ���¼�������1Ϊ�¼�������2Ϊ�Ǹɾ���
% cell=zeros(2*layer-1,2);  %��2*layer-1������
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

for i=1:1:2^layer-1    %��ʼ��type����Ϊ-1
    cell(i).type=-1;
    cell(i).element.EN=[];
    cell(i).element.nEN=[];
end

%���¼��ڵ㿪ʼ��һ����
for s=1:1:size(EN,2)
    point_d=sqrt((EN_x(s)-Cx)^2+(EN_y(s)-Cy)^2);   %�õ㵽Բ�ĵľ���
    Elip_x=R1*cos(EN_theta(s))+Cx;      %�����Ӧ�ĽǶ������������϶�Ӧ�ĵ㣬������ö�Ӧ�㵽Բ�ĵľ���
    Elip_y=R2*sin(EN_theta(s))+Cy;
    Elip_d=sqrt((Elip_x-Cx)^2+(Elip_y-Cy)^2);    
    j=fix(point_d/(Elip_d/layer))+1;   %������õ�Ӧ���ڵ�j��
    n=2^(j-1);   %nΪ�ò㾧������
    theta0=2*pi/n;   % ÿ�������ĽǶȴ�С
    
    if(EN_x(s)~=Cx)  %��ֹ�Ƕ�90��tan��������
      k=atan((EN_y(s)-Cy)/(EN_x(s)-Cx));   %���б��
      if(EN_y(s)>Cy&&k<0)    %��ʱ���ڵڶ����ޣ�
          k=k+pi;
     
      elseif(EN_y(s)<Cy&&k>0)   %��ʱ���ڵ�������
          k=k+pi;
      elseif(EN_y(s)<Cy && k<0)   %�����ڵ������ޣ���ֹkΪ����
          k=k+2*pi;
      end
      a=fix(k/theta0);   %��j��ĵ�a+1�ľ���
      cell(2^(j-1)+a).type=1;
      cell(2^(j-1)+a).element.EN=[cell(2^(j-1)+a).element.EN;EN_x(s),EN_y(s)];  %�����¼��ڵ���뾧�����¼��ڵ㼯��
      
    end      
end

%������¼��ڵ�
for t=1:1:size(nEN,2)
    point_d=sqrt((nEN_x(t)-Cx)^2+(nEN_y(t)-Cy)^2);   %�õ㵽Բ�ĵľ���
    Elip_x=R1*cos(nEN_theta(t))+Cx;
    Elip_y=R2*sin(nEN_theta(t))+Cy;
    Elip_d=sqrt((Elip_x-Cx)^2+(Elip_y-Cy)^2); 
    j=fix(point_d/(Elip_d/layer));   %������õ�Ӧ���ڵ�j+1��
    j=j+1;     
    if(j>layer)
        continue;
    end
    n=2^(j-1);   %nΪ�ò㾧������
    theta0=2*pi/n;   % ÿ�������ĽǶȴ�С
    if(nEN_x(t)~=Cx)
      k=atan((nEN_y(t)-Cy)/(nEN_x(t)-Cx));   %�����ǰk�ĽǶ�
      if((nEN_y(t)>Cy && k<0)  ||( nEN_y(t)<Cy&&k>0 ))
          k=k+pi;
      elseif(nEN_y(t) < Cy&&k<0)
          k=k+2*pi;
      end
      a=fix(k/theta0);   %��j��ĵ�a+1�ľ���
      if( cell(2^(j-1)+a).type==-1)
        cell(2^(j-1)+a).type=0;
      end
      cell(2^(j-1)+a).element.nEN=[cell(2^(j-1)+a).element.nEN;nEN_x(t),nEN_y(t)];
      
    end      
end
    
    
    
    


