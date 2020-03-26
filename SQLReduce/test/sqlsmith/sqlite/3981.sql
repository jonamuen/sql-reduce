select  
  (select id from main.t0 limit 1 offset 4)
     as c0, 
  case when (0) 
      or (0) then ref_0.id else ref_0.id end
     as c1, 
  ref_0.id as c2, 
  case when ref_0.name is NULL then ref_0.id else ref_0.id end
     as c3
from 
  main.t0 as ref_0
    inner join (select  
          86 as c0, 
          ref_1.id as c1, 
          ref_1.id as c2, 
          ref_1.name as c3, 
          ref_1.name as c4, 
          ref_1.name as c5, 
          19 as c6, 
          ref_1.id as c7, 
          ref_1.name as c8, 
          ref_1.name as c9, 
          ref_1.id as c10
        from 
          main.t0 as ref_1
        where (ref_1.name is not NULL) 
          and (1)
        limit 39) as subq_0
    on (1)
where ref_0.id is NULL
limit 93;
