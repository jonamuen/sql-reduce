select  
  subq_1.c0 as c0, 
  subq_1.c0 as c1, 
  subq_1.c0 as c2, 
  subq_1.c1 as c3
from 
  (select  
        subq_0.c6 as c0, 
        ref_1.name as c1
      from 
        (select  
                ref_0.id as c0, 
                ref_0.id as c1, 
                ref_0.id as c2, 
                ref_0.id as c3, 
                ref_0.name as c4, 
                ref_0.id as c5, 
                ref_0.name as c6, 
                ref_0.name as c7
              from 
                main.t0 as ref_0
              where (ref_0.name is not NULL) 
                and (ref_0.name is not NULL)
              limit 138) as subq_0
          inner join main.t0 as ref_1
          on (subq_0.c5 is NULL)
      where 1
      limit 64) as subq_1
where 1
limit 114;
