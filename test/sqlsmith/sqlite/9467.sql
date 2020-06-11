select  
  subq_1.c0 as c0, 
  cast(coalesce(58,
    72) as INTEGER) as c1
from 
  (select  
        subq_0.c1 as c0, 
        (select name from main.t0 limit 1 offset 4)
           as c1, 
        case when 1 then subq_0.c1 else subq_0.c1 end
           as c2
      from 
        (select  
              ref_0.name as c0, 
              ref_0.name as c1
            from 
              main.t0 as ref_0
            where (1) 
              and (((ref_0.name is not NULL) 
                  and ((0) 
                    or ((((ref_0.id is NULL) 
                          and ((1) 
                            or (((0) 
                                or (1)) 
                              and (ref_0.name is not NULL)))) 
                        and (0)) 
                      and (0)))) 
                and ((ref_0.name is not NULL) 
                  and (ref_0.name is not NULL)))) as subq_0
      where subq_0.c0 is NULL
      limit 36) as subq_1
where 0
limit 76;
