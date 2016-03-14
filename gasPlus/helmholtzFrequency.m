function fv = helmholtzFrequency( a,d,V,l,coeffEnd )
%��ķ���ȹ������Ĺ���Ƶ�ʼ���
%   a ����
%   d С�׿׾�
%   V ǻ�����
%   l С�׳���
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

