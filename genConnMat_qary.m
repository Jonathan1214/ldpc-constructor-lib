function [ CNs_connection, cns_val, VNs_connection, vns_val] = genConnMat_qary( q, Bsp, tab )
%GENCONNMAT 生成 CN 和 VN 的连接关系矩阵
%   q:      素数
%   Bsp:    基矩阵
%   tablePowerOfIndex:
%                   index 是 GF(q) 中的元素
%                   value 是 元素对应 root 的 power

if nargin < 3
    tab = Bsp;
end
[g, r] = size(Bsp);

CNs_connection = zeros((q-1)*g, r);
cns_val  = zeros((q-1)*g, r);
VNs_connection = zeros((q-1)*r, g);
vns_val = zeros((q-1)*r, g);
% 建立 CN 连接表 可以直接读取每一个 CN 连接的 VN 的 index 
%       为和 C 语言匹配，index 从 0 开始
for iii = 1:g
    for sub_i = 1:q-1
        row = (iii - 1) * (q - 1) + sub_i;
        for jjj = 1:r
            index = Bsp(iii, jjj);
            % 如果为 0 直接用 0 代替 也就不用执行其他操作了
            if ( index ~= 0 )
%                 index = tablePowerOfIndex(index);   % 求出基矩阵值对应的 power
                % 再考虑循环移位得出最终的 VN 的 index
                VN_index = mod(index + (sub_i - 1), q-1) + (jjj - 1) * (q - 1) + 1; % 序号从 1 开始 0用来表示不存在连接 只是为了占位
                CNs_connection(row, jjj) = VN_index;
                cns_val(row, jjj) = tab(iii, jjj);
            end
        end
    end
end

% 这次可以通过直接遍历 CNs_connection 得到
for iii = 1:(q-1)*g
    for jjj = 1:r
        index = CNs_connection(iii, jjj);   % 是为了适应 matlab 的数组序号存储
        val = cns_val(iii, jjj);
        if ( index ~= 0 )
            cn_cnt = fix((iii-1)/(q-1)) + 1;
            VNs_connection(index, cn_cnt) = iii;
            vns_val(index, cn_cnt) = val;
        end
    end    
end

end

