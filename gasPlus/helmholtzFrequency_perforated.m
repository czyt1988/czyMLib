function fv = helmholtzFrequency_perforated( a,P,l,d,T,coeffEnd)
%多孔板的共振频率计算
%   a 声速
%   P 穿孔率
%   l 孔的长度
%   d 小孔的直径
%   T 板后空气层的厚度
%   coeffEnd 末端修正系数，默认0.8
%       d
% -----||----||----||----||----||----||----||----|| l
%  T
% ___________________________________________________
if nargin < 6
    coeffEnd = 0.8;
end
fv = (a./(2*pi)) .* (P./(T.*(l+coeffEnd.*d))).^0.5;

end

