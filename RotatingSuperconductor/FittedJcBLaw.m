if(Temperature==77)
    bmax_m = ones(1,nbSudyval)*2.4;
    jc_1  = ones(1,nbSudyval)*9.92104*1e8;
    n_1   = ones(1,nbSudyval)*20;
    jc0_1 = ones(1,nbSudyval)*9.92104*1e8;
    n1_1  = ones(1,nbSudyval)*20;
    n0_1  = n1_1;
    B0_1    = ones(1,nbSudyval)*0.125829;

    aFE_1    = ones(1,nbSudyval)*7.97279;
    B1FE_1    = ones(1,nbSudyval)*15.1312;
    B2FE_1    = ones(1,nbSudyval)*9.95767;
    if(Flag_JcB==0)
        jc_1  = ones(1,nbSudyval)*2*1e8;
        n_1   = ones(1,nbSudyval)*20;
    end
elseif(Temperature==70)
    bmax_m = ones(1,nbSudyval)*8;
    jc_1  = ones(1,nbSudyval)*10.8085*1e8;
    n_1   = ones(1,nbSudyval)*20;
    jc0_1 = ones(1,nbSudyval)*10.8085*1e8;
    n1_1  = ones(1,nbSudyval)*20;
    n0_1  = n1_1;
    B0_1    = ones(1,nbSudyval)*0.24934;

    aFE_1    = ones(1,nbSudyval)*17.6562;
    B1FE_1    = ones(1,nbSudyval)*12.4687;
    B2FE_1    = ones(1,nbSudyval)*9.92377;
elseif(Temperature==65)
    bmax_m = ones(1,nbSudyval)*8;
    jc_1  = ones(1,nbSudyval)*13.7039*1e8;
    n_1   = ones(1,nbSudyval)*20;
    jc0_1 = ones(1,nbSudyval)*13.7039*1e8;
    n1_1  = ones(1,nbSudyval)*20;
    n0_1  = n1_1;
    B0_1    = ones(1,nbSudyval)*0.306926;

    aFE_1    = ones(1,nbSudyval)*35.1051;
    B1FE_1    = ones(1,nbSudyval)*13.0254;
    B2FE_1    = ones(1,nbSudyval)*11.1213;
    if(Flag_JcB==0)
        jc_1  = ones(1,nbSudyval)*5*1e8;
        n_1   = ones(1,nbSudyval)*20;
    end
elseif(Temperature==59)
    bmax_m = ones(1,nbSudyval)*14;
    jc_1  = ones(1,nbSudyval)*19.3299*1e8;
    n_1   = ones(1,nbSudyval)*20;
    jc0_1 = ones(1,nbSudyval)*19.3299*1e8;
    n1_1  = ones(1,nbSudyval)*20;
    n0_1  = n1_1;
    B0_1    = ones(1,nbSudyval)*0.274045;

    aFE_1    = ones(1,nbSudyval)*94.3455;
    B1FE_1    = ones(1,nbSudyval)*17.3794;
    B2FE_1    = ones(1,nbSudyval)*16.7355;
    if(Flag_JcB==0)
        jc_1  = ones(1,nbSudyval)*8*1e8;
        n_1   = ones(1,nbSudyval)*20;
    end
end