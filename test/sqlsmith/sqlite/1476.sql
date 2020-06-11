select  
  ref_0.name as c0, 
  case when ref_0.name is NULL then ref_0.name else ref_0.name end
     as c1, 
  ref_0.id as c2, 
  case when ((0) 
        or (EXISTS (
          select  
              ref_0.id as c0, 
              ref_0.name as c1, 
              ref_0.id as c2, 
              14 as c3, 
              ref_1.id as c4, 
              ref_0.id as c5, 
              ref_1.id as c6, 
              ref_0.name as c7, 
              (select name from main.t0 limit 1 offset 85)
                 as c8, 
              ref_0.id as c9, 
              ref_0.id as c10, 
              ref_0.name as c11, 
              ref_0.id as c12, 
              ref_1.name as c13, 
              ref_0.id as c14, 
              ref_0.id as c15, 
              ref_1.id as c16, 
              ref_1.id as c17, 
              (select id from main.t0 limit 1 offset 9)
                 as c18, 
              ref_0.id as c19, 
              ref_0.name as c20, 
              ref_1.name as c21, 
              ref_0.id as c22, 
              ref_0.id as c23
            from 
              main.t0 as ref_1
            where ref_0.id is not NULL
            limit 197))) 
      or ((ref_0.name is not NULL) 
        and (ref_0.id is not NULL)) then ref_0.name else ref_0.name end
     as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 29;
