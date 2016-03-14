function [ h1,h2 ] = plotCmp( X1,Y1,X2,Y2,markCell,lineStyleCell,clrData)
%���Ļ�ͼ-���ƶԱ�ͼ
%   ���������Ա�ͼ,��ͬ������ɫ����ͬ�ı��
h1 = plot(X1,Y1,'LineWidth',1.5,'color',clrData,'Marker',markCell{1},'LineStyle',lineStyleCell{1});
hold on;
h2 = plot(X2,Y2,'LineWidth',1.5,'color',clrData,'Marker',markCell{2},'LineStyle',lineStyleCell{2});
end

