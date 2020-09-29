function pred_p_xy = pred_cov_xy(sigma_pt_prop,pred_s,psu_sigma,pred_mes,n,k)
pred_p_xy = zeros(8,8);
for i=2 : 17
pred_p_xy = pred_p_xy + 0.5 * ((sigma_pt_prop(:,i)-pred_s)*(psu_sigma(:,i)-pred_mes)');
end
pred_p_xy = (pred_p_xy + k * (sigma_pt_prop(:,1)-pred_s)*(psu_sigma(:,1)-pred_mes)') / (n+k);
end