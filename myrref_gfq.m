function [ A,jb ] = myrref_gfq( A, ex_order )
% 修改 A 中元素的定义，A(i, j) = k 表示扩域中的元素 \alpha^(k - 1)
%                         若 k = 0 表示无连接
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

base = 2;
% ex_order = 6;
q = base^ex_order;
cpmSize = q;
powersOfExField = (0:2*cpmSize)';
lut = gftuple(powersOfExField, ex_order);
lut_int = bi2de(lut);
reverse_lut = zeros(cpmSize, 1);
for i = 1:cpmSize-1
    reverse_lut(lut_int(i)) = i;
end

% rng(0);
% A = randi([0 q-1], 6, 28);

[m,n] = size(A);

% Compute the default tolerance if none was provided.
% if (nargin < 2), tol = max(m,n)*eps(class(A))*norm(A,'inf'); end
tol = 0.00001;

% Loop over the entire matrix.
i = 1;
j = 1;
jb = [];
h = waitbar(0,'Please wait...');
while (i <= m) && (j <= n)
    waitbar(i / m, h);
   % Find value and index of largest element in the remainder of column j.
   [p2,k] = max(abs(A(i:m,j))); k = k+i-1;
   if (p2 <= tol)
      % The column is negligible, zero it out.
      A(i:m,j) = zeros(m-i+1,1);
      j = j + 1;
   else
      % Remember column index
      jb = [jb j];
      % Swap i-th and k-th rows.
      A([i k],j:n) = A([k i],j:n);
      % Divide the pivot row by the pivot element.
        b = A(i, j);
        for jj = j:n
            if A(i, jj) > 0
                A(i, jj) = A(i, jj) + (q - b);
                if A(i, jj) >= q
                    A(i, jj) = A(i, jj) - q + 1;
                end
            end
        end
      % Subtract multiples of the pivot row from all the other rows.
      for k = [1:i-1 i+1:m]
          if A(k, j) > 0
              % 第一个元素要使用多次
              b = A(k, j);
              for jj = j:n
%                   if A(k, jj) > 0 % 0 means no connection
                      % xor means add operation in GF(2^q)
                      if A(k, jj) >= q
                          if A(k, jj) >= 2 *q
                              fprintf('%d %d %d\n', k, jj, A(k, jj));
                          end
                          A(k, jj) = mod(A(k, jj), q) + 1;
                      end
                      if A(i, jj) > 0
                          p = b + A(i, jj) - 1; % multiple
    %                       if p2 >= q
    %                           p2 = mod(p2, q) + 1;
    %                       end
                          if A(k, jj) == 0
                              p1 = 0;
                          else
                              p1 = lut_int(A(k, jj));
                          end
                          A(k, jj) = bitxor(p1, lut_int(p)); % add
                          if A(k, jj) > 0
                              A(k, jj) = reverse_lut(A(k, jj));
                          end
                      end
%                   end
              end
          end
      end
      i = i + 1;
      j = j + 1;
   end
end
end

