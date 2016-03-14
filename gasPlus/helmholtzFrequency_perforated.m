function fv = helmholtzFrequency_perforated( a,P,l,d,T,coeffEnd)
%��װ�Ĺ���Ƶ�ʼ���
%   a ����
%   P ������
%   l �׵ĳ���
%   d С�׵�ֱ��
%   T ��������ĺ��
%   coeffEnd ĩ������ϵ����Ĭ��0.8
%       d
% -----||----||----||----||----||----||----||----|| l
%  T
% ___________________________________________________
if nargin < 6
    coeffEnd = 0.8;
end
fv = (a./(2*pi)) .* (P./(T.*(l+coeffEnd.*d))).^0.5;

end

