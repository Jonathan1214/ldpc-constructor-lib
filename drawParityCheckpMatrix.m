function [ p ] = drawParityCheckpMatrix( VNs_connection, cpmSizeMinus1, correctedIndex )
%drawParityCheckpMatrix 画出校验矩阵
%   此处显示详细说明

[m, n] = size(VNs_connection);

p = plot(VNs_connection, 'b.', 'MarkerSize', 3);
if ( correctedIndex == 0 )
    ylim([1 n*cpmSizeMinus1]);
    xlim([1 m]);
else
    ylim([0 n*cpmSizeMinus1-1]);
    xlim([0 m-1]);
end
 set(gca,'YDir','reverse');

end

