function pred_p = pred_cov(sigma_pt_prop,pred_s,n,k)
pred_p = zeros(8,8);
for i=2 : 17
pred_p = pred_p + 0.5 * (sigma_pt_prop(:,i)-pred_s)*(sigma_pt_prop(:,i)-pred_s)';
end
pred_p = (pred_p + k * (sigma_pt_prop(:,1)-pred_s)*(sigma_pt_prop(:,1)-pred_s)') / (n+k);
end