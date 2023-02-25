%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @file name:       genTestCaseFPGA.m
% @created date:    2023/02/25
% @author:          Jiangxuan Li
% @decription:      generate testcase for FPGA use
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [transCode] = genTestCaseFPGA(wordLen, fracLen, row_weight, q_GF_minus1, GFilePath, deli, ebn0db, allzero)
%genTestCaseFPGA 生成用于 FPGA 测试的用例 
%   wordLen     : 量化长度
%   fracLen     : 小数部分长度
%   row_weight  : 校验矩阵行重
%   q_GF_minus1 : 有限域大小减1
%   GFilePath   : 生成矩阵路径
%   deli        : 保存生成矩阵的数据文件中的分隔符 默认用空格即可
%   ebn0db      : 比特信噪比


% n = 1.1;
GG = dlmread(GFilePath, deli);
absminllr = 2^(-1*fracLen);

q = quantizer('mode', 'fixed', 'roundmode', 'Nearest', ...
    'overflowmode', 'saturate', 'format', [wordLen, fracLen]);
% num2bin(q, n)

% VN_num col number of G
% G_ROW row number of G
[G_ROW, VN_num] = size(GG);

ENCODE_RATIO   = G_ROW/VN_num;  % encoder ratio

esn0  = ENCODE_RATIO * 10^(ebn0db/10);
sigma = 1/sqrt(2 * esn0);

% fix seed for random number
rng(0);

% all zeroes code
baseCode = randi([0, 1], 1, G_ROW);
if allzero == 1
    baseCode = ones(1, G_ROW);
end

transCode = mod(baseCode * GG, 2);


transSym  = 1 - 2 * transCode;
receSym   = transSym + sigma * randn(1, VN_num);
% llr is 2*receSym/sigma^2
llr = 2 * receSym / sigma^2;

for i = 1:VN_num
    if abs(llr(i)) < absminllr
        llr(i) = sign(llr(i)) * absminllr;
    end
end

res = num2bin(q, llr);

%% gen test case for testbench
mkdir('testcase');
for i = 1:row_weight
    file_name = sprintf('./testcase/llr_in_%d.txt', i-1);
    f = fopen(file_name, 'w');
    for j = 1:q_GF_minus1
        ind = j + (i - 1) * q_GF_minus1;
        fprintf(f, [res(ind, :) '\n']);
    end
    fclose(f);
end


end
