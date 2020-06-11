select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  (select name from main.t0 limit 1 offset 1)
     as c2, 
  (select name from main.t0 limit 1 offset 2)
     as c3
from 
  main.t0 as ref_0
where cast(nullif((select id from main.t0 limit 1 offset 1)
      ,
    ref_0.id) as INT) is not NULL
limit 56;
