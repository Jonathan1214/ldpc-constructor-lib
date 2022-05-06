function [start_addr_row_based] = gen_ram_addr_offset(H_disp, PowerIndx)
%% GEN_RAM_ADDR_OFFSET 生成地址偏置值
%
% 地址值无需修正

[r, c] = size(H_disp);
start_addr_row_based = zeros(size(H_disp));

for i = 1:r
    for j = 1:c
        if PowerIndx(H_disp(i, j)) ~= 0
            start_addr_row_based(i, j) = PowerIndx(H_disp(i, j));
        end
    end
end

end


