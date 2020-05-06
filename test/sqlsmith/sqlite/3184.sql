select  
  case when (EXISTS (
        select  
            ref_1.id as c0, 
            ref_0.id as c1, 
            (select name from main.t0 limit 1 offset 3)
               as c2, 
            ref_0.id as c3, 
            ref_0.id as c4
          from 
            main.t0 as ref_1
          where ref_0.name is NULL
          limit 64)) 
      or (((EXISTS (
            select  
                ref_0.name as c0, 
                (select name from main.t0 limit 1 offset 2)
                   as c1, 
                ref_0.id as c2, 
                ref_0.id as c3, 
                ref_0.id as c4, 
                ref_2.id as c5, 
                ref_0.name as c6
              from 
                main.t0 as ref_2
              where (ref_0.name is not NULL) 
                or ((ref_0.name is not NULL) 
                  or (ref_0.id is NULL))
              limit 60)) 
          and (0)) 
        or (0)) then ref_0.name else ref_0.name end
     as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  (select id from main.t0 limit 1 offset 4)
     as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.id as c8
from 
  main.t0 as ref_0
where 0;
