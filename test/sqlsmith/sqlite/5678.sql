select  
  case when (1) 
      and (ref_0.name is NULL) then ref_0.name else ref_0.name end
     as c0, 
  case when 0 then ref_0.id else ref_0.id end
     as c1
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.id as c0, 
      cast(nullif(cast(nullif(ref_1.id,
          ref_0.id) as INT),
        ref_0.id) as INT) as c1, 
      ref_0.id as c2, 
      ref_0.name as c3, 
      ref_1.id as c4, 
      (select name from main.t0 limit 1 offset 5)
         as c5, 
      ref_1.name as c6, 
      ref_0.id as c7, 
      ref_1.name as c8, 
      ref_0.id as c9, 
      ref_1.id as c10, 
      ref_0.name as c11, 
      ref_0.name as c12, 
      ref_0.name as c13
    from 
      main.t0 as ref_1
    where (1) 
      and ((select id from main.t0 limit 1 offset 6)
           is NULL)
    limit 92)
limit 60;
