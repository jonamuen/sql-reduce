select  
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c0, 
  ref_0.name as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
where ((0) 
    and (((1) 
        or (53 is not NULL)) 
      and ((1) 
        or ((1) 
          or (ref_0.id is not NULL))))) 
  and ((ref_0.id is not NULL) 
    and (EXISTS (
      select  
          ref_0.name as c0, 
          ref_0.id as c1, 
          ref_1.name as c2, 
          ref_0.name as c3, 
          ref_0.name as c4, 
          ref_0.name as c5, 
          ref_0.name as c6, 
          ref_0.id as c7, 
          ref_1.id as c8, 
          (select id from main.t0 limit 1 offset 94)
             as c9, 
          ref_0.id as c10
        from 
          main.t0 as ref_1
        where 1
        limit 77)))
limit 146;
