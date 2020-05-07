select  
  ref_1.name as c0, 
  ref_1.name as c1, 
  subq_0.c2 as c2, 
  cast(nullif(subq_0.c1,
    ref_1.name) as VARCHAR(16)) as c3, 
  subq_0.c0 as c4, 
  ref_1.id as c5, 
  ref_1.name as c6, 
  (select name from main.t0 limit 1 offset 47)
     as c7, 
  ref_1.name as c8, 
  case when 1 then ref_1.id else ref_1.id end
     as c9, 
  subq_0.c2 as c10
from 
  (select  
          ref_0.id as c0, 
          ref_0.name as c1, 
          ref_0.name as c2
        from 
          main.t0 as ref_0
        where 54 is NULL
        limit 159) as subq_0
    left join main.t0 as ref_1
    on ((0) 
        and ((EXISTS (
            select  
                ref_2.id as c0, 
                ref_2.name as c1, 
                ref_1.id as c2, 
                subq_0.c2 as c3
              from 
                main.t0 as ref_2
              where ((((((1) 
                          or (0)) 
                        or (((0) 
                            and (ref_1.name is not NULL)) 
                          and (0))) 
                      or (0)) 
                    or (1)) 
                  or ((0) 
                    or (1))) 
                and (subq_0.c0 is not NULL)
              limit 89)) 
          or (ref_1.name is NULL)))
where subq_0.c2 is NULL;
