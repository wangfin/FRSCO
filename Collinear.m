function tag=Collinear(Node)
%�жϽڵ��Ƿ���

tag=1;   %Ĭ�Ϲ���

%�����߶�б��
if(Node(1,1)~=Node(2,1))  %�������Ǵ�ֱ��x���ֱ��
    k=(Node(1,2)-Node(2,2))/(Node(1,1)-Node(2,1));
    for i=3:1:size(Node,1)
        if( k~=(Node(1,2)-Node(i,2))/(Node(1,1)-Node(i,1)))
            tag=0;    %����õ����߶�б�ʲ�ͬ���򲻹��ߣ������ѭ����
            break;
        end
    end
else
    for i=3:1:size(Node,1)
        if(Node(i,1)~=Node(1,1))
            tag=0;
            break;
        end
    end
end

