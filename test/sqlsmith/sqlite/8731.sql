select  
  case when (select id from main.t0 limit 1 offset 21)
         is NULL then ref_0.id else ref_0.id end
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where ((1) 
    and ((1) 
      and (ref_0.id is not NULL))) 
  or (EXISTS (
    select  
        ref_0.id as c0, 
        subq_0.c2 as c1, 
        subq_0.c7 as c2, 
        case when ((subq_0.c1 is NULL) 
              or ((((0) 
                    or (((ref_0.id is NULL) 
                        and (1)) 
                      or ((((1) 
                            or ((0) 
                              and (((subq_0.c6 is NULL) 
                                  or (0)) 
                                or (0)))) 
                          or (ref_0.id is not NULL)) 
                        or (0)))) 
                  or (subq_0.c1 is not NULL)) 
                and (1))) 
            and (subq_0.c8 is not NULL) then subq_0.c3 else subq_0.c3 end
           as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        subq_0.c2 as c7, 
        ref_0.name as c8, 
        ref_0.id as c9
      from 
        (select  
              ref_0.name as c0, 
              ref_1.name as c1, 
              ref_1.id as c2, 
              ref_0.name as c3, 
              ref_1.name as c4, 
              ref_1.id as c5, 
              ref_0.id as c6, 
              (select name from main.t0 limit 1 offset 59)
                 as c7, 
              ref_1.name as c8
            from 
              main.t0 as ref_1
            where 0
            limit 64) as subq_0
      where subq_0.c8 is NULL))
limit 135;
