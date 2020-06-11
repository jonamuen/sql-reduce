select  
  (select name from main.t0 limit 1 offset 5)
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  (select id from main.t0 limit 1 offset 6)
     as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.name as c9, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c10, 
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c11, 
  case when (0) 
      or (1) then ref_0.id else ref_0.id end
     as c12, 
  ref_0.id as c13
from 
  main.t0 as ref_0
where (((0) 
      and (ref_0.id is not NULL)) 
    or ((select name from main.t0 limit 1 offset 20)
         is NULL)) 
  and ((((1) 
        and (((1) 
            and (0)) 
          and (0))) 
      or (((EXISTS (
            select  
                ref_0.id as c0, 
                ref_1.name as c1, 
                ref_0.id as c2, 
                ref_1.name as c3, 
                ref_0.name as c4, 
                ref_1.id as c5, 
                ref_0.id as c6, 
                ref_1.id as c7, 
                ref_1.name as c8, 
                ref_0.name as c9, 
                ref_1.id as c10, 
                ref_0.name as c11, 
                ref_0.id as c12, 
                ref_1.id as c13, 
                ref_1.name as c14, 
                ref_1.id as c15, 
                ref_0.name as c16, 
                ref_0.name as c17, 
                (select id from main.t0 limit 1 offset 1)
                   as c18, 
                ref_0.name as c19, 
                ref_1.id as c20
              from 
                main.t0 as ref_1
              where (ref_1.name is NULL) 
                and ((select id from main.t0 limit 1 offset 2)
                     is not NULL)
              limit 79)) 
          and (((select name from main.t0 limit 1 offset 75)
                 is NULL) 
            or (1))) 
        and (((39 is not NULL) 
            or (((((ref_0.id is not NULL) 
                    and (1)) 
                  and (ref_0.name is NULL)) 
                and (ref_0.name is not NULL)) 
              and (((0) 
                  and (EXISTS (
                    select  
                        ref_0.name as c0, 
                        ref_2.name as c1, 
                        ref_0.name as c2
                      from 
                        main.t0 as ref_2
                      where 1))) 
                and (ref_0.name is not NULL)))) 
          or (1)))) 
    and (ref_0.id is NULL))
limit 43;
