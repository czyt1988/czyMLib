function subplotfun( funHandle,r,c,maxCount )
%��subplot���е���
% funHandle ������һ�����룬����subplot��count���� fun(count)
if nargin < 4
    maxCount = r*c;
end
for ii = 1:maxCount
    subplot(r,c,ii);
    funHandle(ii);
end
end

