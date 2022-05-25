function [A,B,C]=Convex_Restruction(index,cell,layer,center)

Cx=center(1);
Cy=center(2);
EN=cell(index).element.EN;
nEN=cell(index).element.nEN;
EN_Num=size(EN,1);      %�Ǹɾ������¼��ڵ�����
nEN_Num=size(nEN,1);    %�Ǹɾ����з��¼��ڵ�����

%�ж��Ƿ���
if(EN_Num>=3)
    tag_EN=Collinear(EN);
end
if(nEN_Num>=3)
    tag_nEN=Collinear(nEN);
end

%�¼��ڵ����ͷ��¼��ڵ�����С��3  case4
%�� EN>=3 nEN>=3 ��EN���ߣ�nEN����  case5

if((EN_Num<3 && nEN_Num<3 && nEN_Num>0)||(EN_Num>=3 &&tag_EN==1 && nEN_Num>=3 && tag_nEN==1 ))
    A=[];B=[];C=[EN;nEN];
    
    %�ǹ����¼��ڵ������ڵ���3�����¼��ڵ���С��3   case2
    %�ǹ����¼��ڵ������ڵ���3�����¼��ڵ������ڵ���3��ȫ����  case7
elseif((EN_Num>=3 && nEN_Num<3&& tag_EN==0 && nEN_Num>0 ) || ( EN_Num>=3 && tag_EN==0 && nEN_Num>=3 && tag_nEN==1 ) )
    A=EN;B=[];C=[EN;nEN];

    %�¼��ڵ���С��3�������߷��¼��ڵ������ڵ���3   case3
    %�¼��ڵ������ڵ���3��ȫ���ߣ������߷��¼��ڵ������ڵ���3   case6
elseif((EN_Num<3 && nEN_Num>=3&&  tag_nEN==0)||( EN_Num>=3 && tag_EN==1 && nEN_Num>=3 &&  tag_nEN==0 ))
    A=[];B=nEN;C=[EN;nEN];
    
    %�������¼��ڵ������ڵ���3�������߷��¼��ڵ������ڵ���3  case1
elseif( EN_Num>=3 && tag_EN==0 && nEN_Num>=3 &&  tag_nEN==0 )
    A=EN;B=nEN;C=[EN;nEN];
    
    % nEN==0  case8��ѡȡ�侧�����ϱ߽���е���Ϊ����Ǹɽڵ�
elseif(nEN_Num==0)
   
    lchild=2*index;
    rchild=2*index+1;
    
    % ����þ�����Ҷ�Ӿ���
    if(lchild>2^layer-1)
        lbro=index-1;
        rbro=index+1;
        if(cell(lbro).type==0 && cell(rbro).type==0)    %Ѱ����һ���ֵܾ����Ƿ��¼�����
            nEN=[cell(lbro).element.nEN;cell(rho).element.nEN];
            
        elseif(cell(rbro).type==0)
            nEN=cell(rbro).element.nEN;
        elseif(cell(lbro).type==0)
            nEN=cell(lbro).element.nEN;
        else   %�����ֵܾ��������¼�����������Ϊ�Ǹɾ���
            EN=[cell(lbro).element.EN;cell(index).element.EN;cell(rho).element.EN];
            nEN=[cell(lbro).element.nEN;cell(index).element.nEN;cell(rho).element.nEN];
        end
        
    else
        if(cell(lchild).type==0 && cell(rchild).type==0)
            nEN=[cell(lchild).element.nEN;cell(rchild).element.nEN];
        else   %�����Ӿ���ֻ��һ��Ϊ���¼�����,���Ƚ��ùǸɾ������е��¼��ڵ��Ϊ���������֡�
            A_L=[];
            A_R=[];
            L=fix(log2(index*2))+1;  %���ӽڵ����ڵ�L��
            angle=2*pi/2^(L-1);   %�ò�ÿ�������ĽǶ�
            s=lchild-(2^(L-1)-1);   %���ӽڵ��ڸò�ĵ�s���������Һ����ڸò�ĵ�s+1��������
            L_Angle=(s-1)*angle;
            M_Angle=s*angle;
            R_Angle=(s+1)*angle;
            for  i=1:1:size(EN,1)
                k=atan((EN(i,2)-Cy)/(EN(i,1)-Cx));
                %�ı�kֵ��ʹkֵ��0-2*pi֮��任���Ա���ȷ�������ĸ��Ƕȷ�Χ
                if(EN(i,2)>Cy&&k<0)    %��ʱ���ڵڶ����ޣ�
                    k=k+pi;
                elseif(EN(i,2)<Cy&&k>0)   %��ʱ���ڵ�������
                    k=k+pi;
                elseif(EN(i,2)<Cy && k<0)   %�����ڵ������ޣ���ֹkΪ����
                    k=k+2*pi;
                end
                %�жϸ��¼��ڵ������Ӿ�����Χ�������Ӿ�����Χ
                if(k>=L_Angle&&k<M_Angle)
                    A_L=[A_L;EN(i,:)];
                elseif (k>=M_Angle&&k<R_Angle)
                    A_R=[A_R;EN(i,:)];
                end
            end
            
            %�ж���һ���Ӿ����Ƿ��¼�����
            if(cell(lchild).type==0 )
                nEN=cell(lchild).element.nEN;
                if(~isempty(A_L))
                    EN=A_L;
                else
                    EN=A_R;
                end
            elseif(cell(rchild).type==0)
                nEN=cell(rchild).element.nEN;
                if(~isempty(A_R))
                    EN=A_R;
                else    %����Ұ벿�����¼��ڵ㣬��ֻ����벿��
                    EN=A_L;
                 end
             end
        end
                 
    
    end
    if(size(nEN,1)>3&&Collinear(nEN)==0)   %������
        B=nEN;
    else
        B=[];
    end
    if(size(EN,1)>3&&Collinear(EN)==0)   %������
        A=EN;
    else
        A=[];
    end
    C=[EN;nEN];

end

