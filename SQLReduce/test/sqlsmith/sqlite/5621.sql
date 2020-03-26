select  
  ref_1.name as c0, 
  cast(nullif(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c1, 
  subq_0.c0 as c2
from 
  (select  
          ref_0.name as c0
        from 
          main.t0 as ref_0
        where (((0) 
              or (1)) 
            or (ref_0.id is NULL)) 
          and (ref_0.name is not NULL)
        limit 105) as subq_0
    inner join main.t0 as ref_1
    on ((1) 
        and (ref_1.id is not NULL))
where subq_0.c0 is NULL
limit 155;
