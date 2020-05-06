select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  case when ref_0.name is not NULL then case when 28 is NULL then (select id from main.t0 limit 1 offset 6)
         else (select id from main.t0 limit 1 offset 6)
         end
       else case when 28 is NULL then (select id from main.t0 limit 1 offset 6)
         else (select id from main.t0 limit 1 offset 6)
         end
       end
     as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.id as c0, 
      ref_1.name as c1, 
      case when ref_1.name is not NULL then ref_0.id else ref_0.id end
         as c2, 
      ref_0.id as c3, 
      case when ref_1.id is not NULL then ref_1.name else ref_1.name end
         as c4, 
      ref_0.id as c5, 
      ref_0.id as c6, 
      case when ref_1.id is NULL then ref_1.name else ref_1.name end
         as c7, 
      12 as c8, 
      ref_0.id as c9, 
      ref_0.name as c10, 
      ref_1.id as c11, 
      ref_0.id as c12
    from 
      main.t0 as ref_1
    where ref_1.name is NULL
    limit 54);
