    function sigma_pt_prop = sigma_prop(sigma_pt,a_R,i)
    A = [1 0 0 0.1 0   0   0   0;
         0 1 0 0   0.1 0   0   0;
         0 0 1 0   0   0.1 0   0;
         0 0 0 1   0   0   0   0;
         0 0 0 0   1   0   0   0;
         0 0 0 0   0   1   0   0;
         0 0 0 0   0   0   1   0;
         0 0 0 0   0   0   0   1];
     B = [0     0     0;
          0     0     0;
          0     0     0;
          0.1   0     0;
          0     0.1   0;
          0     0     0.1;
          0     0     0;
          0     0     0];
      a_R = a_R';
      B   = B * a_R(:,i);
      
      sigma_pt_prop = [(A * sigma_pt(:,1) + B) (A * sigma_pt(:,2) + B) (A * sigma_pt(:,3) + B) (A * sigma_pt(:,4) + B) (A * sigma_pt(:,5) + B) (A * sigma_pt(:,6) + B) (A * sigma_pt(:,7) + B) (A * sigma_pt(:,8) + B)...
           (A * sigma_pt(:,9) + B) (A * sigma_pt(:,10) + B) (A * sigma_pt(:,11) + B) (A * sigma_pt(:,12) + B) (A * sigma_pt(:,13) + B) (A * sigma_pt(:,14) + B) (A * sigma_pt(:,15) + B) (A * sigma_pt(:,16) + B) (A * sigma_pt(:,16) + B)];
