select  
  case when 1 then (select name from main.t0 limit 1 offset 6)
       else (select name from main.t0 limit 1 offset 6)
       end
     as c0, 
  ref_0.name as c1, 
  (select name from main.t0 limit 1 offset 4)
     as c2
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_0.name as c0
    from 
      main.t0 as ref_1
    where ref_0.name is not NULL
    limit 107);
