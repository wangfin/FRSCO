function [A,B,C]=Convex_Restruction(index,cell,layer,center)

Cx=center(1);
Cy=center(2);
EN=cell(index).element.EN;
nEN=cell(index).element.nEN;
EN_Num=size(EN,1);      %骨干晶胞中事件节点数量
nEN_Num=size(nEN,1);    %骨干晶胞中非事件节点数量

%判断是否共线
if(EN_Num>=3)
    tag_EN=Collinear(EN);
end
if(nEN_Num>=3)
    tag_nEN=Collinear(nEN);
end

%事件节点数和非事件节点数都小于3  case4
%或 EN>=3 nEN>=3 但EN共线，nEN共线  case5

if((EN_Num<3 && nEN_Num<3 && nEN_Num>0)||(EN_Num>=3 &&tag_EN==1 && nEN_Num>=3 && tag_nEN==1 ))
    A=[];B=[];C=[EN;nEN];
    
    %非共线事件节点数大于等于3，非事件节点数小于3   case2
    %非共线事件节点数大于等于3，非事件节点数大于等于3且全共线  case7
elseif((EN_Num>=3 && nEN_Num<3&& tag_EN==0 && nEN_Num>0 ) || ( EN_Num>=3 && tag_EN==0 && nEN_Num>=3 && tag_nEN==1 ) )
    A=EN;B=[];C=[EN;nEN];

    %事件节点数小于3，不共线非事件节点数大于等于3   case3
    %事件节点数大于等于3且全共线，不共线非事件节点数大于等于3   case6
elseif((EN_Num<3 && nEN_Num>=3&&  tag_nEN==0)||( EN_Num>=3 && tag_EN==1 && nEN_Num>=3 &&  tag_nEN==0 ))
    A=[];B=nEN;C=[EN;nEN];
    
    %不共线事件节点数大于等于3，不共线非事件节点数大于等于3  case1
elseif( EN_Num>=3 && tag_EN==0 && nEN_Num>=3 &&  tag_nEN==0 )
    A=EN;B=nEN;C=[EN;nEN];
    
    % nEN==0  case8，选取其晶胞的上边界的中点作为虚拟骨干节点
elseif(nEN_Num==0)
   
    lchild=2*index;
    rchild=2*index+1;
    
    % 如果该晶胞是叶子晶胞
    if(lchild>2^layer-1)
        lbro=index-1;
        rbro=index+1;
        if(cell(lbro).type==0 && cell(rbro).type==0)    %寻找哪一个兄弟晶胞是非事件晶胞
            nEN=[cell(lbro).element.nEN;cell(rho).element.nEN];
            
        elseif(cell(rbro).type==0)
            nEN=cell(rbro).element.nEN;
        elseif(cell(lbro).type==0)
            nEN=cell(lbro).element.nEN;
        else   %左右兄弟晶胞都是事件晶胞，即都为骨干晶胞
            EN=[cell(lbro).element.EN;cell(index).element.EN;cell(rho).element.EN];
            nEN=[cell(lbro).element.nEN;cell(index).element.nEN;cell(rho).element.nEN];
        end
        
    else
        if(cell(lchild).type==0 && cell(rchild).type==0)
            nEN=[cell(lchild).element.nEN;cell(rchild).element.nEN];
        else   %左右子晶胞只有一个为非事件晶胞,则先将该骨干晶胞的中的事件节点分为左右两部分。
            A_L=[];
            A_R=[];
            L=fix(log2(index*2))+1;  %孩子节点所在的L层
            angle=2*pi/2^(L-1);   %该层每个晶胞的角度
            s=lchild-(2^(L-1)-1);   %左孩子节点在该层的第s个晶胞，右孩子在该层的第s+1个晶胞，
            L_Angle=(s-1)*angle;
            M_Angle=s*angle;
            R_Angle=(s+1)*angle;
            for  i=1:1:size(EN,1)
                k=atan((EN(i,2)-Cy)/(EN(i,1)-Cx));
                %改变k值，使k值在0-2*pi之间变换，以便于确定其在哪个角度范围
                if(EN(i,2)>Cy&&k<0)    %此时点在第二象限，
                    k=k+pi;
                elseif(EN(i,2)<Cy&&k>0)   %此时点在第三象限
                    k=k+pi;
                elseif(EN(i,2)<Cy && k<0)   %即点在第四象限，防止k为负数
                    k=k+2*pi;
                end
                %判断该事件节点在左子晶胞范围还是右子晶胞范围
                if(k>=L_Angle&&k<M_Angle)
                    A_L=[A_L;EN(i,:)];
                elseif (k>=M_Angle&&k<R_Angle)
                    A_R=[A_R;EN(i,:)];
                end
            end
            
            %判断哪一个子晶胞是非事件晶胞
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
                else    %如果右半部分无事件节点，则只好左半部分
                    EN=A_L;
                 end
             end
        end
                 
    
    end
    if(size(nEN,1)>3&&Collinear(nEN)==0)   %不共线
        B=nEN;
    else
        B=[];
    end
    if(size(EN,1)>3&&Collinear(EN)==0)   %不共线
        A=EN;
    else
        A=[];
    end
    C=[EN;nEN];

end

