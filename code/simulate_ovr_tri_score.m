
function auc = simulate_ovr_tri_score(mus, ps)
% define each density function f_ij
f11 = @(x) normpdf(x, mus(1), 1); % mu max
f12 = @(x) normpdf(x, mus(2), 1);
f13 = @(x) normpdf(x, mus(3), 1);

f21 = @(x) normpdf(x, mus(4), 1);
f22 = @(x) normpdf(x, mus(5), 1); % mu max
f23 = @(x) normpdf(x, mus(6), 1);

f31 = @(x) normpdf(x, mus(7), 1);
f32 = @(x) normpdf(x, mus(8), 1);
f33 = @(x) normpdf(x, mus(9), 1); % mu max

% number of classes
c = 3;

% function passed to double integral
func_1 = @(T_, T) double(T_ > T) .* f11(T_) .* ((f12(T) + f13(T)) ./ 2);
func_2 = @(T_, T) double(T_ > T) .* f22(T_) .* ((f21(T) + f23(T)) ./ 2);
func_3 = @(T_, T) double(T_ > T) .* f33(T_) .* ((f31(T) + f32(T)) ./ 2);

% one-vs-rest AUC
auc = ( ...
    ps(1) * integral2(func_1, -Inf, Inf, -Inf, Inf) + ...
    ps(2) * integral2(func_2, -Inf, Inf, -Inf, Inf) + ...
    ps(3) * integral2(func_3, -Inf, Inf, -Inf, Inf) );
end


