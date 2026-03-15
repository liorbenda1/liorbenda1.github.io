
clc;clear all
train_table = table2cell(readtable('training_data.csv'));
genes = readtable('ncbi_dataset.csv');
genes = table2cell(sortrows(genes,'Begin'));
noc = {'A','C','G','T'};
%% read gene expression data and average it (RPKM)
rebseq1 = 'GSM4411847_H293_rep1.expr.txt';
rebseq2 = 'GSM4411848_H293_rep2.expr.txt';

fid1 = fopen(rebseq1,'r');
fid2 = fopen(rebseq2,'r');

header1 = strsplit(fgetl(fid1));
header2 = strsplit(fgetl(fid2));

i = 0;
data1 = {};
data2 = {};
while ~feof(fid1)
    i = i+1;
    data1(i,1:5) = strsplit(fgetl(fid1));
    data2(i,1:5) = strsplit(fgetl(fid2));
    RPKM(i,2) = (str2double(data1{i,5}) + str2double(data2{i,5}))/2;
    RPKM(i,1) = str2double(data1{i,1});
end
%% load chromosome variable

chr1 = load("chr1.mat").chr1;
chr2 = load("chr2.mat").chr2;
chr3 = load("chr3.mat").chr3;
chr4 = load("chr4.mat").chr4;
chr5 = load("chr5.mat").chr5;
chr6 = load("chr6.mat").chr6;
chr7 = load("chr7.mat").chr7;
chr8 = load("chr8.mat").chr8;
chr9 = load("chr9.mat").chr9;
chr10 = load("chr10.mat").chr10;
chr11 = load("chr11.mat").chr11;
chr12 = load("chr12.mat").chr12;
chr13 = load("chr13.mat").chr13;
chr14 = load("chr14.mat").chr14;
chr15 = load("chr15.mat").chr15;
chr16 = load("chr16.mat").chr16;
chr17 = load("chr17.mat").chr17;
chr18 = load("chr18.mat").chr18;
chr19 = load("chr19.mat").chr19;
chr20 = load("chr20.mat").chr20;
chr21 = load("chr21.mat").chr21;
chr22 = load("chr22.mat").chr22;
chrX = load("chrX.mat").chrX;
chrY = load("chrY.mat").chrY;
%% targets extraction
targets = {};
for i=1:size(train_table,1)
    window_size = 20;
    fold_energy_window = 0;
    cur_chrom = train_table{i,1};
    cur_start = train_table{i,2};
    cur_srand = train_table{i,3};
    temp_chrom = eval(cur_chrom);
    if cur_srand == '+'
        targets{i,1} = upper(temp_chrom(cur_start:cur_start+window_size-1));
        fold_help_seq{i,1} = upper(temp_chrom(cur_start-fold_energy_window:cur_start+fold_energy_window+window_size-1));
    elseif cur_srand == '-'
        targets{i,1} = upper(seqrcomplement(temp_chrom(cur_start:cur_start+window_size-1)));
        fold_help_seq{i,1} = upper(seqrcomplement(temp_chrom(cur_start-fold_energy_window:cur_start+fold_energy_window+window_size-1)));
    end
end
%% gRNA creation
grna = {};
for i = 1:length(targets)
    grna{i,1} = seqrcomplement(targets{i,1});
end
%% features generations
    %thermodynamics
        %folding energy
for i = 1:length(fold_help_seq)
    [~,fold_energy{i,1}] = rnafold(fold_help_seq{i});
end
        %meltng temp
for i = 1:length(grna)
    temp_par = oligoprop(grna{i});
    melt_temp{i,1} = temp_par.Tm(1);
end

    % Nucleotide composition
        %nuc_each_pos
nuc_pos_ohe = zeros(length(grna),4*20);
for i = 1:length(grna)
    cur_grna = grna{i};
    for j = 1:length(grna{i})
        if cur_grna(j) == 'A'
            nuc_pos_ohe(i,4*j-3) = nuc_pos_ohe(i,4*j-3) + 1;
        elseif cur_grna(j) == 'C'
            nuc_pos_ohe(i,4*j-2) = nuc_pos_ohe(i,4*j-2) + 1;
        elseif cur_grna(j) == 'G'
            nuc_pos_ohe(i,4*j-1) = nuc_pos_ohe(i,4*j-1) + 1;
        elseif cur_grna(j) == 'T'
            nuc_pos_ohe(i,4*j) = nuc_pos_ohe(i,4*j) + 1;
        end
    end
end
        % total_noc_count
for i = 1:length(grna)
    a_tot(i) = count(grna{i},'A');
    c_tot(i) = count(grna{i},'C');
    g_tot(i) = count(grna{i},'G');
    t_tot(i) = count(grna{i},'T');
end

     % total_dinuc_count
noc = {'A','C','G','T'};
[a,b] = ndgrid(noc,noc);
pos_pairs = strcat(a,b);
for i = 1:length(grna)
    for j = 1:length(pos_pairs)^2
        pair_count{i,j} = length(strfind(grna{i},pos_pairs{j}));
    end
end
        % total_triplets_count
noc = {'A','C','G','T'};
[a,b,c] = ndgrid(noc,noc,noc);
pos_triplets = strcat(a,b,c);
for i = 1:length(grna)
    for j = 1:length(pos_triplets)^3
        triplets_count(i,j) = length(strfind(grna{i},pos_triplets{j}));
    end
end
    %Gene distance + expression
dist = [];
closest = [];
genes1 = genes;
for j = 1:length(genes1)
    if genes1{j,4} == 69
        genes1{j,4} = "X";
    elseif genes1{j,4} == 6699
        genes1{j,4} = "Y";
    end
end
for i = 1:length(grna)
    closest_dist = inf;
    cur_chrom = train_table{i,1};
    g_s = train_table{i,2} + 9;
    closest_gene = [];
    for j = 1:size(genes1,1)
            j_s = genes1{j,2};
            j_e = genes1{j,3};
        if string(cur_chrom(4:end)) == string(genes1{j,4})
            d2s = abs(j_s - g_s);
            d2e = abs(j_e - g_s);
            if g_s >= j_s && g_s <= j_e
                closest_dist = 0;
                closest_gene = j;
                break
            end
            if d2s < closest_dist
                closest_dist = d2s;
                closest_gene = j;
            end
            if d2e < closest_dist
                closest_dist = d2e;
                closest_gene = j;
            end
        end
    end
    dist(i) = closest_dist;
    closest(i) = closest_gene;
    closest_id(i) = genes1{closest(i),8};
end

for i = 1:length(grna)
    help_idx = find(RPKM(:,1) == closest_id(i));
    if isempty(help_idx)
        closest_RPKM(i) = 0;
    else
        closest_RPKM(i) = RPKM(help_idx,2);
    end
end
    %RBCS
% 4008 sec,pre loaded
% for i = 1:length(grna)
%     id_list = [genes{:,8}];
%     beg_list = [genes{:,2}];
%     end_list = [genes{:,3}];
%     chrom_list = [genes1{:,4}];
%     cur_chrom = eval("chr" + string(chrom_list(closest(i))));
%     cur_gene = char(upper(string(cur_chrom(beg_list(closest(i)):end_list(closest(i))))));
% %   codon triplet normalized freq
%     d = [];
%     for k = 1:64
%         cur_triplet = pos_triplets{k};
%         trip_c = 0;
%         f_1_c = 0;
%         f_2_c = 0;
%         f_3_c = 0;
%         for j = 1:floor(length(cur_gene)/3)
%             trip_c = trip_c + strcmp(cur_gene(j*3-2:j*3),cur_triplet);
%             f_1_c = f_1_c + strcmp(cur_gene(j*3-2),cur_triplet(1));
%             f_2_c = f_2_c + strcmp(cur_gene(j*3-1),cur_triplet(2));
%             f_3_c = f_3_c + strcmp(cur_gene(j*3-0),cur_triplet(3));
% 
%         end
%         f_all = f_1_c*f_2_c*f_3_c/((floor(length(cur_gene)/3))^3);
%         d(k) = ((trip_c/floor(length(cur_gene)/3))-f_all)/f_all;
%     end
%     for j = 1:floor(length(cur_gene)/3)
%         for k = 1:64
%             if strcmp(cur_gene(j*3-2:j*3),pos_triplets{k})
%                 RCBS_tag_2(j) = log(d(k) + 1);
%                 break
%             end
%         end
%     end
%     L = (floor(length(cur_gene)/3));
%     RBCS_2(i) = (exp((1/L)*sum(RCBS_tag_2)))-1;
% end
RBCS_2 = load("RBCS_2.mat").RBCS_2;

    %nTE
% 801 sec
% total_trip_count_norm = sum(triplets_count)/max(sum(triplets_count));
% tRNA_count = [0 6 10 4 0 7 29 1 9 4 0 4 0 0 13 0 9 13 0 5 0 5 14 9 26 4 0 8 0 8 13 8 9 9 0 3 7 4 0 6 9 4 0 7 0 13 9 6 15 0 3 5 0 5 8 6 9 5 0 6 15 15 25 12];
% w_tai = tRNA_count/max(tRNA_count);
% nTE_tag = w_tai./total_trip_count_norm;
% nTE_tag(nTE_tag == 0) = nTE_tag(nTE_tag == 0) + 0.001;
% w_nTE = log(nTE_tag/max(nTE_tag));
% nTE = [];
% for i = 1:length(grna)
%     cur_chrom = eval("chr" + string(chrom_list(closest(i))));
%     cur_gene = char(upper(string(cur_chrom(beg_list(closest(i)):end_list(closest(i))))));
%     cur_trip_count = zeros(1,64);
%     for j = 1:floor(length(cur_gene)/3)
%         for k = 1:64
%             if strcmp(cur_gene(j*3-2:j*3),pos_triplets{k})
%                 cur_trip_count(k) = cur_trip_count(k) + 1;
%                 break
%             end
%         end
%     end
%     nTE(i) = exp(sum(w_nTE.*cur_trip_count)/length(cur_gene)); 
% end
nTE = load("nTE.mat").nTE;

  %chimera score
% % a lot of runtime !! 8 hours
% sorted_RPKM = sortrows(RPKM,2,'descend');
% sorted_RPKM = sorted_RPKM(1:5,:);
% chimera_ref = '';
% id_list = [genes{:,8}];
% beg_list = [genes{:,2}];
% end_list = [genes{:,3}];
% chrom_list = [genes1{:,4}];
% for i = 1:size(sorted_RPKM,1) %make reference genome from top 0.05% expressed genes
%     idx = find(id_list == sorted_RPKM(i,1),1);
%     if isempty(idx)
%         continue
%     end
%     cur_chrom = eval("chr" + string(chrom_list(idx)));
%     chimera_ref = chimera_ref + upper(string(cur_chrom(beg_list(idx):end_list(idx))));
% end
% chimera_ref = char(chimera_ref);
% 
% for i = 1:length(targets)
%     idx = find(id_list == closest_id(i),1);
%     cur_chrom = eval("chr" + string(chrom_list(idx)));
%     cur_target = char(upper(string(cur_chrom(beg_list(idx):end_list(idx)))));
%     pos_score = 0;
%     score_array = zeros(length(cur_target),2);
%     score_array(:,1) = 1:length(cur_target);
%     for pos = 1:length(cur_target)
%         mostly_20 = min([20,length(cur_target) - pos]);
%         for j = 1:mostly_20
%             cur_occ_times = length(strfind(chimera_ref,cur_target(pos:pos+j)));
%             if cur_occ_times == 0
%                 pos_score = j;
%                 break
%             end
%         end
%         score_array(pos,2) = pos_score;
%     end
%     chimera_ARS(i) = max(score_array(:,2));
% end


%% tree ensemble model training

%features
tr = table();
tr.a_tot = a_tot'; %total nuc:a
tr.c_tot = c_tot'; %total nuc:c
tr.g_tot = g_tot'; % ... g
tr.t_tot = t_tot'; % ... t
% pair count
for i = 1:size(pair_count,2)
    tr = [tr, table([pair_count{:,i}]')];
    tr.Properties.VariableNames{end} = char(string(pos_pairs{i}) + "_count");
end
tr.dist = dist'; %distance to closest gene
tr.RBCS_2 = RBCS_2'; %RBCS
tr.nTE = nTE'; %nTE
tr.closest_RPKM = closest_RPKM'; % gene expression of closest gene


traindata = cell2mat(table2cell(tr));
trainlabels = [train_table{:,5}]';

% Ensemble model training
ensemble = fitrensemble(traindata,trainlabels , ...
    'CrossVal','off',...
    'method','Bag', ...
    'NumLearningCycle', 250, ...
    'Learners',templateTree('MergeLeaves','on',...
    'Reproducible',true, ...
    'MaxNumCategories',100, ...
    'SplitCriterion','mse', ...
    'PredictorSelection','curvature'));
%% TESTING
test_table = table2cell(readtable('testing_data.csv'));
%% targets extraction
targets = {};
for i=1:size(test_table,1)
    window_size = 20;
    fold_energy_window = 0;
    cur_chrom = test_table{i,1};
    cur_start = test_table{i,2};
    cur_srand = test_table{i,3};
    temp_chrom = eval(cur_chrom);
    if cur_srand == '+'
        targets{i,1} = upper(temp_chrom(cur_start:cur_start+window_size-1));
        fold_help_seq{i,1} = upper(temp_chrom(cur_start-fold_energy_window:cur_start+fold_energy_window+window_size-1));
    elseif cur_srand == '-'
        targets{i,1} = upper(seqrcomplement(temp_chrom(cur_start:cur_start+window_size-1)));
        fold_help_seq{i,1} = upper(seqrcomplement(temp_chrom(cur_start-fold_energy_window:cur_start+fold_energy_window+window_size-1)));
    end
end
%% gRNA creation
grna = {};
for i = 1:length(targets)
    grna{i,1} = seqrcomplement(targets{i,1});
end
%% features
        % total_noc_count
for i = 1:length(grna)
    a_tot_test(i) = count(grna{i},'A');
    c_tot_test(i) = count(grna{i},'C');
    g_tot_test(i) = count(grna{i},'G');
    t_tot_test(i) = count(grna{i},'T');
end

     % total_dinuc_count
noc = {'A','C','G','T'};
[a,b] = ndgrid(noc,noc);
pos_pairs = strcat(a,b);
for i = 1:length(grna)
    for j = 1:length(pos_pairs)^2
        pair_count_test{i,j} = length(strfind(grna{i},pos_pairs{j}));
    end
end

    %Gene distance + expression
dist_test = [];
closest_test = [];
genes1 = genes;
for j = 1:length(genes1)
    if genes1{j,4} == 69
        genes1{j,4} = "X";
    elseif genes1{j,4} == 6699
        genes1{j,4} = "Y";
    end
end
for i = 1:length(grna)
    closest_dist = inf;
    cur_chrom = test_table{i,1};
    g_s = test_table{i,2} + 9;
    closest_gene = [];
    for j = 1:size(genes1,1)
            j_s = genes1{j,2};
            j_e = genes1{j,3};
        if string(cur_chrom(4:end)) == string(genes1{j,4})
            d2s = abs(j_s - g_s);
            d2e = abs(j_e - g_s);
            if g_s >= j_s && g_s <= j_e
                closest_dist = 0;
                closest_gene = j;
                break
            end
            if d2s < closest_dist
                closest_dist = d2s;
                closest_gene = j;
            end
            if d2e < closest_dist
                closest_dist = d2e;
                closest_gene = j;
            end
        end
    end
    dist_test(i) = closest_dist;
    closest_test(i) = closest_gene;
    closest_id_test(i) = genes1{closest(i),8};
end

for i = 1:length(grna)
    help_idx = find(RPKM(:,1) == closest_id_test(i));
    if isempty(help_idx)
        closest_RPKM_test(i) = 0;
    else
        closest_RPKM_test(i) = RPKM(help_idx,2);
    end
end

    %RBCS
% for i = 1:length(grna)
%     disp(i)
%     id_list = [genes{:,8}];
%     beg_list = [genes{:,2}];
%     end_list = [genes{:,3}];
%     chrom_list = [genes1{:,4}];
%     cur_chrom = eval("chr" + string(chrom_list(closest_test(i))));
%     cur_gene = char(upper(string(cur_chrom(beg_list(closest_test(i)):end_list(closest_test(i))))));
% %   codon triplet normalized freq
%     d = [];
%     for k = 1:64
%         cur_triplet = pos_triplets{k};
%         trip_c = 0;
%         f_1_c = 0;
%         f_2_c = 0;
%         f_3_c = 0;
%         for j = 1:floor(length(cur_gene)/3)
%             trip_c = trip_c + strcmp(cur_gene(j*3-2:j*3),cur_triplet);
%             f_1_c = f_1_c + strcmp(cur_gene(j*3-2),cur_triplet(1));
%             f_2_c = f_2_c + strcmp(cur_gene(j*3-1),cur_triplet(2));
%             f_3_c = f_3_c + strcmp(cur_gene(j*3-0),cur_triplet(3));
% 
%         end
%         f_all = f_1_c*f_2_c*f_3_c/((floor(length(cur_gene)/3))^3);
%         d(k) = ((trip_c/floor(length(cur_gene)/3))-f_all)/f_all;
%     end
%     for j = 1:floor(length(cur_gene)/3)
%         for k = 1:64
%             if strcmp(cur_gene(j*3-2:j*3),pos_triplets{k})
%                 RCBS_tag_2_test(j) = log(d(k) + 1);
%                 break
%             end
%         end
%     end
%     L = (floor(length(cur_gene)/3));
%     RBCS_2_test(i) = (exp((1/L)*sum(RCBS_tag_2_test)))-1;
% end
% save RBCS_2_test.mat RBCS_2_test
RBCS_2_test = load("RBCS_2_test.mat").RBCS_2_test;

    %nTE
% total_trip_count_norm = sum(triplets_count)/max(sum(triplets_count));
% tRNA_count = [0 6 10 4 0 7 29 1 9 4 0 4 0 0 13 0 9 13 0 5 0 5 14 9 26 4 0 8 0 8 13 8 9 9 0 3 7 4 0 6 9 4 0 7 0 13 9 6 15 0 3 5 0 5 8 6 9 5 0 6 15 15 25 12];
% w_tai = tRNA_count/max(tRNA_count);
% nTE_tag = w_tai./total_trip_count_norm;
% nTE_tag(nTE_tag == 0) = nTE_tag(nTE_tag == 0) + 0.001;
% w_nTE = log(nTE_tag/max(nTE_tag));
% nTE_test = [];
% for i = 1:length(grna)
%     disp(i)
%     cur_chrom = eval("chr" + string(chrom_list(closest_test(i))));
%     cur_gene = char(upper(string(cur_chrom(beg_list(closest_test(i)):end_list(closest_test(i))))));
%     cur_trip_count = zeros(1,64);
%     for j = 1:floor(length(cur_gene)/3)
%         for k = 1:64
%             if strcmp(cur_gene(j*3-2:j*3),pos_triplets{k})
%                 cur_trip_count(k) = cur_trip_count(k) + 1;
%                 break
%             end
%         end
%     end
%     nTE_test(i) = exp(sum(w_nTE.*cur_trip_count)/length(cur_gene)); 
% end
%   save nTE_test.mat nTE_test
nTE_test = load("nTE_test.mat").nTE_test;

%% prepare parameters for model
%features
tr_test = table();
tr_test.a_tot_test = a_tot_test'; %total nuc:a
tr_test.c_tot_test = c_tot_test'; %total nuc:c
tr_test.g_tot_test = g_tot_test'; % ... g
tr_test.t_tot_test = t_tot_test'; % ... t
% nucleotides at each position in the target sequence one_hot_encoding
for i = 1:size(pair_count_test,2)
    tr_test = [tr_test, table([pair_count_test{:,i}]')];
    tr_test.Properties.VariableNames{end} = char(string(pos_pairs{i}) + "_count");
end
tr_test.dist_test = dist_test'; %distance to closest gene
tr_test.RBCS_2_test = RBCS_2_test'; %RBCS
tr_test.nTE_test = nTE_test'; %nTE
tr_test.closest_RPKM_test = closest_RPKM_test'; % gene expression of closest gene
testdata = cell2mat(table2cell(tr_test));

%% prediction
eff = predict(ensemble,testdata);

submit_table = cell2table(test_table);
submit_table.Chaimovsky_Bendavid_eff = eff;

writetable(submit_table,'prediction_table.csv')

