select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_0.name as c0, 
      17 as c1, 
      subq_0.c1 as c2, 
      subq_0.c0 as c3
    from 
      (select  
            ref_0.id as c0, 
            ref_0.id as c1
          from 
            main.t0 as ref_1
          where (0) 
            or ((((1) 
                  and ((EXISTS (
                      select  
                          ref_1.name as c0
                        from 
                          main.t0 as ref_2
                        where (0) 
                          and (0))) 
                    and (ref_1.name is NULL))) 
                and (1)) 
              and (1))) as subq_0
    where 0)
limit 106;
