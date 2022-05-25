function binarytree(C,R,layer)
%����������
%Cx,CyΪԲ�ģ�R1��R2Ϊ��Բ��Բ�Σ��ĳ�����
%����ͬ����Բ������������� ͬ��Բ��
x0=max(R)/layer;    %���ڲ����Բ�ĺ���x0������y0, 
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

%���ƽ�Բ��������ֱ��
for i=layer:-1:2
    for j=0:1:2^(i-1)-1  %ÿ����Ҫ�ķ���ֱ���� 2^(i-1) 

        
        t=2*pi*j/(2^(i-1)); %thetaΪ [2*pi*j/(2^(i-1)),2*pi*j/(2^(i-1))]
        x=[Cx+(i-1)*x0*cos(t),Cx+i*x0*cos(t)];        %ȷ��������Ƕ��ϵ���Բ��Ӧ�ĺ����ᣬ�����������Ƕ��ϵĳ���
        y=[Cy+(i-1)*y0*sin(t),Cy+i*y0*sin(t)];
        [theta,rho]=cart2pol(x,y);
        polarplot(theta,rho,'-k','LineWidth',1);
        hold on; 
    end
end

end

