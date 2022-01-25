function [t, start_idx, end_idx] = setTime(walking_start, walking_end, hz)
    start_idx = walking_start/0.0005;
    end_idx = walking_end/0.0005;
    
    t_max = (end_idx-start_idx-1)/hz; %(length(q)-1)*0.0005;
    t = 0:1/hz:t_max;
    
end