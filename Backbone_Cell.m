function  [cell,Backbone_Cell] =  Backbone_Cell(cell,layer)
%Ѱ�ҹǸɾ���,Ϊ�Ǹɾ�������
Backbone_Cell=[];
for i=2^(layer-1):1:2^layer-1    %���Ҷ�Ӿ������¼�����������Ϊ�Ǹɾ���
    if(cell(i).type==1)
        cell(i).type=2;
        Backbone_Cell=[Backbone_Cell,i];
    end
end

for i=2^(layer-1)-1:-1:1
    if(cell(2*i).type=='2' &&cell(2*i+1).type=='2')       %������Һ��ӽ��ǹǸɾ������򲻼�������
        continue;
    elseif((cell(2*i).type==0 || cell(2*i+1).type==0)&& cell(i).type==1)   %��һ�����ӻ��������Ӷ�Ϊ���¼�����������Ϊ�¼�����������Ϊ�Ǹɾ���
        cell(i).type=2;
        Backbone_Cell=[Backbone_Cell,i];
    end

end
% EN_x=[];
% EN_y=[];
% EN_x=[EN_x;cell(Backbone_Cell(5)).element.EN(:,1);cell(Backbone_Cell(5)-1).element.EN(:,1);cell(Backbone_Cell(5)+1).element.EN(:,1)];
% EN_y=[EN_y;cell(Backbone_Cell(5)).element.EN(:,2);cell(Backbone_Cell(5)-1).element.EN(:,2);cell(Backbone_Cell(5)+1).element.EN(:,2)];