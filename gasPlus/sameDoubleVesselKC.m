function [ KC ] = sameDoubleVesselKC( mc,LHalf,Lv,varargin )
%计算单容的衰减系数
%  长度 L1     l    Lv    l LHalf  l    Lv    l     L3
%              __________         __________
%             |          |       |          |
%  -----------|          |-------|          |-------------
%             |__________|       |__________|  
%  直径 Dpipe       Dv    Dpipe       Dv          Dpipe
% mc单容和连接管道的截面积之比既是Dv1^2/Dpipe^2
% Lv容器长度
    [k,displayFig] = checkInput(varargin);
    if displayFig%需要绘制图形
        KC = plotKC(mc,LHalf,Lv,k);
    else%不需要绘制图形，直接计算kc
        KC = calcKC(mc,LHalf,Lv,k);
    end


end

function [k,displayFig] = checkInput(vinput)
    pp=vinput;
    k = nan;
    w = nan;
    a = nan;
    displayFig = 0;
    if length(pp) == 1%varargin只有一个时，说明输入的是k，既是波数
        k = pp{1};
        return;
    else
        while length(pp)>=2
            prop =pp{1};
            val=pp{2};
            pp=pp(3:end);
            switch lower(prop)
                case 'w' %圆频率
                    w = val;
                case 'f' %频率
                    w = 2*pi*val;
                case 'a' %声速
                    a = val;
                case 'display'
                    displayFig = val;
                otherwise
                    error('参数错误%s',prop);
            end
        end
    end
    if isnan(w) || isnan(a)
        error('必须定义w或f和a');
    end
    if isnan(k)
        k = w/a;
    end
end

function KC = calcKC(mc,LHalf,Lv,k)
    KC = 1./(16.*mc.^2) .* ...
    ( 4.*mc.* ((mc+1).^2) .* cos(2*k.*(LHalf+Lv)) -...
    4*mc.* ((mc-1).^2) .* cos(2*k.*(Lv-LHalf)) ) + ...
    1i./(16.*mc.^2) .* (2.*(mc.^2 + 1).*(mc+1).^2 .* sin(2*k.*(LHalf + Lv)) - ...
    2*(mc.^2 + 1).*(mc - 1).^2 .* sin(2*k.*(Lv-LHalf)) - 4*(mc.^2-1).^2 .* sin(2.*k.*LHalf)) ;
end


function [KC] = plotKC(mc,LHalf,Lv,k)
%计算不同情况的kc
% Y = kc
% X = k*Lv
kLength = length(k);
mcLength = length(mc);
LLength = length(LHalf);
LvLength = length(Lv);
figure
hold on;
if LvLength > 1 && mcLength == 1
    KC = calcKC(mc,LHalf,Lv,k);
    plot(Lv,abs(KC),'-b','LineWidth',1.5);
    xlabel('Lv');
elseif LvLength > 1 && mcLength > 1
    KC = arrayfun(@(xx) calcKC(xx,LHalf,Lv,k),mc,'UniformOutput',0);
    cellfun(@(yy) plot(Lv,abs(yy),'-b','LineWidth',1.5),KC);
    xlabel('Lv');
end
title('KC of the same double vessel');
ylabel('KC');
end