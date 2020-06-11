select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  cast(coalesce((select id from main.t0 limit 1 offset 1)
      ,
    ref_0.id) as INT) as c5, 
  ref_0.id as c6
from 
  main.t0 as ref_0
where (((ref_0.name is NULL) 
      and (EXISTS (
        select  
            ref_1.name as c0, 
            ref_0.name as c1, 
            ref_1.id as c2, 
            ref_0.id as c3, 
            ref_0.id as c4, 
            ref_1.id as c5
          from 
            main.t0 as ref_1
          where (1) 
            and (EXISTS (
              select  
                  ref_2.name as c0
                from 
                  main.t0 as ref_2
                where 1
                limit 181))
          limit 75))) 
    or ((0) 
      or (((1) 
          or (ref_0.name is NULL)) 
        or (ref_0.id is not NULL)))) 
  and ((0) 
    and ((ref_0.id is NULL) 
      or (ref_0.id is not NULL)))
limit 112;
