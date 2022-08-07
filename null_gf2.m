function [ Z, R, pivcol ] = null_gf2( A )
%null_gf2 solve linear equation under GF(2)
%   @param[in]  A  a m * m size matrix under GF(2)
%   @param[in]  b  a m     length vector under GF(2)
%   @param[out] x  result of Ax = 0 under GF(2)
%   @note use Gaussian-Jordan elimination solve this problem

[m, n] = size(A);
if m ~= n
    error('BAD size of A, expect row of A equals to column A.');
end

% if m ~= length(b)
%     error('BAD length of vector b');
% end

% Guassian elimination
[R, pivcol] = myrref(A);
r = length(pivcol);
nopiv = 1:n;
nopiv(pivcol) = [];

if r == 0
    Z = 0;
else
    Z = zeros(n,n-r);
    if n > r
        Z(nopiv,:) = eye(n-r,n-r);
        if r > 0
            Z(pivcol,:) = R(1:r,nopiv);
        end
    end
end


end
