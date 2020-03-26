insert into main.t0 values (
cast(null as INT), 
case when ((13 is NULL) 
      or ((12 is not NULL) 
        or (7 is not NULL))) 
    or (68 is not NULL) then cast(null as VARCHAR(16)) else cast(null as VARCHAR(16)) end
  );
