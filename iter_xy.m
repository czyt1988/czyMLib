function [z,h] = iter_xy(x,y,funXY,varargin)
	% ����x,y
	% �����Ľ������z
	% x ����x
	% y ����y
	% funXY �������
	% 
	isShowFig = 1;
	pp=varargin;
    h = nan;
    z = nan;
	while length(pp)>=2
	    prop =pp{1};
	    val=pp{2};
	    pp=pp(3:end);
	    switch lower(prop)
	        case 'isshowfig' %�Ƿ���ʾ����������ͼ��
	            isShowFig = val;
	    end
	end
	for ii = 1:length(y)
		for jj = 1:length(x)
			z(ii,jj) = funXY(x(jj),y(ii));
		end
	end
	if isShowFig
		h = plotXYZ(x,y,z);
	end
end

function h = plotXYZ(x,y,z)
	[x,y] = meshgrid(x,y);
	h = surf(x,y,z);
end