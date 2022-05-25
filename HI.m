function  Backbone_Node =  HI(Convex,cell,index,cover,crange)
%求边界节点，convex变量为凸包的顶点  信息熵补偿的边界节点

EN_x = [];
EN_y = [];
nEN_x = [];
nEN_y = [];

EN_x=[EN_x;cell(index).element.EN(:,1)];
EN_y=[EN_y;cell(index).element.EN(:,2)];
% if index-1 >= 1
%     EN_x=[EN_x;cell(index-1).element.EN(:,1)];
%     EN_y=[EN_y;cell(index-1).element.EN(:,2)];
% end
if index+1<=size(cell,1)
    EN_x=[EN_x;cell(index+1).element.EN(:,1)];
    EN_y=[EN_y;cell(index+1).element.EN(:,2)];
end
if index*2<=size(cell,1)
    EN_x=[EN_x;cell(index*2).element.EN(:,1)];
    EN_y=[EN_y;cell(index*2).element.EN(:,2)];
end
if (index*2+1)<=size(cell,1)
    EN_x=[EN_x;cell(index*2+1).element.EN(:,1)];
    EN_y=[EN_y;cell(index*2+1).element.EN(:,2)];
end

if (~isempty(cell(index).element.nEN))
    nEN_x=[nEN_x;cell(index).element.nEN(:,1)];
    nEN_y=[nEN_y;cell(index).element.nEN(:,2)];
end
% nEN_x=[nEN_x;cell(index).element.nEN(:,1)];
% nEN_y=[nEN_y;cell(index).element.nEN(:,2)];
if index+1<=size(cell,1)
    nEN_x=[nEN_x;cell(index+1).element.nEN(:,1)];
    nEN_y=[nEN_y;cell(index+1).element.nEN(:,2)];
end
if index*2<=size(cell,1)
    nEN_x=[nEN_x;cell(index*2).element.nEN(:,1)];
    nEN_y=[nEN_y;cell(index*2).element.nEN(:,2)];
end
if (index*2+1)<=size(cell,1)
    nEN_x=[nEN_x;cell(index*2+1).element.nEN(:,1)];
    nEN_y=[nEN_y;cell(index*2+1).element.nEN(:,2)];
end
x_sum=0;
y_sum=0;
Backbone_Node=[];
for i=1:1:size(Convex,1)
    x_sum=Convex(i,1)+x_sum;
    y_sum=Convex(i,2)+y_sum;
end


% zhi=[x_sum/size(Convex,1),y_sum/size(Convex,1)];%求质心
% 
% %求虚拟补偿边界节点
circledot=Cover(Convex,cover,crange);
for i=1:length(circledot(:,1))
    thea=0:0.001*pi:2*pi;
    xo=circledot(i,1);
    yo=circledot(i,2);
    xx=xo+crange*cos(thea);
    yy=yo+crange*sin(thea);

    in=inpolygon(EN_x,EN_y,xx,yy);
    numa=numel(EN_x(in));
    in=inpolygon(nEN_x,nEN_y,xx,yy);
    numb=numel(nEN_x(in));
    p=numa/(numa+numb);%H0
    if p==0 || p==1
        H0=0;
    else
        H0=-p*log2(p)-(1-p)*log2(1-p);
    end
        %H0=-p*log2(p)-(1-p)*log2(1-p);

    BN=abs(numa-numb);
    conpensate=0;
    u=0;

    if BN==0 || H0==0
        Backbone_Node=[Backbone_Node;xo,yo];
    else
        while conpensate<=BN
            rr=[];
            seta=[];
            CP0x=[];
            CP0y=[];
            CPx=[];
            CPy=[];
            u=u+1;
            rr=crange*sqrt(rand(1,1));%需要改成在圆内，而不是正方形
            seta=(pi/2)*mod(u,4)+(pi/2)*rand(1,1);
            CP0x=xo+rr.*cos(seta);
            CP0y=yo+rr.*sin(seta);
            CP0=[CP0x,CP0y];
            CPx=CP0x+crange*cos(thea);
            CPy=CP0y+crange*sin(thea);
   
%         num1=[];
%         num2=[];
%         BNi=[];
            BNi=0;
            p1=0;
            Hi=0;
        
            in=inpolygon(EN_x,EN_y,CPx,CPy);
            num1=numel(EN_x(in));
            in=inpolygon(nEN_x,nEN_y,CPx,CPy);
            num2=numel(nEN_x(in));
            BNi=abs(num1-num2);
        
            p1=num1/(num1+num2);%Hi
            if p1==0 || p==1
                Hi=0;
            else
                Hi=-p1*log2(p1)-(1-p1)*log2(1-p1);
            end
        
        
        if Hi>=H0  && inpolygon(CP0x,CP0y,Convex(:,1),Convex(:,2))==1   %BNi<=BN Hi>=H0 abs(num1-num2)<=BN  
            conpensate=conpensate+1;
            Backbone_Node=[Backbone_Node;CP0];
%             plot(CP0x,CP0y,'m*');
%             hold on
%               [tha,rho]=cart2pol(CP0x,CP0y);
%               CP0ji=[tha,rho];
              
        end
        %plot(CP0x,CP0y,'b+');
        end
    end
end


    
end