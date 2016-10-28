%% calculate L using C
function L = calculate_C(C)

% get global variables
global data_size
global array_simple
global threshold
global freq_itemset
global status_break

tmp = size(freq_itemset);
temp = size(C);

C_size = temp(1, 2);

ccount = 0;
for i = 1:C_size
    count = 0;
    for j = 1:data_size
        % check whether C{1, i} is subset of array_simple(j, :)
        if(sum(sum(union(C{1, i}, array_simple(j, :)))) == sum(sum(array_simple(j, :))))
            count = count + 1;
        end
    end
    % if C{1, i} is in array_simple, more then threshold, put it in L
    if(count >= threshold)
        ccount = ccount + 1;
        L{1, ccount} = C{1, i};
        % add it to freq_itemset, also
        freq_itemset{1, tmp(1, 2)+ccount} = C{1, i};
    end
end

% if no L, change status_break to 0 to break
if(ccount == 0)
    status_break = 0;
    L = 'exit';
end

end