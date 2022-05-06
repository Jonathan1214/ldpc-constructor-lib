function [ r, H_full ] = myrank( CNs_connection, cpmSizeMinus1, correctedIndex )
%MYRANK get rank of parity-check matrix
% 
[row, col] = size(CNs_connection);
H_full = zeros(row, col*cpmSizeMinus1);
for i = 1:row
    for j = 1:col
        if ( CNs_connection(i, j) ~= 0 )
            H_full(i, CNs_connection(i, j)+correctedIndex) = 1;
        end
    end
end
r = gfrank(H_full, 2);
end

