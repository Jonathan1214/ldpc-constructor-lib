function [z_mask] = mask_mat(r, k)
%MASK_MAT generate mask matrix
% r: columns
% k: rows (equals to 4 or 6)

if k ~= 4 && k ~= 6
    error('Bad value of k, expect 4 or 6');
end
if mod(r, 4) ~= 0
    error('Bad value of r, expect r = 4 * k');
end

if k == 4
    z_1 = [1 0 1 0;
           0 1 0 1;
           1 1 1 1;
           1 1 1 1];
    z_2 = circshift(z_1, [2 0]);
    z_mask = repmat([z_1, z_2], 1, floor(r / 8));
    if (mod(r, 8) ~= 0)
        z_mask = [z_mask z_1];
    end
end

if k == 6
    z_1 = [1 0 1 0;
           0 1 0 1;
           1 1 1 1;
           1 1 1 1;
           0 0 0 0;
           0 0 0 0];
    z_2 = circshift(z_1, [2 0]);
    z_3 = circshift(z_2, [2 0]);
    if r == 8
        z_mask = [z_1, z_2];
    else
        z_mask = repmat([z_1, z_2, z_3], 1, floor(r / 12));
        rel = mod(r, 12);
        if rel == 4
            z_mask = [z_mask z_1];
        elseif rel == 8
            z_mask = [z_mask z_1 z_2];
        end
    end
end

