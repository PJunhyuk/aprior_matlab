%% get non-zero and non-whole subset of A
% to cells form
% refer to website

function subset = get_subset(A)
   bitNo = length(A);         % number of bits
   setNo = 2 ^ bitNo - 1;     % number of sets
   for setId = 1: setNo-1
      % convert number to a binary string and that to logical indices
      setIndices = logical(dec2bin(setId, bitNo) - '0');
      % select the current set by using the logical indices
      subset{1, setId} = A(setIndices);
   end
end