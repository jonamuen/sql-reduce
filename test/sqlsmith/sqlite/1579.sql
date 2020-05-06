select  
  ref_0.name as c0
from 
  main.t0 as ref_0
    inner join (select  
          ref_1.id as c0, 
          ref_1.name as c1
        from 
          main.t0 as ref_1
        where (1) 
          or (ref_1.id is NULL)) as subq_0
    on (0)
where (0) 
  or (1)
limit 106;
