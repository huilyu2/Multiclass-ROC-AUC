
function auc = simulate_pair_tri_score(mus)
% define each density function f_ij
f11 = @(x) normpdf(x, mus(1), 1); % mu max
f12 = @(x) normpdf(x, mus(2), 1);
f13 = @(x) normpdf(x, mus(3), 1);

f21 = @(x) normpdf(x, mus(4), 1);
f22 = @(x) normpdf(x, mus(5), 1); % mu max
f23 = @(x) normpdf(x, mus(6), 1);

f31 = @(x) normpdf(x, mus(7), 1);
f32 = @(x) normpdf(x, mus(8), 1); 
f33 = @(x) normpdf(x, mus(9), 1); % mu max]

% number of classes
c = 3;

% function passed to the double integral
func_12 = @(T_, T) double(T_ > T) .* f11(T_) .* f12(T);
func_21 = @(T_, T) double(T_ > T) .* f22(T_) .* f21(T);

func_13 = @(T_, T) double(T_ > T) .* f11(T_) .* f13(T);
func_31 = @(T_, T) double(T_ > T) .* f33(T_) .* f31(T);

func_23 = @(T_, T) double(T_ > T) .* f22(T_) .* f23(T);
func_32 = @(T_, T) double(T_ > T) .* f33(T_) .* f32(T);

% pairwise AUC
% q = integral2(func, xmin, xmax, ymin, ymax); 
auc = 1/(c*(c-1)) * ...
    (integral2(func_12, -Inf, Inf, -Inf, Inf) + ...
     integral2(func_21, -Inf, Inf, -Inf, Inf) + ...
     integral2(func_13, -Inf, Inf, -Inf, Inf) + ...
     integral2(func_31, -Inf, Inf, -Inf, Inf) + ...
     integral2(func_23, -Inf, Inf, -Inf, Inf) + ...
     integral2(func_32, -Inf, Inf, -Inf, Inf));
end

 