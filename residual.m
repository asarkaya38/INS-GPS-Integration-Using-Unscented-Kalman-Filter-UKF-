function e = residual(me_psu_r1,me_psu_r2,me_psu_r3,me_psu_r4,me_psu_rr1,me_psu_rr2,me_psu_rr3,me_psu_rr4,pred_mes,i)
if i == 1
    c = 1;
else
    c = (i - 1) / 10 + 1;
end
y_k = [me_psu_r1() me_psu_r2 me_psu_r3 me_psu_r4 me_psu_rr1 me_psu_rr2 me_psu_rr3 me_psu_rr4]';
e   = y_k(:,c)- pred_mes;
end