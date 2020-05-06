select  
  (select name from main.t0 limit 1 offset 1)
     as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  subq_0.c0 as c5
from 
  (select  
        ref_1.name as c0
      from 
        main.t0 as ref_0
          inner join main.t0 as ref_1
          on (((ref_1.name is not NULL) 
                and (1)) 
              or (EXISTS (
                select  
                    ref_2.id as c0, 
                    ref_0.name as c1, 
                    ref_1.name as c2, 
                    ref_2.name as c3
                  from 
                    main.t0 as ref_2
                  where ref_0.id is not NULL
                  limit 146)))
      where 0
      limit 133) as subq_0
where (cast(coalesce(subq_0.c0,
      subq_0.c0) as VARCHAR(16)) is NULL) 
  or (subq_0.c0 is NULL)
limit 71;
