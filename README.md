# aprior_matlab
find confidence rules of given dataset using A-priori algorithm in MATLAB

## Usage
  1. Download all Matlab codes in one folder
  1. Open aprior_a.m or aprior_b.m
  1. Change dataset_name, dataset_form, dataset_size, and codes in accordance with given dataset
  1. Set confidence & threshold
  1. Run
  
### Sample Usage
- For house_votes-84.txt
  1. Set confidence & threshold
  1. Run

- For medium-data.txt
  1. Set confidence & threshold
  1. Run
  
## Results
You can check time required, number of rules(by check size of rule), five most confidence rules(by check five_rule variable), and longest rule(by check longest_rule variable)

### Sample Results
Set confidence = 0.7, threshold = 215
longest_rule is [ I -> j ]
```
1(democrat) & 10(adoption-of-the-budget-resolution: yes) -> 14(physician-fee-freeze: no)
support(I) = 219, support(I U j) = 231, conf = 0.9481
```

## Code Structure
-	aprior_a.m : execute A-priori algorithm and calculate rule. Return rule.  Calculate five_rule, longest_rule. Target is house-votes-84.txt
-	aprior_b.m : execute A-priori algorithm and calculate rule. Return rule. Calculate five_rule, longest_rule. Target is medium-data.txt
-	calculate_C.m : calculate L using C
-	calculate_L.m : calculate C using L
-	generate_rule.m : generate rule using frequency itemset
-	find_five_rule.m : find five rules which has most frequency value
-	get_subset.m : get non-zero and non-whole subset of A
-	count_pairs.m : count how many pairs in array_simple
