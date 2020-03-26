select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  cast(nullif(22,
    case when 1 then 78 else 78 end
      ) as INTEGER) as c2, 
  case when ref_0.name is not NULL then ref_0.name else ref_0.name end
     as c3, 
  ref_0.id as c4
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 105;
