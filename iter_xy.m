function [z,h] = iter_xy(x,y,funXY,varargin)
	% 迭代x,y
	% 迭代的结果存于z
	% x 变量x
	% y 变量y
	% funXY 函数句柄
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
	        case 'isshowfig' %是否显示迭代出来的图形
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