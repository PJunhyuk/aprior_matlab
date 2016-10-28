%% calculate C using L
function C = calculate_L(L)

% get global variables
global status_break

tmp = size(L{1, 1});

temp = size(L);
L_size = temp(1, 2);

count = 0;
for i = 1:L_size-1
    for j = i+1:L_size
        status = 1;
        % temp is union of 2 elements of L
        temp = union(cell2mat(L(1, i)), cell2mat(L(1, j)));
        temp_size = size(temp);
        % temp_size(1, 2) == tmp(1,2)+1 means L(1, i), L(1, j) is deferent
        % in only 1 elements
        if(temp_size(1, 2) == tmp(1,2)+1)
            for k = 1:count
                % if temp is already in C, change status to 0
                if(C{1, k} == temp)
                    status = 0;
                    break;
                end
            end
            if(status == 0)
            else
                % if status is not 0, add it in C
                count = count + 1;
                C{1, count} = temp;
                % turn back status
                status = 1;
            end
        end
    end
end

% if no C, change status_break to 0 to break
if(count == 0)
    status_break = 0;
    C = 'exit';
end

end