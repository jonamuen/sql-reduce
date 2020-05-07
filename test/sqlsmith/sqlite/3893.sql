select  
  case when ((ref_0.id is not NULL) 
        and (EXISTS (
          select  
              ref_2.name as c0, 
              ref_1.id as c1, 
              ref_0.name as c2, 
              (select name from main.t0 limit 1 offset 5)
                 as c3, 
              (select id from main.t0 limit 1 offset 6)
                 as c4, 
              ref_2.id as c5
            from 
              main.t0 as ref_1
                inner join main.t0 as ref_2
                on (((1) 
                      or (0)) 
                    and (ref_2.name is NULL))
            where ((ref_2.name is not NULL) 
                and (89 is NULL)) 
              or ((0) 
                and (ref_0.name is NULL))
            limit 86))) 
      and (1) then ref_0.name else ref_0.name end
     as c0, 
  ref_0.id as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
where ((select name from main.t0 limit 1 offset 6)
       is NULL) 
  and (case when (ref_0.id is not NULL) 
        and ((1) 
          and (ref_0.name is not NULL)) then ref_0.name else ref_0.name end
       is NULL)
limit 127;
