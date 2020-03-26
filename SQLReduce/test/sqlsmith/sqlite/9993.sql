select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6
from 
  main.t0 as ref_0
where EXISTS (
  select  
      54 as c0, 
      ref_0.name as c1
    from 
      main.t0 as ref_1
    where (0) 
      and (((EXISTS (
            select  
                ref_0.id as c0, 
                ref_0.id as c1, 
                ref_1.name as c2, 
                ref_1.name as c3, 
                ref_1.name as c4, 
                ref_2.id as c5, 
                ref_2.name as c6
              from 
                main.t0 as ref_2
              where ((((ref_0.id is not NULL) 
                      or (ref_0.id is not NULL)) 
                    or (ref_1.id is NULL)) 
                  and (1)) 
                or (0)
              limit 73)) 
          or (ref_0.id is NULL)) 
        or ((ref_1.name is NULL) 
          and ((0) 
            or (ref_1.name is NULL))))
    limit 96);
