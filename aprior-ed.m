function rule = aprior(thr, con)

dataset_name = 'house-votes-84.txt';
dataset_form = '%s%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c';
dataset_size = 17;

global confidence
confidence = con;

global threshold
threshold = thr;

fid = fopen(dataset_name, 'r');
data = textscan(fid, dataset_form, 'delimiter', ',');

global data_size
data_size = size(data{1},1);
array_raw = zeros(data_size, dataset_size);

global array_simple
array_simple = zeros(data_size, dataset_size);

for i = 1:data_size
    array_raw(i, 1) = data{1, 1}{i, 1}(1);
    if(array_raw(i, 1) == 114)
        array_simple(i, 1) = 1;
    end
end

for i = 1:data_size
    for j = 2:dataset_size
        array_raw(i, j) = data{1, j}(i);
        if(array_raw(i, j) == 121)
            array_simple(i, j) = 1;
        elseif(array_raw(i, j) == 63)
            array_simple(i, j) = -1;
        end
    end
end

C_1 = cell(1, dataset_size);

global C_total
C_total = cell(1, dataset_size);

for i = 1:dataset_size
    C_1(1, i) = {i};
    C_total(1, i) = {i};
end

temp = size(C_1);
C_1_size = temp(1, 2);

global freq_itemset

ccount = 0;
for i = 1:C_1_size
    count = 0;
    for j = 1:data_size
        temp = size(C_1{1, i});
        for k = 1:temp(1, 2)
            if(array_simple(j, C_1{1, i}(1, k)) == 1)
                count = count + 1;
            end
        end
    end
    if(count >= threshold)
        ccount = ccount + 1;
        L_1(1, ccount) = C_1{1, i};
    end
end

freq_itemset = cell(1, 0);

temp = size(L_1);
L_1_size = temp(1, 2);
count = 0;
for i = 1:L_1_size
    for j = i+1:L_1_size
        status = 1;
        temp = union(L_1(1, i), L_1(1, j));
        temp_size = size(temp);
        if(temp_size(1, 2) == 2)
            for k = 1:count
                if(C_2{1, k} == temp)
                    status = 0;
                    break;
                end
            end
            if(status == 0)
                break;
            end
            count = count + 1;
            C_2{1, count} = temp;
            C_total{1, count+C_1_size} = temp;
        end
    end
end

global status_break
status_break = 1;

while(1)
    L_2 = calculate_C(C_2);
    if(status_break == 0)
        break;
    end

    C_3 = calculate_L(L_2);
    if(status_break == 0)
        break;
    end

    L_3 = calculate_C(C_3);
    if(status_break == 0)
        break;
    end
    
    C_4 = calculate_L(L_3);
    if(status_break == 0)
        break;
    end

    L_4 = calculate_C(C_4);
    if(status_break == 0)
        break;
    end
    
    C_5 = calculate_L(L_4);
    if(status_break == 0)
        break;
    end

    L_5 = calculate_C(C_5);
    if(status_break == 0)
        break;
    end

    C_6 = calculate_L(L_5);
    if(status_break == 0)
        break;
    end

    L_6 = calculate_C(C_6);
    if(status_break == 0)
        break;
    end
    
    C_7 = calculate_L(L_6);
    if(status_break == 0)
        break;
    end
    
    L_7 = calculate_C(C_7);
    if(status_break == 0)
        break;
    end
    
    break;
end

rule = generate_rule();

five_rule = find_five_rule(rule);

temp = size(rule);
longest_rule = rule(temp(1,1), 1:5);

end