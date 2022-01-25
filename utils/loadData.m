function loadData()
    addpath("~/.ros")
    
    global q ref_q q_d 
    global p ref_p p_d
    global r ref_r r_d
    global ft
    global c ref_c c_d c_r
    global foot_acc foot_acc_lpf

    q = load("q.txt");
    ref_q = load("ref_q.txt");
    
    q_d = load("q_d.txt");
    
    p = load("p.txt");
    r = load("r.txt");
    
    p_d = load("p_d.txt");
    r_d = load("r_d.txt");
    
    ref_p = load("ref_p.txt");
    ref_r = load("ref_r.txt");
    
    ft = load("f.txt");
    % q_dd = load("q_dd.txt");
    
    c = load("c.txt");
    ref_c = load("ref_c.txt");
    
    c_d = load("c_d.txt");

    c_r = load("com_r.txt");

    foot_acc = load("foot_acc.txt");
    foot_acc_lpf = load("foot_acc_lpf.txt");

end