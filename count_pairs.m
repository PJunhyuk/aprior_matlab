%% count how many pairs in array_simple
function number = count_pairs(pairs)

% get global variables
global array_simple
global data_size

temp = size(pairs);

number = 0;
for j = 1:data_size
    % check whether pairs is subset of array_simple(j, :)
    if(sum(sum(union(pairs, array_simple(j, :)))) == sum(sum(array_simple(j, :))))
        number = number + 1;
    end
end

end