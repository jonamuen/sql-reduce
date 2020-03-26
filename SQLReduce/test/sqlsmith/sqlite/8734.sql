select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where (cast(nullif(ref_0.name,
      ref_0.name) as VARCHAR(16)) is NULL) 
  and ((((ref_0.id is NULL) 
        and ((select name from main.t0 limit 1 offset 5)
             is NULL)) 
      or (((0) 
          or (EXISTS (
            select  
                ref_1.name as c0, 
                ref_1.name as c1, 
                (select id from main.t0 limit 1 offset 2)
                   as c2, 
                15 as c3, 
                ref_0.name as c4, 
                ref_0.id as c5, 
                51 as c6, 
                ref_1.name as c7
              from 
                main.t0 as ref_1
              where ref_0.name is not NULL
              limit 98))) 
        or (0))) 
    or (case when 1 then ref_0.id else ref_0.id end
         is not NULL));
