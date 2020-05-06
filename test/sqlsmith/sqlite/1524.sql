select  
  cast(nullif(ref_0.id,
    ref_0.id) as INT) as c0, 
  ref_0.id as c1, 
  cast(nullif(case when (EXISTS (
          select  
              ref_1.name as c0, 
              ref_0.id as c1, 
              ref_0.name as c2, 
              ref_0.id as c3
            from 
              main.t0 as ref_1
            where (1) 
              and (0)
            limit 81)) 
        and ((ref_0.name is NULL) 
          or ((1) 
            or ((select id from main.t0 limit 1 offset 4)
                 is not NULL))) then ref_0.id else ref_0.id end
      ,
    ref_0.id) as INT) as c2, 
  ref_0.id as c3, 
  case when 0 then ref_0.name else ref_0.name end
     as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7
from 
  main.t0 as ref_0
where case when 0 then ref_0.name else ref_0.name end
     is NULL
limit 122;
