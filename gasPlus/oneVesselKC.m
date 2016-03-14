function [ KC ] = oneVesselKC( mc,Lv,varargin )
%计算单容的衰减系数
%  长度 L1     l    Lv1   l    L2  
%              __________        
%             |          |      
%  -----------|          |----------
%             |__________|       
% 直径 Dpipe       Dv1       Dpipe  
% mc单容和连接管道的截面积之比既是Dv1^2/Dpipe^2
% Lv容器长度
    [k,displayFig,xLvK] = checkInput(varargin);
    if displayFig%需要绘制图形
        if xLvK
            Lvk = Lv.* k;
            KC = plotKC_Lvk(mc,Lvk);
        else
            KC = plotKC(mc,Lv,k);
        end
    else%不需要绘制图形，直接计算kc
        KC = calcKC(mc,Lv,k);
    end


end

function [k,displayFig,xLvK] = checkInput(vinput)
    pp=vinput;
    k = nan;
    w = nan;
    a = nan;
    displayFig = 0;
    xLvK = 0;%xLvK为1时，x轴为Lv*k
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
                case 'xlvk'
                    xLvK = val;
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

function KC = calcKC(mc,Lv,k)
    Lvk = Lv.* k;
    KC = calcKC_2para(mc,Lvk);
end

function KC = calcKC_2para(mc,Lvk)
    KC = 1+ 0.25.* ((mc-1./mc).^2) .* (sin(Lvk).^2);
    KC = KC.^0.5;
end

function [res,H] = plotKC(mc,Lv,k)
%计算不同情况的kc
% Y = kc
% X = k*Lv
    res = arrayfun(@(xx) calcKC(xx,Lv,k),mc,'UniformOutput',0);
    figure
    hold on;
    H = cellfun(@(yy) plot(Lv,yy,'-b','LineWidth',1.5),res);
    title('KC of one vessel');
    xlabel('Lv');
    ylabel('KC');
end

function [res,H] = plotKC_Lvk(mc,Lvk)
%计算不同情况的kc
% Y = kc
% X = k*Lv
    res = arrayfun(@(xx) calcKC_2para(xx,Lvk),mc,'UniformOutput',0);
    figure
    hold on;
    H = cellfun(@(yy) plot(Lvk,yy,'-b','LineWidth',1.5),res);
    title('KC of one vessel');
    xlabel('k*Lv');
    ylabel('KC');
end