function [ tablePowerOfIndex, tableIndexOfPower, baseMat ] = genBaseMatOfQCLDPC( root, q )
%GENBASEMATOFQCLDPC generate base Matrix of QC LDPC 
%   dependence: genGFIndex()
%   @param: q    GF(q)
%   @param: root root of GF

[tablePowerOfIndex, tableIndexOfPower] = genGFqIndex(root, q);

w0 = tableIndexOfPower - 1;
tmp = w0;
w0 = circshift(w0, [1, 0]);

baseMat = zeros(q-1, length(w0));
for ii = 1:q-1
    tmp = circshift(tmp, [1 0]);
    baseMat(ii, :) = tmp';    
end
end

