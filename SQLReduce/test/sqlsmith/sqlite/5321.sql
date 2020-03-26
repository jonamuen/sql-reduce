select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  case when ref_0.id is not NULL then ref_0.id else ref_0.id end
     as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.name as c9
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 2)
     is not NULL
limit 24;
