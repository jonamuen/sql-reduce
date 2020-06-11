select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.name as c0, 
      42 as c1, 
      ref_0.id as c2, 
      ref_1.name as c3
    from 
      main.t0 as ref_1
        inner join (select  
              ref_2.name as c0
            from 
              main.t0 as ref_2
            where (ref_0.id is NULL) 
              and ((0) 
                and ((((0) 
                      or (ref_2.name is NULL)) 
                    or (ref_0.id is not NULL)) 
                  or (12 is not NULL)))
            limit 45) as subq_0
        on (0)
    where (0) 
      and (1)
    limit 65)
limit 77;
