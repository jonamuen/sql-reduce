select  
  ref_0.id as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where (0) 
  or (((EXISTS (
        select  
            ref_2.name as c0, 
            ref_1.name as c1
          from 
            main.t0 as ref_1
              inner join main.t0 as ref_2
              on (ref_1.name = ref_2.name )
          where ref_1.name is not NULL)) 
      or (case when 0 then ref_0.name else ref_0.name end
           is not NULL)) 
    or (0))
limit 80;
