% separabilty experiments
% Given Different separability settings and compute ovr/pairwise auc

close = [[1.5 1.25 1];[1 1.5 1.25];[1 1.25 1.5]];
sep1 = [[5 3 1];[1 5 3];[1 3 5]];
sep2 = [[5 2 1];[1 5 2];[1 2 5]];
sep3 = [[5 4 1];[1 5 4];[1 4 5]];
setting_table = [close; sep1; sep2; sep3];
cases = nmultichoosek(1:4,3);

ovr_auc = zeros(length(cases),1);
pair_auc = zeros(length(cases),1);
ps = [1/4, 1/4, 1/2];

for i  = 1:length(cases)
    this_case = cases(i, :)*3-[2 1 0];
    sprintf('%d', i)
    disp(this_case)
    mus = reshape(setting_table(this_case, :).', 9, 1);
    ovr_auc(i) = simulate_ovr_tri_score(mus, ps);
    sprintf('one vs all AUC: %.4f', ovr_auc(i))
    pair_auc(i) = simulate_pair_tri_score(mus);
    sprintf('pairwise AUC: %.4f', pair_auc(i))
end

save('setting_table.mat', setting_table)
save('cases.mat', cases)
save('ovr_auc.mat', ovr_auc)
save('pair_auc.mat', pair_auc)


%case_idx = 7;
%over_the_case = cases(case_idx, :)*3-[2 1 0];
%mus = reshape(setting_table(over_the_case, :).', 9, 1);
%p12 = 2/3;
%p3 = 1/3;

%p1 = 0;
%p2 = 2/3;
%p3 = 1/3;
%ps = [p1 p2 p3];
%sprintf('one vs all AUC: %.4f', simulate_ovr_tri_score(mus, ps))
%sprintf('pairwise AUC: %.4f', simulate_pair_tri_score(mus))


%for i = 1:20
%    p1 = p12*i*0.05;
%    p2 = p12*(20-i)*0.05;
%    ps = [p1 p2 p3];
%    sprintf('%d: ps = [%.4f, %.4f, %.4f]', i, p1, p2, p3)
%    ovr_auc(i) = simulate_ovr_tri_score(mus, ps);
%    sprintf('one vs all AUC: %.4f', ovr_auc(i))
%    pair_auc(i) = simulate_pair_tri_score(mus);
%    sprintf('pairwise AUC: %.4f', pair_auc(i))
%end













