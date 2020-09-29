function psu_sigma = obser_sigma_pt(sigma_pt_prop,p_s1,p_s2,p_s3,p_s4,v_s1,v_s2,v_s3,v_s4,i)
if i == 1
    c = 1;
else
    c = (i - 1) / 10 + 1;
end
for j=1 : 17
            psu_sigma(1,j)  = ((p_s1(c,1)-sigma_pt_prop(1,j))^2 + (p_s1(c,2)-sigma_pt_prop(2,j))^2 + (p_s1(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(7,j);
            psu_sigma(2,j)  = ((p_s2(c,1)-sigma_pt_prop(1,j))^2 + (p_s2(c,2)-sigma_pt_prop(2,j))^2 + (p_s2(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(7,j);
            psu_sigma(3,j)  = ((p_s3(c,1)-sigma_pt_prop(1,j))^2 + (p_s3(c,2)-sigma_pt_prop(2,j))^2 + (p_s3(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(7,j);
            psu_sigma(4,j)  = ((p_s4(c,1)-sigma_pt_prop(1,j))^2 + (p_s4(c,2)-sigma_pt_prop(2,j))^2 + (p_s4(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(7,j);
            psu_sigma(5,j) = ((p_s1(c,1)-sigma_pt_prop(1,j))*(v_s1(c,1)-sigma_pt_prop(4,j)) + (p_s1(c,2)-sigma_pt_prop(2,j))*(v_s1(c,2)-sigma_pt_prop(5,j)) + (p_s1(c,3)-sigma_pt_prop(3,j))*(v_s1(c,3)-sigma_pt_prop(6,j))) / ((p_s1(c,1)-sigma_pt_prop(1,j))^2 + (p_s1(c,2)-sigma_pt_prop(2,j))^2 + (p_s1(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(8,j);
            psu_sigma(6,j) = ((p_s2(c,1)-sigma_pt_prop(1,j))*(v_s2(c,1)-sigma_pt_prop(4,j)) + (p_s2(c,2)-sigma_pt_prop(2,j))*(v_s2(c,2)-sigma_pt_prop(5,j)) + (p_s2(c,3)-sigma_pt_prop(3,j))*(v_s2(c,3)-sigma_pt_prop(6,j))) / ((p_s2(c,1)-sigma_pt_prop(1,j))^2 + (p_s2(c,2)-sigma_pt_prop(2,j))^2 + (p_s2(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(8,j);
            psu_sigma(7,j) = ((p_s3(c,1)-sigma_pt_prop(1,j))*(v_s3(c,1)-sigma_pt_prop(4,j)) + (p_s3(c,2)-sigma_pt_prop(2,j))*(v_s3(c,2)-sigma_pt_prop(5,j)) + (p_s3(c,3)-sigma_pt_prop(3,j))*(v_s3(c,3)-sigma_pt_prop(6,j))) / ((p_s3(c,1)-sigma_pt_prop(1,j))^2 + (p_s3(c,2)-sigma_pt_prop(2,j))^2 + (p_s3(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(8,j);
            psu_sigma(8,j) = ((p_s4(c,1)-sigma_pt_prop(1,j))*(v_s4(c,1)-sigma_pt_prop(4,j)) + (p_s4(c,2)-sigma_pt_prop(2,j))*(v_s4(c,2)-sigma_pt_prop(5,j)) + (p_s4(c,3)-sigma_pt_prop(3,j))*(v_s4(c,3)-sigma_pt_prop(6,j))) / ((p_s4(c,1)-sigma_pt_prop(1,j))^2 + (p_s4(c,2)-sigma_pt_prop(2,j))^2 + (p_s4(c,3)-sigma_pt_prop(3,j))^2)^0.5 + sigma_pt_prop(8,j);
  end
end
