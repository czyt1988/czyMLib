function fv = helmholtzFrequency( a,d,V,l,coeffEnd )
%亥姆霍兹共鸣器的共振频率计算
%   a 声速
%   d 小孔孔径
%   V 腔体体积
%   l 小孔长度
%      ___________
%     |           |
% d ---      V    |
% -----           |
%     |___________|
%  l   
if nargin < 5
    coeffEnd = 0.8;
end
fv = (a./(2*pi)) .* ((pi.*d.^2)./(V.*(l+coeffEnd.*d))).^0.5;
end

