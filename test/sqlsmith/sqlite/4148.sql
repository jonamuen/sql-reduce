select  
  ref_1.name as c0
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on ((ref_0.id is not NULL) 
        and (((ref_0.id is NULL) 
            and (1)) 
          and (ref_0.id is not NULL)))
where (ref_0.id is not NULL) 
  and (1)
limit 93;
