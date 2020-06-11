select  
  case when (((1) 
          or (((select id from main.t0 limit 1 offset 1)
                 is NULL) 
            or ((0) 
              or (EXISTS (
                select  
                    ref_1.id as c0, 
                    ref_0.id as c1, 
                    ref_0.name as c2, 
                    ref_1.id as c3, 
                    ref_0.name as c4, 
                    ref_1.id as c5, 
                    (select name from main.t0 limit 1 offset 5)
                       as c6, 
                    ref_0.id as c7
                  from 
                    main.t0 as ref_1
                  where 1
                  limit 129))))) 
        or (1)) 
      and (ref_0.id is NULL) then ref_0.name else ref_0.name end
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.id as c5
from 
  main.t0 as ref_0
where ((ref_0.name is NULL) 
    or (ref_0.name is NULL)) 
  or (ref_0.id is NULL)
limit 65;
