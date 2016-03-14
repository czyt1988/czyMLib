function [ KC ] = oneVesselKC( mc,Lv,varargin )
%���㵥�ݵ�˥��ϵ��
%  ���� L1     l    Lv1   l    L2  
%              __________        
%             |          |      
%  -----------|          |----------
%             |__________|       
% ֱ�� Dpipe       Dv1       Dpipe  
% mc���ݺ����ӹܵ��Ľ����֮�ȼ���Dv1^2/Dpipe^2
% Lv��������
    [k,displayFig,xLvK] = checkInput(varargin);
    if displayFig%��Ҫ����ͼ��
        if xLvK
            Lvk = Lv.* k;
            KC = plotKC_Lvk(mc,Lvk);
        else
            KC = plotKC(mc,Lv,k);
        end
    else%����Ҫ����ͼ�Σ�ֱ�Ӽ���kc
        KC = calcKC(mc,Lv,k);
    end


end

function [k,displayFig,xLvK] = checkInput(vinput)
    pp=vinput;
    k = nan;
    w = nan;
    a = nan;
    displayFig = 0;
    xLvK = 0;%xLvKΪ1ʱ��x��ΪLv*k
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
                case 'xlvk'
                    xLvK = val;
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

function KC = calcKC(mc,Lv,k)
    Lvk = Lv.* k;
    KC = calcKC_2para(mc,Lvk);
end

function KC = calcKC_2para(mc,Lvk)
    KC = 1+ 0.25.* ((mc-1./mc).^2) .* (sin(Lvk).^2);
    KC = KC.^0.5;
end

function [res,H] = plotKC(mc,Lv,k)
%���㲻ͬ�����kc
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
%���㲻ͬ�����kc
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