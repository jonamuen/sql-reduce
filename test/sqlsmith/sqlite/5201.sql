select  
  case when (EXISTS (
        select  
            88 as c0
          from 
            main.t0 as ref_1
          where EXISTS (
            select  
                ref_1.id as c0, 
                subq_1.c1 as c1
              from 
                main.t0 as ref_2
              where (1) 
                and ((0) 
                  and (ref_1.id is NULL))
              limit 97)
          limit 123)) 
      and (subq_1.c1 is not NULL) then subq_1.c2 else subq_1.c2 end
     as c0, 
  cast(coalesce(subq_1.c2,
    subq_1.c2) as INTEGER) as c1, 
  subq_1.c2 as c2, 
  subq_1.c2 as c3, 
  subq_1.c2 as c4
from 
  (select  
        subq_0.c6 as c0, 
        subq_0.c22 as c1, 
        20 as c2
      from 
        (select  
              ref_0.id as c0, 
              ref_0.name as c1, 
              ref_0.name as c2, 
              ref_0.name as c3, 
              ref_0.id as c4, 
              ref_0.id as c5, 
              ref_0.id as c6, 
              ref_0.name as c7, 
              ref_0.id as c8, 
              ref_0.name as c9, 
              ref_0.name as c10, 
              ref_0.name as c11, 
              ref_0.name as c12, 
              ref_0.name as c13, 
              ref_0.id as c14, 
              (select name from main.t0 limit 1 offset 55)
                 as c15, 
              ref_0.id as c16, 
              ref_0.name as c17, 
              ref_0.id as c18, 
              ref_0.id as c19, 
              (select name from main.t0 limit 1 offset 6)
                 as c20, 
              ref_0.name as c21, 
              ref_0.name as c22, 
              ref_0.id as c23, 
              ref_0.name as c24, 
              ref_0.id as c25
            from 
              main.t0 as ref_0
            where ref_0.name is not NULL) as subq_0
      where (1) 
        and (((select id from main.t0 limit 1 offset 4)
               is not NULL) 
          or (subq_0.c1 is not NULL))) as subq_1
where subq_1.c2 is NULL;
