function CO = COboundary(s_no,R,noise)  
%��������߽�,COΪ�߽�ڵ�ļ�����
%s_no ��ʾ�����ĸ�����R��ʾ�߽�İ뾶��noise��ʾ�����Ĵ�С
%˼�룺�ڰ뾶ΪR��Բ�ı߽��ϼ���s_no��������ʹ���γɲ����������߽硣

for i=1:s_no           %���ò�������s_theta��pi��-pi���Ȳ�ݼ�  
    s_theta(i)=pi-2*pi*(i-1)/s_no;
end
s_theta(s_no+1)=-s_theta(1);   %��֤��һ������
% s_rho = normrnd(R,noise*R,[1,s_no]);    %�˴�Ϊ���������  Բ
a=R;b=R+12;   %��Բ
abr=a*b./sqrt(a^2*sin(s_theta).^2+b^2*cos(s_theta).^2);
for i=1:length(abr)
    s_rho(i) = abr(i)-noise*b + 2*noise*b * rand(1,1);
end
%������������ ��ֵΪR,��׼��Ϊnoise*R�� ��̬�ֲ��� ����� ����
%[1,s_no]��ʾ�������������

s_rho(s_no+1)=s_rho(1);
CO_theta=-pi:0.01:pi;

%����������ֵ
%��ֵ������֪��ĳ��������ɵ㺯��ֵ�������ʵ��ĺ���

CO_rho=interp1(s_theta,s_rho,CO_theta,'spline');
% ��s_theta,s_rho����ֵ�㣬CO_rhoΪ����ֵ��CO_theta���Ĳ�ֵ���
%   splineΪ��������������ֵ����


CO=[CO_theta;CO_rho];
end