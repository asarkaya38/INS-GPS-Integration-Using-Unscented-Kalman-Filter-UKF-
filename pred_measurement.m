function pred_mes = pred_measurement(psu_sigma,n,k)
pred_mes = [0;
          0;
          0;
          0;
          0;
          0;
          0;
          0];
for i=2:17
pred_mes = pred_mes + 0.5*(psu_sigma(:,i)); 
end
pred_mes = (pred_mes + (k * psu_sigma(:,1)))/ (n+k);
end