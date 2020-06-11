select  
  subq_0.c3 as c0
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        97 as c3, 
        ref_0.name as c4, 
        case when ref_0.id is not NULL then (select id from main.t0 limit 1 offset 4)
             else (select id from main.t0 limit 1 offset 4)
             end
           as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        ref_0.name as c9, 
        ref_0.id as c10, 
        ref_0.id as c11, 
        ref_0.name as c12, 
        case when 1 then ref_0.id else ref_0.id end
           as c13, 
        ref_0.id as c14
      from 
        main.t0 as ref_0
      where 1
      limit 13) as subq_0
where ((1) 
    and ((((0) 
          and ((subq_0.c14 is not NULL) 
            and ((subq_0.c7 is NULL) 
              and (0)))) 
        and (EXISTS (
          select  
              ref_1.id as c0, 
              (select name from main.t0 limit 1 offset 4)
                 as c1, 
              subq_0.c7 as c2, 
              (select id from main.t0 limit 1 offset 2)
                 as c3, 
              subq_0.c8 as c4
            from 
              main.t0 as ref_1
                inner join main.t0 as ref_2
                on (ref_1.name = ref_2.name )
            where subq_0.c13 is not NULL))) 
      and (((subq_0.c14 is not NULL) 
          or (subq_0.c0 is not NULL)) 
        and (0)))) 
  and ((subq_0.c1 is not NULL) 
    or (subq_0.c2 is not NULL))
limit 176;
