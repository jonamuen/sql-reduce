select  
  86 as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  24 as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where case when (1) 
      or (((ref_0.id is NULL) 
          and (0)) 
        or ((1) 
          and ((((1) 
                or (EXISTS (
                  select  
                      ref_0.id as c0, 
                      ref_0.name as c1, 
                      ref_0.name as c2, 
                      ref_1.id as c3, 
                      ref_0.name as c4, 
                      ref_1.name as c5, 
                      ref_0.id as c6, 
                      ref_0.id as c7, 
                      ref_0.name as c8, 
                      ref_0.id as c9
                    from 
                      main.t0 as ref_1
                    where EXISTS (
                      select  
                          ref_0.name as c0, 
                          ref_2.id as c1, 
                          ref_1.id as c2
                        from 
                          main.t0 as ref_2
                        where 0
                        limit 108)
                    limit 68))) 
              or (1)) 
            and (ref_0.name is NULL)))) then ref_0.name else ref_0.name end
     is not NULL;
