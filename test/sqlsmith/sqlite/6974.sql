select  
  case when 1 then (select id from main.t0 limit 1 offset 5)
       else (select id from main.t0 limit 1 offset 5)
       end
     as c0
from 
  main.t0 as ref_0
where EXISTS (
  select  
      subq_0.c2 as c0, 
      cast(coalesce(ref_0.id,
        ref_0.id) as INT) as c1, 
      subq_0.c2 as c2
    from 
      (select  
            ref_0.id as c0, 
            68 as c1, 
            (select name from main.t0 limit 1 offset 5)
               as c2
          from 
            main.t0 as ref_1
          where (select name from main.t0 limit 1 offset 2)
               is not NULL) as subq_0
    where (1) 
      or (0));
