function pred_s = pred_states(sigma_pt_prop,n,k)
pred_s = [0;
          0;
          0;
          0;
          0;
          0;
          0;
          0];
for i=2:17
pred_s = pred_s + 0.5*(sigma_pt_prop(:,i)); 
end
pred_s = (pred_s + (k * sigma_pt_prop(:,1)))/ (n+k);
end