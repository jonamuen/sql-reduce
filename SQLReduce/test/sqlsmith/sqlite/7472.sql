select  
  ref_0.id as c0, 
  case when ((EXISTS (
          select  
              ref_0.name as c0
            from 
              main.t0 as ref_1
            where ref_1.id is NULL)) 
        or ((EXISTS (
            select  
                ref_2.name as c0, 
                ref_0.id as c1, 
                ref_2.name as c2, 
                ref_0.id as c3, 
                ref_2.name as c4, 
                (select id from main.t0 limit 1 offset 1)
                   as c5, 
                ref_0.id as c6, 
                ref_2.id as c7, 
                ref_2.name as c8, 
                ref_0.id as c9, 
                ref_2.id as c10, 
                ref_0.id as c11, 
                ref_0.id as c12
              from 
                main.t0 as ref_2
              where (ref_2.name is not NULL) 
                and (((ref_0.id is not NULL) 
                    and (EXISTS (
                      select  
                          ref_2.name as c0, 
                          ref_3.id as c1, 
                          ref_2.id as c2, 
                          (select id from main.t0 limit 1 offset 4)
                             as c3
                        from 
                          main.t0 as ref_3
                        where ref_3.id is NULL
                        limit 63))) 
                  or (((ref_0.id is NULL) 
                      or (ref_2.id is not NULL)) 
                    or ((0) 
                      or ((EXISTS (
                          select  
                              ref_0.id as c0, 
                              ref_4.name as c1, 
                              ref_0.name as c2, 
                              ref_2.id as c3, 
                              ref_0.name as c4, 
                              (select name from main.t0 limit 1 offset 1)
                                 as c5
                            from 
                              main.t0 as ref_4
                            where 0)) 
                        or (0)))))
              limit 61)) 
          and ((select name from main.t0 limit 1 offset 3)
               is not NULL))) 
      and (ref_0.name is not NULL) then ref_0.name else ref_0.name end
     as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  case when ref_0.id is not NULL then ref_0.name else ref_0.name end
     as c6, 
  ref_0.id as c7, 
  ref_0.id as c8
from 
  main.t0 as ref_0
where (ref_0.name is not NULL) 
  or ((ref_0.id is not NULL) 
    and (ref_0.name is NULL))
limit 37;
