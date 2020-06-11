select  
  ref_0.name as c0, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where (((ref_0.id is NULL) 
      or ((((1) 
            and (0)) 
          or (1)) 
        and ((ref_0.id is NULL) 
          and (0)))) 
    and (ref_0.name is not NULL)) 
  or (EXISTS (
    select distinct 
        ref_1.name as c0, 
        (select id from main.t0 limit 1 offset 6)
           as c1, 
        ref_1.id as c2, 
        ref_0.name as c3, 
        (select name from main.t0 limit 1 offset 2)
           as c4
      from 
        main.t0 as ref_1
      where 0
      limit 147))
limit 135;
