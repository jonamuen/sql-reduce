select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  (select id from main.t0 limit 1 offset 5)
     as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  43 as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.id as c10, 
  ref_0.name as c11, 
  ref_0.name as c12, 
  ref_0.name as c13, 
  ref_0.name as c14, 
  ref_0.name as c15, 
  ref_0.id as c16, 
  ref_0.name as c17, 
  ref_0.name as c18, 
  ref_0.id as c19, 
  case when ((0) 
        or (1)) 
      or (1) then ref_0.id else ref_0.id end
     as c20
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 81;
