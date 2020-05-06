select  
  ref_0.name as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where ((ref_0.id is not NULL) 
    and ((case when ref_0.id is not NULL then ref_0.id else ref_0.id end
           is not NULL) 
      and (1))) 
  or (((ref_0.name is not NULL) 
      or ((ref_0.id is NULL) 
        or ((EXISTS (
            select  
                ref_1.name as c0
              from 
                main.t0 as ref_1
              where ref_1.name is not NULL
              limit 73)) 
          and (ref_0.id is not NULL)))) 
    and (1));
