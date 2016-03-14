function [ KC ] = sameDoubleVesselKC( mc,LHalf,Lv,varargin )
%���㵥�ݵ�˥��ϵ��
%  ���� L1     l    Lv    l LHalf  l    Lv    l     L3
%              __________         __________
%             |          |       |          |
%  -----------|          |-------|          |-------------
%             |__________|       |__________|  
%  ֱ�� Dpipe       Dv    Dpipe       Dv          Dpipe
% mc���ݺ����ӹܵ��Ľ����֮�ȼ���Dv1^2/Dpipe^2
% Lv��������
    [k,displayFig] = checkInput(varargin);
    if displayFig%��Ҫ����ͼ��
        KC = plotKC(mc,LHalf,Lv,k);
    else%����Ҫ����ͼ�Σ�ֱ�Ӽ���kc
        KC = calcKC(mc,LHalf,Lv,k);
    end


end

function [k,displayFig] = checkInput(vinput)
    pp=vinput;
    k = nan;
    w = nan;
    a = nan;
    displayFig = 0;
    if length(pp) == 1%vararginֻ��һ��ʱ��˵���������k�����ǲ���
        k = pp{1};
        return;
    else
        while length(pp)>=2
            prop =pp{1};
            val=pp{2};
            pp=pp(3:end);
            switch lower(prop)
                case 'w' %ԲƵ��
                    w = val;
                case 'f' %Ƶ��
                    w = 2*pi*val;
                case 'a' %����
                    a = val;
                case 'display'
                    displayFig = val;
                otherwise
                    error('��������%s',prop);
            end
        end
    end
    if isnan(w) || isnan(a)
        error('���붨��w��f��a');
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
%���㲻ͬ�����kc
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