%% check time required
tic

%% basic information of dataset
dataset_name = 'medium-data.txt';
dataset_form = '%d%s%s%s%d%s%s%s%s%s%d%d%d%s%s';
dataset_size = 15;
dataset_ignore = 5;

%% setting confidence & threshold
% change confidence and threshold for finding reasonable rules

global confidence
confidence = 0.7;

global threshold
threshold = 13000;

%% get data from file
fid = fopen(dataset_name, 'r');
data = textscan(fid, dataset_form, 'delimiter', ',');

% data_size : number of basket
global data_size
data_size = size(data{1},1);

%% define array_simple

% initialize array_simple
global array_simple
array_simple = zeros(data_size, dataset_size - dataset_ignore);

% column 1 : democrat = 1, republican = 2, ? = 3
for i = 1:data_size
    array_simple(i, 1) = data{1, 1}(i);
end

% column k : y = 3k-2, n = 3k-1, ? = 3k
for i = 1:data_size
    if(strcmp(data{1, 2}(i, 1), 'Private'))
        array_simple(i, 2) = 100;
    elseif(strcmp(data{1, 2}(i, 1), 'Self-emp-not-inc'))
        array_simple(i, 2) = 101;
    elseif(strcmp(data{1, 2}(i, 1), 'Self-emp-inc'))
        array_simple(i, 2) = 102;
    elseif(strcmp(data{1, 2}(i, 1), 'Federal-gov'))
        array_simple(i, 2) = 103;
    elseif(strcmp(data{1, 2}(i, 1), 'Local-gov'))
        array_simple(i, 2) = 104;
    elseif(strcmp(data{1, 2}(i, 1), 'State-gov'))
        array_simple(i, 2) = 105;
    elseif(strcmp(data{1, 2}(i, 1), 'Without-pay'))
        array_simple(i, 2) = 106;
    elseif(strcmp(data{1, 2}(i, 1), 'Never-worked'))
        array_simple(i, 2) = 107;
    else
        array_simple(i, 2) = 108;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 4}(i, 1), 'Bachelors'))
        array_simple(i, 3) = 109;
    elseif(strcmp(data{1, 4}(i, 1), 'Some-college'))
        array_simple(i, 3) = 110;
    elseif(strcmp(data{1, 4}(i, 1), '11th'))
        array_simple(i, 3) = 111;
    elseif(strcmp(data{1, 4}(i, 1), 'HS-grad'))
        array_simple(i, 3) = 112;
    elseif(strcmp(data{1, 4}(i, 1), 'Prof-school'))
        array_simple(i, 3) = 113;
    elseif(strcmp(data{1, 4}(i, 1), 'Assoc-acdm'))
        array_simple(i, 3) = 114;
    elseif(strcmp(data{1, 4}(i, 1), 'Assoc-voc'))
        array_simple(i, 3) = 115;
    elseif(strcmp(data{1, 4}(i, 1), '9th'))
        array_simple(i, 3) = 116;
    elseif(strcmp(data{1, 4}(i, 1), '7th-8th'))
        array_simple(i, 3) = 117;
    elseif(strcmp(data{1, 4}(i, 1), '12th'))
        array_simple(i, 3) = 118;
    elseif(strcmp(data{1, 4}(i, 1), 'Masters'))
        array_simple(i, 3) = 119;
    elseif(strcmp(data{1, 4}(i, 1), '1st-4th'))
        array_simple(i, 3) = 120;
    elseif(strcmp(data{1, 4}(i, 1), '10th'))
        array_simple(i, 3) = 121;
    elseif(strcmp(data{1, 4}(i, 1), 'Doctorate'))
        array_simple(i, 3) = 122;
    elseif(strcmp(data{1, 4}(i, 1), '5th-6th'))
        array_simple(i, 3) = 123;
    elseif(strcmp(data{1, 4}(i, 1), 'Preschool'))
        array_simple(i, 3) = 124;
    else
        array_simple(i, 3) = 125;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 6}(i, 1), 'Married-civ-spouse'))
        array_simple(i, 4) = 126;
    elseif(strcmp(data{1, 6}(i, 1), 'Divorced'))
        array_simple(i, 4) = 127;
    elseif(strcmp(data{1, 6}(i, 1), 'Never-married'))
        array_simple(i, 4) = 128;
    elseif(strcmp(data{1, 6}(i, 1), 'Separated'))
        array_simple(i, 4) = 129;
    elseif(strcmp(data{1, 6}(i, 1), 'Widowed'))
        array_simple(i, 4) = 130;
    elseif(strcmp(data{1, 6}(i, 1), 'Married-spouse-absent'))
        array_simple(i, 4) = 131;
    elseif(strcmp(data{1, 6}(i, 1), 'Married-AF-spouse'))
        array_simple(i, 4) = 132;
    else
        array_simple(i, 3) = 133;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 7}(i, 1), 'Tech-support'))
        array_simple(i, 5) = 134;
    elseif(strcmp(data{1, 7}(i, 1), 'Craft-repair'))
        array_simple(i, 5) = 135;
    elseif(strcmp(data{1, 7}(i, 1), 'Other-service'))
        array_simple(i, 5) = 136;
    elseif(strcmp(data{1, 7}(i, 1), 'Sales'))
        array_simple(i, 5) = 137;
    elseif(strcmp(data{1, 7}(i, 1), 'Exec-managerial'))
        array_simple(i, 5) = 138;
    elseif(strcmp(data{1, 7}(i, 1), 'Prof-specialty'))
        array_simple(i, 5) = 139;
    elseif(strcmp(data{1, 7}(i, 1), 'Handlers-cleaners'))
        array_simple(i, 5) = 140;
    elseif(strcmp(data{1, 7}(i, 1), 'Machine-op-inspct'))
        array_simple(i, 5) = 141;
    elseif(strcmp(data{1, 7}(i, 1), 'Adm-clerical'))
        array_simple(i, 5) = 142;
    elseif(strcmp(data{1, 7}(i, 1), 'Farming-fishing'))
        array_simple(i, 5) = 143;
    elseif(strcmp(data{1, 7}(i, 1), 'Transport-moving'))
        array_simple(i, 5) = 144;
    elseif(strcmp(data{1, 7}(i, 1), 'Priv-house-serv'))
        array_simple(i, 5) = 145;
    elseif(strcmp(data{1, 7}(i, 1), 'Protective-serv'))
        array_simple(i, 5) = 146;
    elseif(strcmp(data{1, 7}(i, 1), 'Armed-Forces'))
        array_simple(i, 5) = 147;
    else
        array_simple(i, 5) = 148;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 8}(i, 1), 'Wife'))
        array_simple(i, 6) = 149;
    elseif(strcmp(data{1, 8}(i, 1), 'Own-child'))
        array_simple(i, 6) = 150;
    elseif(strcmp(data{1, 8}(i, 1), 'Husband'))
        array_simple(i, 6) = 151;
    elseif(strcmp(data{1, 8}(i, 1), 'Not-in-family'))
        array_simple(i, 6) = 152;
    elseif(strcmp(data{1, 8}(i, 1), 'Other-relative'))
        array_simple(i, 6) = 153;
    elseif(strcmp(data{1, 8}(i, 1), 'Unmarried'))
        array_simple(i, 6) = 154;
    else
        array_simple(i, 6) = 155;
    end
end
        
for i = 1:data_size
    if(strcmp(data{1, 9}(i, 1), 'White'))
        array_simple(i, 7) = 156;
    elseif(strcmp(data{1, 9}(i, 1), 'Asian-Pac-Islander'))
        array_simple(i, 7) = 157;
    elseif(strcmp(data{1, 9}(i, 1), 'Amer-Indian-Eskimo'))
        array_simple(i, 7) = 158;
    elseif(strcmp(data{1, 9}(i, 1), 'Other'))
        array_simple(i, 7) = 159;
    elseif(strcmp(data{1, 9}(i, 1), 'Black'))
        array_simple(i, 7) = 160;
    else
        array_simple(i, 7) = 161;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 10}(i, 1), 'Female'))
        array_simple(i, 8) = 162;
    elseif(strcmp(data{1, 10}(i, 1), 'Male'))
        array_simple(i, 8) = 163;
    else
        array_simple(i, 8) = 164;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 14}(i, 1), 'United-States'))
        array_simple(i, 9) = 165;
    elseif(strcmp(data{1, 14}(i, 1), 'Cambodia'))
        array_simple(i, 9) = 166;
    elseif(strcmp(data{1, 14}(i, 1), 'England'))
        array_simple(i, 9) = 167;
    elseif(strcmp(data{1, 14}(i, 1), 'Puerto-Rico'))
        array_simple(i, 9) = 168;
    elseif(strcmp(data{1, 14}(i, 1), 'Canada'))
        array_simple(i, 9) = 169;
    elseif(strcmp(data{1, 14}(i, 1), 'Germany'))
        array_simple(i, 9) = 170;
    elseif(strcmp(data{1, 14}(i, 1), 'Outlying-US(Guam-USVI-etc)'))
        array_simple(i, 9) = 171;
    elseif(strcmp(data{1, 14}(i, 1), 'India'))
        array_simple(i, 9) = 172;
    elseif(strcmp(data{1, 14}(i, 1), 'Japan'))
        array_simple(i, 9) = 173;
    elseif(strcmp(data{1, 14}(i, 1), 'Greece'))
        array_simple(i, 9) = 174;
    elseif(strcmp(data{1, 14}(i, 1), 'South'))
        array_simple(i, 9) = 175;
    elseif(strcmp(data{1, 14}(i, 1), 'China'))
        array_simple(i, 9) = 176;
    elseif(strcmp(data{1, 14}(i, 1), 'Cuba'))
        array_simple(i, 9) = 177;
    elseif(strcmp(data{1, 14}(i, 1), 'Iran'))
        array_simple(i, 9) = 178;
    elseif(strcmp(data{1, 14}(i, 1), 'Honduras'))
        array_simple(i, 9) = 179;
    elseif(strcmp(data{1, 14}(i, 1), 'Philippines'))
        array_simple(i, 9) = 180;
    elseif(strcmp(data{1, 14}(i, 1), 'Italy'))
        array_simple(i, 9) = 181;
    elseif(strcmp(data{1, 14}(i, 1), 'Poland'))
        array_simple(i, 9) = 182;
    elseif(strcmp(data{1, 14}(i, 1), 'Jamaica'))
        array_simple(i, 9) = 183;
    elseif(strcmp(data{1, 14}(i, 1), 'Vietnam'))
        array_simple(i, 9) = 184;
    elseif(strcmp(data{1, 14}(i, 1), 'Mexico'))
        array_simple(i, 9) = 185;
    elseif(strcmp(data{1, 14}(i, 1), 'Portugal'))
        array_simple(i, 9) = 186;
    elseif(strcmp(data{1, 14}(i, 1), 'Ireland'))
        array_simple(i, 9) = 187;
    elseif(strcmp(data{1, 14}(i, 1), 'France'))
        array_simple(i, 9) = 188;
    elseif(strcmp(data{1, 14}(i, 1), 'Dominican-Republic'))
        array_simple(i, 9) = 189;
    elseif(strcmp(data{1, 14}(i, 1), 'Laos'))
        array_simple(i, 9) = 190;
    elseif(strcmp(data{1, 14}(i, 1), 'Ecuador'))
        array_simple(i, 9) = 191;
    elseif(strcmp(data{1, 14}(i, 1), 'Taiwan'))
        array_simple(i, 9) = 192;
    elseif(strcmp(data{1, 14}(i, 1), 'Haiti'))
        array_simple(i, 9) = 193;
    elseif(strcmp(data{1, 14}(i, 1), 'Columbia'))
        array_simple(i, 9) = 194;
    elseif(strcmp(data{1, 14}(i, 1), 'Hungary'))
        array_simple(i, 9) = 195;
    elseif(strcmp(data{1, 14}(i, 1), 'Guatemala'))
        array_simple(i, 9) = 196;
    elseif(strcmp(data{1, 14}(i, 1), 'Nicaragua'))
        array_simple(i, 9) = 197;
    elseif(strcmp(data{1, 14}(i, 1), 'Scotland'))
        array_simple(i, 9) = 198;
    elseif(strcmp(data{1, 14}(i, 1), 'Thailand'))
        array_simple(i, 9) = 199;
    elseif(strcmp(data{1, 14}(i, 1), 'Yugoslavia'))
        array_simple(i, 9) = 200;
    elseif(strcmp(data{1, 14}(i, 1), 'El-Salvador'))
        array_simple(i, 9) = 201;
    elseif(strcmp(data{1, 14}(i, 1), 'Trinadad&Tobago'))
        array_simple(i, 9) = 202;
    elseif(strcmp(data{1, 14}(i, 1), 'Peru'))
        array_simple(i, 9) = 203;
    elseif(strcmp(data{1, 14}(i, 1), 'Hong'))
        array_simple(i, 9) = 204;
    elseif(strcmp(data{1, 14}(i, 1), 'Holand-Netherlands'))
        array_simple(i, 9) = 205;
    else
        array_simple(i, 9) = 206;
    end
end

for i = 1:data_size
    if(strcmp(data{1, 15}(i, 1), '>50K'))
        array_simple(i, 10) = 207;
    elseif(strcmp(data{1, 15}(i, 1), '<=50K'))
        array_simple(i, 10) = 208;
    else
        array_simple(i, 10) = 209;
    end
end

%% calculate C_1

dataset_size = 10;
data_type = 209;

% initialize C_1
C_1 = cell(1, data_type);

% define C_1
for i = 1:data_type
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