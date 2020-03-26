select  
  subq_0.c0 as c0, 
  subq_0.c3 as c1, 
  subq_0.c1 as c2, 
  (select id from main.t0 limit 1 offset 3)
     as c3, 
  subq_0.c0 as c4
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.id as c4
      from 
        main.t0 as ref_0
      where 0
      limit 107) as subq_0
where (EXISTS (
    select  
        ref_1.id as c0, 
        subq_0.c0 as c1, 
        subq_0.c3 as c2
      from 
        main.t0 as ref_1
      where ref_1.name is not NULL
      limit 137)) 
  and (((((((1) 
              and (84 is NULL)) 
            or (((subq_0.c0 is NULL) 
                or (0)) 
              or (((((0) 
                      and ((subq_0.c3 is not NULL) 
                        or ((subq_0.c0 is NULL) 
                          or (1)))) 
                    or (0)) 
                  or (1)) 
                and ((0) 
                  and ((1) 
                    and (EXISTS (
                      select  
                          subq_0.c2 as c0, 
                          subq_0.c0 as c1
                        from 
                          main.t0 as ref_2
                        where 1
                        limit 117))))))) 
          and (((0) 
              or (1)) 
            and (subq_0.c4 is not NULL))) 
        and (subq_0.c3 is NULL)) 
      and (0)) 
    and ((1) 
      and (subq_0.c2 is NULL)))
limit 118;
