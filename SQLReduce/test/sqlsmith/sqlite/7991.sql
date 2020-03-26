select  
  subq_0.c5 as c0, 
  case when EXISTS (
      select  
          ref_1.id as c0, 
          ref_1.name as c1, 
          ref_1.id as c2, 
          subq_0.c1 as c3, 
          ref_1.id as c4, 
          ref_1.name as c5, 
          (select name from main.t0 limit 1 offset 3)
             as c6, 
          ref_1.id as c7, 
          ref_1.id as c8, 
          subq_0.c2 as c9, 
          ref_1.name as c10, 
          ref_1.name as c11, 
          ref_1.id as c12
        from 
          main.t0 as ref_1
        where (89 is not NULL) 
          or (EXISTS (
            select  
                subq_0.c1 as c0
              from 
                main.t0 as ref_2
              where (1) 
                or ((0) 
                  and (subq_0.c2 is NULL))
              limit 83))
        limit 65) then subq_0.c2 else subq_0.c2 end
     as c1, 
  84 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6
      from 
        main.t0 as ref_0
      where (select name from main.t0 limit 1 offset 5)
           is NULL) as subq_0
where EXISTS (
  select  
      ref_3.id as c0, 
      ref_3.id as c1
    from 
      main.t0 as ref_3
    where subq_0.c2 is NULL
    limit 141);
