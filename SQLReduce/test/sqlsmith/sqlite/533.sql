select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where EXISTS (
  select  
      case when 0 then ref_1.id else ref_1.id end
         as c0, 
      ref_0.id as c1, 
      ref_2.name as c2, 
      ref_0.id as c3, 
      ref_1.name as c4, 
      ref_2.name as c5, 
      ref_1.name as c6, 
      ref_1.name as c7, 
      ref_1.name as c8, 
      ref_0.name as c9
    from 
      main.t0 as ref_1
        inner join main.t0 as ref_2
        on (ref_2.id is not NULL)
    where 1)
limit 88;
