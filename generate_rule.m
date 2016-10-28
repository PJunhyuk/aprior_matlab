%% generate_rule using frequency itemset
function rule = generate_rule()

% get global variables
global freq_itemset
global confidence

tmp = size(freq_itemset);

count = 0;

for a = 1:tmp(1, 2)
    subset_freq_itemset = get_subset(freq_itemset{1, a});
    temp = size(subset_freq_itemset);
    for b = 1:temp(1, 2)
        % set_i is one of non-zero and non-whole subset of freq_itemset
        set_i= subset_freq_itemset{1, b};
        % and set_j is complementary set of set_i in that freq_itemset
        set_j = setdiff(freq_itemset{1, a}, set_i);
        % calculate conf
        conf = count_pairs(freq_itemset{1, a}) / count_pairs(set_i);
        % if conf is bigger than confidence, it is "rule"
        if(conf >= confidence)
            count = count + 1;
            rule{count, 1} = set_i;
            rule{count, 2} = set_j;
            rule{count, 3} = count_pairs(freq_itemset{1, a});
            rule{count, 4} = count_pairs(set_i);
            rule{count, 5} = conf;
        end
    end
end

end