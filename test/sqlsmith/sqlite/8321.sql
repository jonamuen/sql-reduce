select  
  case when subq_0.c9 is NULL then case when ((subq_0.c7 is not NULL) 
          or (0)) 
        or ((0) 
          and (1)) then subq_0.c12 else subq_0.c12 end
       else case when ((subq_0.c7 is not NULL) 
          or (0)) 
        or ((0) 
          and (1)) then subq_0.c12 else subq_0.c12 end
       end
     as c0, 
  subq_0.c7 as c1, 
  subq_0.c2 as c2, 
  case when subq_0.c14 is NULL then subq_0.c2 else subq_0.c2 end
     as c3, 
  subq_0.c1 as c4, 
  subq_0.c5 as c5, 
  subq_0.c15 as c6, 
  subq_0.c12 as c7, 
  subq_0.c13 as c8, 
  subq_0.c6 as c9, 
  subq_0.c8 as c10, 
  subq_0.c10 as c11
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        (select id from main.t0 limit 1 offset 1)
           as c7, 
        ref_0.id as c8, 
        ref_0.name as c9, 
        ref_0.id as c10, 
        ref_0.id as c11, 
        ref_0.id as c12, 
        ref_0.id as c13, 
        ref_0.id as c14, 
        ref_0.name as c15, 
        ref_0.name as c16
      from 
        main.t0 as ref_0
      where (0) 
        or ((95 is NULL) 
          or (ref_0.name is NULL))
      limit 109) as subq_0
where 19 is NULL;
