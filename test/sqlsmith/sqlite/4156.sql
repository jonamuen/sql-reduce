select  
  subq_0.c13 as c0, 
  subq_0.c4 as c1, 
  subq_0.c3 as c2, 
  subq_0.c10 as c3, 
  subq_0.c18 as c4, 
  subq_0.c11 as c5, 
  case when subq_0.c7 is NULL then subq_0.c1 else subq_0.c1 end
     as c6
from 
  (select  
        case when 0 then ref_0.id else ref_0.id end
           as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        (select id from main.t0 limit 1 offset 1)
           as c7, 
        (select name from main.t0 limit 1 offset 2)
           as c8, 
        ref_0.name as c9, 
        ref_0.id as c10, 
        ref_0.name as c11, 
        ref_0.id as c12, 
        ref_0.name as c13, 
        13 as c14, 
        ref_0.id as c15, 
        ref_0.id as c16, 
        ref_0.id as c17, 
        ref_0.name as c18
      from 
        main.t0 as ref_0
      where 0
      limit 58) as subq_0
where (29 is NULL) 
  or (1)
limit 90;
