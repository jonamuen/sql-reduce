select  
  ref_1.id as c0, 
  ref_1.name as c1, 
  ref_1.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_1.name as c5, 
  ref_0.id as c6, 
  ref_1.id as c7, 
  ref_0.name as c8, 
  ref_1.id as c9, 
  ref_0.name as c10, 
  ref_1.name as c11, 
  ref_1.id as c12, 
  ref_0.name as c13, 
  cast(coalesce(case when 0 then ref_1.id else ref_1.id end
      ,
    ref_0.id) as INT) as c14
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on (ref_0.name is NULL)
where (1) 
  and ((ref_1.id is not NULL) 
    and (0))
limit 117;
