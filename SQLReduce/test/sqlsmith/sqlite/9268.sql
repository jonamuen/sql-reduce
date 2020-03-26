select  
  subq_0.c11 as c0, 
  subq_0.c7 as c1
from 
  (select  
        ref_0.id as c0, 
        (select id from main.t0 limit 1 offset 76)
           as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        ref_0.name as c8, 
        ref_0.name as c9, 
        case when ref_0.name is NULL then ref_0.id else ref_0.id end
           as c10, 
        ref_0.name as c11, 
        ref_0.name as c12, 
        46 as c13, 
        ref_0.id as c14
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_1.name as c0, 
            ref_2.name as c1, 
            ref_2.name as c2
          from 
            main.t0 as ref_1
              left join main.t0 as ref_2
              on ((0) 
                  or (ref_1.name is not NULL))
          where 0)
      limit 47) as subq_0
where subq_0.c3 is NULL
limit 85;
