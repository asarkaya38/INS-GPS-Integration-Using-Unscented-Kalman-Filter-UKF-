function pred_p_yy = pred_cov_yy(psu_sigma,pred_mes,n,k)
pred_p_yy = zeros(8,8);
for i=2 : 17
pred_p_yy = pred_p_yy + 0.5 * (psu_sigma(:,i)-pred_mes)*(psu_sigma(:,i)-pred_mes)';
end
pred_p_yy = (pred_p_yy + k * (psu_sigma(:,1)-pred_mes)*(psu_sigma(:,1)-pred_mes)') / (n+k);
end