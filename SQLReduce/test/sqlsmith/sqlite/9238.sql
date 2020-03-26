select  
  cast(nullif(ref_0.id,
    case when (((((ref_0.name is NULL) 
                and (1)) 
              or (1)) 
            and (ref_0.id is NULL)) 
          and (ref_0.name is NULL)) 
        and ((ref_0.name is not NULL) 
          and (ref_0.name is not NULL)) then case when 0 then ref_0.id else ref_0.id end
         else case when 0 then ref_0.id else ref_0.id end
         end
      ) as INT) as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  ref_0.name as c9, 
  ref_0.id as c10, 
  ref_0.id as c11, 
  ref_0.name as c12, 
  ref_0.name as c13
from 
  main.t0 as ref_0
where case when 1 then ref_0.id else ref_0.id end
     is NULL;
