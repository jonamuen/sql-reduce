select  
  subq_0.c0 as c0, 
  subq_0.c3 as c1, 
  subq_0.c2 as c2, 
  subq_0.c2 as c3, 
  subq_0.c3 as c4, 
  subq_0.c0 as c5, 
  subq_0.c1 as c6, 
  subq_0.c1 as c7, 
  subq_0.c0 as c8, 
  subq_0.c2 as c9, 
  subq_0.c0 as c10, 
  subq_0.c2 as c11, 
  subq_0.c3 as c12, 
  subq_0.c0 as c13
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        case when 0 then 33 else 33 end
           as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where ref_0.id is NULL
      limit 32) as subq_0
where EXISTS (
  select  
      subq_0.c1 as c0, 
      subq_0.c3 as c1, 
      subq_0.c1 as c2, 
      ref_1.name as c3, 
      subq_0.c0 as c4
    from 
      main.t0 as ref_1
    where EXISTS (
      select  
          subq_0.c1 as c0
        from 
          main.t0 as ref_2
        where 0))
limit 142;
