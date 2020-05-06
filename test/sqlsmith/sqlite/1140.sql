select  
  ref_1.id as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  case when (1) 
      or ((ref_0.name is NULL) 
        and ((ref_0.id is NULL) 
          or ((((((ref_0.name is NULL) 
                    and ((EXISTS (
                        select  
                            ref_0.id as c0, 
                            ref_1.id as c1, 
                            ref_0.name as c2
                          from 
                            main.t0 as ref_2
                          where (ref_2.name is NULL) 
                            or (ref_1.name is NULL)
                          limit 145)) 
                      or ((1) 
                        or (0)))) 
                  and (ref_0.id is not NULL)) 
                or (EXISTS (
                  select  
                      ref_3.id as c0, 
                      ref_0.name as c1
                    from 
                      main.t0 as ref_3
                    where 0
                    limit 126))) 
              and ((select name from main.t0 limit 1 offset 5)
                   is NULL)) 
            or (1)))) then ref_0.name else ref_0.name end
     as c4
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on (1)
where 0
limit 139;
