%% check time required
tic

%% basic information of dataset
dataset_name = 'house-votes-84.txt';
dataset_form = '%s%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c';
dataset_size = 17;

%% setting confidence & threshold
% change confidence and threshold for finding reasonable rules

global confidence
confidence = 0.85;

global threshold
threshold = 180;

%% get data from file
fid = fopen(dataset_name, 'r');
data = textscan(fid, dataset_form, 'delimiter', ',');

% data_size : number of basket
global data_size
data_size = size(data{1},1);

%% define array_simple
% array_raw : data with no modify
array_raw = zeros(data_size, dataset_size);

% initialize array_simple
global array_simple
array_simple = zeros(data_size, dataset_size);

% column 1 : democrat = 1, republican = 2, ? = 3
for i = 1:data_size
    array_raw(i, 1) = data{1, 1}{i, 1}(1);
    if(array_raw(i, 1) == 100)
        array_simple(i, 1) = 1;
    elseif(array_raw(i, 1) == 114)
        array_simple(i, 1) = 2;
    elseif(array_raw(i, 1) == 63)
        array_simple(i, 1) = 3;
    end
end

% column k : y = 3k-2, n = 3k-1, ? = 3k
for i = 1:data_size
    for j = 2:dataset_size
        array_raw(i, j) = data{1, j}(i);
        if(array_raw(i, j) == 121)
            array_simple(i, j) = 3*(j-1)+1;
        elseif(array_raw(i, j) == 110)
            array_simple(i, j) = 3*(j-1)+2;
        elseif(array_raw(i, j) == 63)
            array_simple(i, j) = 3*(j-1)+3;
        end
    end
end

%% calculate C_1
% initialize C_1
C_1 = cell(1, 3*dataset_size);

% define C_1
for i = 1:3*dataset_size
    C_1(1, i) = {i};
end

% basic information of C_1
temp = size(C_1);
C_1_size = temp(1, 2);

%% calculate L_1
count = 0;
for i = 1:C_1_size
    % as element of C_1, if more than threshold, put it in L_1
    if(sum(sum(array_simple(:,:) == i)) >= threshold)
        count = count + 1;
        L_1(1, count) = C_1{1, i};
    end
end

% basic information of L_1
temp = size(L_1);
L_1_size = temp(1, 2);

%% calculate C_2
% C_2 : union of 2 elements in L_1
count = 0;
for i = 1:L_1_size
    for j = i+1:L_1_size
        status = 1;
        temp = union(L_1(1, i), L_1(1, j));
        count = count + 1;
        C_2{1, count} = temp;
    end
end

% basic information of C_2
temp = size(C_2);
C_2_size = temp(1, 2);

%% more calculatation
% initialize freq_itemset
% freq_itemset : union of L_2, L_3, L_4, ..
global freq_itemset
freq_itemset = cell(1, 0);

% initialize status_break
global status_break
status_break = 1;

while(1)
    % calculate L_2
    L_2 = calculate_C(C_2);
    % if status_break became 0, stop calculating
    if(status_break == 0)
        break;
    end

    % calculate C_3
    C_3 = calculate_L(L_2);
    if(status_break == 0)
        break;
    end

    % calculate L_3
    L_3 = calculate_C(C_3);
    if(status_break == 0)
        break;
    end
    
    % calculate C_4
    C_4 = calculate_L(L_3);
    if(status_break == 0)
        break;
    end

    % calculate L_4
    L_4 = calculate_C(C_4);
    if(status_break == 0)
        break;
    end
    
    % calculate C_5
    C_5 = calculate_L(L_4);
    if(status_break == 0)
        break;
    end

    % calculate L_5
    L_5 = calculate_C(C_5);
    if(status_break == 0)
        break;
    end

    % calculate C_6
    C_6 = calculate_L(L_5);
    if(status_break == 0)
        break;
    end

    % calculate L_6
    L_6 = calculate_C(C_6);
    if(status_break == 0)
        break;
    end
    
    % calculate C_7
    C_7 = calculate_L(L_6);
    if(status_break == 0)
        break;
    end
    
    % calculate L_7
    L_7 = calculate_C(C_7);
    if(status_break == 0)
        break;
    end
    
    % L_7 is enough
    break;
end

%% generating rule, and complete aprior
% generate all rules
rule = generate_rule();

% find five rules which has most frequency value
five_rule = find_five_rule(rule);

% find longest rule
% longest rule : the last rule of cell rule
temp = size(rule);
longest_rule = rule(temp(1,1), 1:5);

%% check time required
toc