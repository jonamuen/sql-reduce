select  
  (select name from main.t0 limit 1 offset 6)
     as c0
from 
  (select  
        cast(nullif(13,
          8) as INTEGER) as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5
      from 
        main.t0 as ref_0
      where (0) 
        or (ref_0.name is NULL)
      limit 43) as subq_0
where 0;
