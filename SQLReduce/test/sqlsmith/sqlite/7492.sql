select  
  ref_0.id as c0, 
  cast(coalesce((select name from main.t0 limit 1 offset 2)
      ,
    ref_0.name) as VARCHAR(16)) as c1, 
  ref_0.id as c2, 
  case when ref_0.id is NULL then cast(nullif(ref_0.id,
      ref_0.id) as INT) else cast(nullif(ref_0.id,
      ref_0.id) as INT) end
     as c3
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  and ((ref_0.id is not NULL) 
    and ((ref_0.id is NULL) 
      and ((ref_0.id is not NULL) 
        and ((((ref_0.name is NULL) 
              or (1)) 
            and (ref_0.id is not NULL)) 
          and ((((ref_0.name is NULL) 
                or ((1) 
                  or (0))) 
              or ((ref_0.name is NULL) 
                or (ref_0.name is NULL))) 
            and (((1) 
                and (ref_0.id is NULL)) 
              or (ref_0.id is NULL)))))))
limit 90;
