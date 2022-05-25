function  [cell,Backbone_Cell] =  Backbone_Cell(cell,layer)
%寻找骨干晶胞,为骨干晶胞，则
Backbone_Cell=[];
for i=2^(layer-1):1:2^layer-1    %如果叶子晶胞是事件晶胞，则其为骨干晶胞
    if(cell(i).type==1)
        cell(i).type=2;
        Backbone_Cell=[Backbone_Cell,i];
    end
end

for i=2^(layer-1)-1:-1:1
    if(cell(2*i).type=='2' &&cell(2*i+1).type=='2')       %如果左右孩子皆是骨干晶胞，则不继续交互
        continue;
    elseif((cell(2*i).type==0 || cell(2*i+1).type==0)&& cell(i).type==1)   %有一个孩子或两个孩子都为非事件晶胞，且其为事件晶胞，则其为骨干晶胞
        cell(i).type=2;
        Backbone_Cell=[Backbone_Cell,i];
    end

end
% EN_x=[];
% EN_y=[];
% EN_x=[EN_x;cell(Backbone_Cell(5)).element.EN(:,1);cell(Backbone_Cell(5)-1).element.EN(:,1);cell(Backbone_Cell(5)+1).element.EN(:,1)];
% EN_y=[EN_y;cell(Backbone_Cell(5)).element.EN(:,2);cell(Backbone_Cell(5)-1).element.EN(:,2);cell(Backbone_Cell(5)+1).element.EN(:,2)];