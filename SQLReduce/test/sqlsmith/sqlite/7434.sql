insert into main.t0 values (
cast(null as INT), 
case when ((((0) 
          and (3 is NULL)) 
        and (87 is NULL)) 
      or (EXISTS (
        select  
            ref_0.id as c0
          from 
            main.t0 as ref_0
          where (ref_0.id is NULL) 
            and (ref_0.name is not NULL)
          limit 86))) 
    and ((90 is NULL) 
      or (1)) then cast(null as VARCHAR(16)) else cast(null as VARCHAR(16)) end
  );
