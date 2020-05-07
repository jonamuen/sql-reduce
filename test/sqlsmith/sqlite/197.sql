select  
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where (((((ref_0.id is NULL) 
          and (0)) 
        or ((1) 
          and (ref_0.id is not NULL))) 
      or ((ref_0.name is NULL) 
        or (((1) 
            or ((1) 
              or (ref_0.name is NULL))) 
          and (ref_0.name is not NULL)))) 
    or (EXISTS (
      select  
          (select id from main.t0 limit 1 offset 6)
             as c0, 
          ref_0.id as c1
        from 
          main.t0 as ref_1
        where 0
        limit 174))) 
  and (((1) 
      or (1)) 
    and ((ref_0.name is not NULL) 
      or ((1) 
        or ((0) 
          and ((((EXISTS (
                  select  
                      ref_0.id as c0, 
                      ref_0.name as c1, 
                      (select name from main.t0 limit 1 offset 2)
                         as c2, 
                      ref_0.id as c3, 
                      ref_0.name as c4, 
                      ref_2.name as c5, 
                      ref_2.name as c6, 
                      ref_2.name as c7, 
                      ref_2.name as c8, 
                      ref_0.id as c9, 
                      ref_0.id as c10, 
                      ref_2.name as c11, 
                      ref_2.name as c12, 
                      ref_0.id as c13, 
                      ref_0.id as c14, 
                      ref_2.id as c15, 
                      ref_2.name as c16
                    from 
                      main.t0 as ref_2
                    where 0
                    limit 85)) 
                and (ref_0.id is NULL)) 
              or (ref_0.id is not NULL)) 
            or ((ref_0.id is not NULL) 
              or (ref_0.id is not NULL)))))))
limit 87;
