function [isRcConstrain] =RC(H)

isRcConstrain = 0;

checkMatrix = H * H';

for i = 1 : size(checkMatrix,1)
    for j = 1 : size(checkMatrix,2)
        if checkMatrix(i,j) > 1 && i ~= j
            isRcConstrain = isRcConstrain + 1;
        end
    end
end