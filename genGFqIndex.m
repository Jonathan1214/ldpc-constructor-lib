% ***************************************************
% @Author       :  JiangxuanLi 
% @DateTime     :  2020/11/14 15:46:10
% @Description  :  des
%
% ***************************************************


function [ tablePowerOfIndex, tableIndexOfPower ] = genGFqIndex( root, q )

tablePowerOfIndex = zeros(q-1, 1);
tableIndexOfPower = zeros(q-1, 1);
value = 1;
for i = 1:length(tablePowerOfIndex)
    % 3
    value = mod(value * root, q);
    tablePowerOfIndex(value) = i;
    tableIndexOfPower(i) = value;
end
tablePowerOfIndex(1) = 0;

end

