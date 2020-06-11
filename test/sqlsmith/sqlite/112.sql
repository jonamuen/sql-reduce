insert into main.t0 values (
cast(null as INT), 
case when ((1 is not NULL) 
      or ((EXISTS (
          select  
              ref_0.name as c0, 
              (select id from main.t0 limit 1 offset 1)
                 as c1, 
              ref_0.name as c2, 
              ref_0.id as c3, 
              ref_0.id as c4
            from 
              main.t0 as ref_0
            where 1
            limit 132)) 
        or ((((30 is not NULL) 
              or ((1) 
                or (((50 is not NULL) 
                    and ((0) 
                      and (0))) 
                  and (77 is NULL)))) 
            and (((1) 
                or (57 is NULL)) 
              and (63 is not NULL))) 
          or (36 is NULL)))) 
    and ((72 is NULL) 
      and (57 is not NULL)) then cast(null as VARCHAR(16)) else cast(null as VARCHAR(16)) end
  );
