select  
  subq_0.c0 as c0, 
  case when cast(coalesce(subq_0.c4,
        subq_0.c6) as INT) is not NULL then cast(coalesce(subq_0.c3,
      subq_0.c3) as INT) else cast(coalesce(subq_0.c3,
      subq_0.c3) as INT) end
     as c1, 
  53 as c2, 
  subq_0.c2 as c3, 
  subq_0.c5 as c4, 
  subq_0.c8 as c5, 
  subq_0.c9 as c6, 
  subq_0.c4 as c7, 
  subq_0.c7 as c8, 
  subq_0.c9 as c9, 
  subq_0.c8 as c10, 
  subq_0.c8 as c11, 
  subq_0.c3 as c12, 
  subq_0.c9 as c13, 
  subq_0.c8 as c14
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        case when (((0) 
                and (ref_0.id is NULL)) 
              or ((0) 
                and ((1) 
                  and (1)))) 
            or ((0) 
              or ((((ref_0.id is not NULL) 
                    or (((((1) 
                            or ((1) 
                              or (ref_0.id is NULL))) 
                          or ((0) 
                            and ((0) 
                              or (0)))) 
                        or (0)) 
                      and ((EXISTS (
                          select  
                              ref_0.id as c0
                            from 
                              main.t0 as ref_1
                            where 0)) 
                        or (ref_0.id is NULL)))) 
                  and (((select name from main.t0 limit 1 offset 3)
                         is not NULL) 
                    and (ref_0.name is not NULL))) 
                and ((EXISTS (
                    select  
                        ref_0.id as c0, 
                        ref_2.name as c1, 
                        ref_0.name as c2, 
                        (select id from main.t0 limit 1 offset 5)
                           as c3, 
                        ref_0.id as c4, 
                        ref_0.id as c5, 
                        ref_0.name as c6
                      from 
                        main.t0 as ref_2
                      where ref_2.name is not NULL)) 
                  or ((ref_0.id is NULL) 
                    or (ref_0.id is not NULL))))) then ref_0.id else ref_0.id end
           as c4, 
        ref_0.id as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.name as c8, 
        ref_0.name as c9
      from 
        main.t0 as ref_0
      where (ref_0.name is NULL) 
        or (ref_0.name is not NULL)
      limit 112) as subq_0
where subq_0.c0 is not NULL
limit 64;
