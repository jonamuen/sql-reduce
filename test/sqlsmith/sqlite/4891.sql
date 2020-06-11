select  
  subq_0.c0 as c0
from 
  (select  
        56 as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where 1
      limit 106) as subq_0
where EXISTS (
  select  
      60 as c0, 
      subq_0.c1 as c1, 
      subq_0.c0 as c2, 
      cast(coalesce(subq_0.c1,
        subq_0.c1) as INT) as c3, 
      subq_0.c0 as c4, 
      case when 0 then ref_1.name else ref_1.name end
         as c5, 
      ref_1.id as c6, 
      ref_1.name as c7, 
      subq_0.c1 as c8
    from 
      main.t0 as ref_1
    where ref_1.name is not NULL
    limit 71);
