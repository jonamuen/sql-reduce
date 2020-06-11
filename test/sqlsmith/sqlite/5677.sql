select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.id as c9, 
  ref_0.id as c10, 
  ref_0.name as c11, 
  ref_0.name as c12, 
  ref_0.id as c13
from 
  main.t0 as ref_0
where (0) 
  or ((EXISTS (
      select  
          subq_0.c0 as c0, 
          ref_0.id as c1
        from 
          (select  
                ref_0.name as c0, 
                ref_0.id as c1, 
                ref_0.name as c2, 
                ref_0.name as c3
              from 
                main.t0 as ref_1
              where 1
              limit 100) as subq_0
        where (1) 
          or ((0) 
            and ((1) 
              and (subq_0.c0 is NULL)))
        limit 62)) 
    or (case when ref_0.id is not NULL then ref_0.name else ref_0.name end
         is NULL))
limit 34;
