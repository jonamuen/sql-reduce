select  
  (select name from main.t0 limit 1 offset 1)
     as c0, 
  (select name from main.t0 limit 1 offset 14)
     as c1, 
  subq_1.c0 as c2, 
  case when subq_1.c2 is not NULL then subq_1.c2 else subq_1.c2 end
     as c3, 
  cast(nullif(subq_1.c4,
    subq_1.c2) as VARCHAR(16)) as c4
from 
  (select  
        ref_1.id as c0, 
        subq_0.c13 as c1, 
        subq_0.c0 as c2, 
        subq_0.c13 as c3, 
        ref_0.name as c4
      from 
        main.t0 as ref_0
            inner join main.t0 as ref_1
            on (((ref_1.name is not NULL) 
                  or (((((1) 
                          and (ref_1.name is NULL)) 
                        or (ref_1.name is not NULL)) 
                      or (0)) 
                    and (ref_0.id is not NULL))) 
                or ((ref_0.id is NULL) 
                  and (EXISTS (
                    select  
                        ref_0.id as c0, 
                        ref_0.name as c1
                      from 
                        main.t0 as ref_2
                      where 0
                      limit 91))))
          inner join (select  
                ref_3.name as c0, 
                ref_3.name as c1, 
                (select name from main.t0 limit 1 offset 3)
                   as c2, 
                76 as c3, 
                ref_3.id as c4, 
                (select id from main.t0 limit 1 offset 4)
                   as c5, 
                ref_3.id as c6, 
                ref_3.id as c7, 
                90 as c8, 
                ref_3.name as c9, 
                39 as c10, 
                ref_3.name as c11, 
                ref_3.name as c12, 
                (select name from main.t0 limit 1 offset 3)
                   as c13, 
                ref_3.name as c14
              from 
                main.t0 as ref_3
              where 1) as subq_0
          on (1)
      where (select name from main.t0 limit 1 offset 4)
           is NULL) as subq_1
where ((subq_1.c3 is NULL) 
    and (((0) 
        and ((select id from main.t0 limit 1 offset 6)
             is NULL)) 
      or (((((0) 
              or (subq_1.c0 is not NULL)) 
            and (1)) 
          or ((1) 
            or (1))) 
        or (1)))) 
  or (1)
limit 98;
