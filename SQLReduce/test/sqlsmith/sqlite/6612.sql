select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  case when ((1) 
        or ((0) 
          and ((0) 
            or (((ref_0.name is not NULL) 
                and (ref_0.name is NULL)) 
              and (1))))) 
      and ((1) 
        and ((ref_0.id is not NULL) 
          and (ref_0.id is NULL))) then ref_0.id else ref_0.id end
     as c2, 
  case when ((select id from main.t0 limit 1 offset 5)
           is NULL) 
      or (ref_0.id is NULL) then ref_0.id else ref_0.id end
     as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  (select name from main.t0 limit 1 offset 44)
     as c9, 
  ref_0.name as c10, 
  ref_0.name as c11, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c12
from 
  main.t0 as ref_0
where ((ref_0.id is NULL) 
    and (0)) 
  and (1)
limit 132;
