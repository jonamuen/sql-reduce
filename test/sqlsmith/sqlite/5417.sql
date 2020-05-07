select  
  ref_0.id as c0, 
  case when ref_0.id is NULL then ref_0.name else ref_0.name end
     as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.name as c7
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.id as c0, 
      (select name from main.t0 limit 1 offset 5)
         as c1, 
      ref_1.id as c2, 
      ref_0.id as c3, 
      ref_1.name as c4, 
      (select id from main.t0 limit 1 offset 2)
         as c5, 
      ref_0.name as c6, 
      ref_1.id as c7, 
      ref_0.name as c8, 
      (select name from main.t0 limit 1 offset 3)
         as c9, 
      ref_0.name as c10, 
      ref_1.id as c11, 
      ref_0.name as c12, 
      ref_0.id as c13, 
      case when (select id from main.t0 limit 1 offset 5)
             is not NULL then ref_0.name else ref_0.name end
         as c14, 
      ref_1.id as c15, 
      ref_0.name as c16, 
      ref_0.name as c17, 
      ref_1.id as c18, 
      ref_1.name as c19, 
      ref_0.name as c20
    from 
      main.t0 as ref_1
    where ((0) 
        or (ref_0.name is not NULL)) 
      and ((select id from main.t0 limit 1 offset 38)
           is NULL))
limit 165;
