function [ A,jb ] = myrref( A )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(A);

% Compute the default tolerance if none was provided.
if (nargin < 2), tol = max(m,n)*eps(class(A))*norm(A,'inf'); end

% Loop over the entire matrix.
i = 1;
j = 1;
jb = [];
h = waitbar(0,'Please wait...');
while (i <= m) && (j <= n)
    waitbar(i / m, h);
   % Find value and index of largest element in the remainder of column j.
   [p,k] = max(abs(A(i:m,j))); k = k+i-1;
   if (p <= tol)
      % The column is negligible, zero it out.
      A(i:m,j) = zeros(m-i+1,1);
      j = j + 1;
   else
      % Remember column index
      jb = [jb j];
      % Swap i-th and k-th rows.
      A([i k],j:n) = A([k i],j:n);
      % Divide the pivot row by the pivot element.
      A(i,j:n) = A(i,j:n)/A(i,j);
      % Subtract multiples of the pivot row from all the other rows.
      for k = [1:i-1 i+1:m]
         A(k,j:n) = mod(A(k,j:n) - A(k,j)*A(i,j:n), 2);
      end
      i = i + 1;
      j = j + 1;
   end
end
end

