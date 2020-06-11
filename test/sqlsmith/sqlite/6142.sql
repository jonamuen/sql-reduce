select  
  ref_0.name as c0, 
  (select name from main.t0 limit 1 offset 5)
     as c1, 
  56 as c2, 
  (select id from main.t0 limit 1 offset 5)
     as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  35 as c9, 
  ref_0.name as c10, 
  ref_0.id as c11, 
  ref_0.name as c12, 
  case when ((ref_0.name is NULL) 
        or (((76 is not NULL) 
            and (EXISTS (
              select  
                  ref_0.name as c0, 
                  ref_1.name as c1, 
                  ref_0.name as c2, 
                  ref_1.name as c3, 
                  ref_0.name as c4, 
                  60 as c5, 
                  ref_0.name as c6, 
                  ref_0.id as c7, 
                  ref_1.name as c8, 
                  ref_1.id as c9, 
                  ref_0.id as c10
                from 
                  main.t0 as ref_1
                where (1) 
                  or (0)
                limit 80))) 
          or (ref_0.id is NULL))) 
      and (1) then ref_0.id else ref_0.id end
     as c13, 
  ref_0.id as c14
from 
  main.t0 as ref_0
where (1) 
  and (0)
limit 75;
