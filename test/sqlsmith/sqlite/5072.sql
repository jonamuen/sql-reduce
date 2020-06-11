select  
  ref_0.id as c0, 
  subq_0.c1 as c1, 
  70 as c2
from 
  main.t0 as ref_0
    inner join (select  
          ref_1.id as c0, 
          ref_1.name as c1, 
          ref_1.id as c2
        from 
          main.t0 as ref_1
        where ((((0) 
                and (ref_1.name is NULL)) 
              or (EXISTS (
                select distinct 
                    ref_2.id as c0, 
                    ref_1.id as c1
                  from 
                    main.t0 as ref_2
                  where ref_1.id is not NULL
                  limit 144))) 
            or (ref_1.id is not NULL)) 
          or (0)) as subq_0
    on ((ref_0.id is not NULL) 
        or (subq_0.c2 is NULL))
where 0
limit 116;
