function d = joinVector(varargin)
%  ����vector��Ϊһ�����ӣ���ͬ���ȵĻ�����󳤶�Ϊ����������Ϊ0
% �磺
% a = [1,2,3];
% b = [1];
% c = [1,2];
% d = joinVector(a,b,c);
% d =
% 
%      1     1     1
%      2     0     2
%      3     0     0
    colLength = length(varargin);
    for ii = 1:colLength
        sl(ii) = length(varargin{ii});
    end
    maxSize = max(sl);
    d = zeros(maxSize,colLength);
    arrayfun(@(x) nan,d);
    for ii = 1:colLength
        d(1:sl(ii),ii) = varargin{ii};
    end
end