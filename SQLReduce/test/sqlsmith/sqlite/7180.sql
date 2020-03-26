select  
  93 as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c6
from 
  main.t0 as ref_0
where (1) 
  or ((((0) 
        and (0)) 
      and ((1) 
        or (0))) 
    and (((((1) 
            or (ref_0.id is NULL)) 
          and (ref_0.name is not NULL)) 
        and (EXISTS (
          select  
              ref_1.id as c0
            from 
              main.t0 as ref_1
            where 0
            limit 148))) 
      and (EXISTS (
        select  
            ref_2.id as c0, 
            ref_0.name as c1, 
            ref_2.name as c2
          from 
            main.t0 as ref_2
          where ref_0.name is NULL
          limit 165))))
limit 146;
