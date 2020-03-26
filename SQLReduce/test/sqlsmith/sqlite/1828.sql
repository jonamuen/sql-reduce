select  
  subq_0.c0 as c0
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL) as subq_0
where (subq_0.c0 is NULL) 
  or ((EXISTS (
      select  
          ref_1.name as c0, 
          ref_1.name as c1, 
          subq_0.c2 as c2
        from 
          main.t0 as ref_1
        where EXISTS (
          select  
              ref_2.name as c0
            from 
              main.t0 as ref_2
            where (ref_1.id is not NULL) 
              and (EXISTS (
                select distinct 
                    ref_2.id as c0
                  from 
                    main.t0 as ref_3
                  where (0) 
                    or (1)
                  limit 78))))) 
    or (subq_0.c2 is not NULL))
limit 90;
