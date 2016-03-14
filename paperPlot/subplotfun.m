function subplotfun( funHandle,r,c,maxCount )
%对subplot进行迭代
% funHandle 允许有一个输入，代表subplot的count，如 fun(count)
if nargin < 4
    maxCount = r*c;
end
for ii = 1:maxCount
    subplot(r,c,ii);
    funHandle(ii);
end
end

