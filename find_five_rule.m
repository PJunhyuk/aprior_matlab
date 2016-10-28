%% find five rules which has most frequency value
function five_rule = find_five_rule(rule)

% initialize five_rule
five_rule = cell(3, 5);

% sort rule, and put it in five_rule
sort_rule = flipud(sortrows(rule, 5));

five_rule(1:5, 1:5) = sort_rule(1:5, 1:5);

end