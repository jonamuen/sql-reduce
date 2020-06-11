select  
  subq_0.c0 as c0, 
  case when (subq_0.c0 is NULL) 
      or (1) then subq_1.c0 else subq_1.c0 end
     as c1, 
  subq_1.c3 as c2, 
  subq_1.c3 as c3, 
  subq_0.c0 as c4, 
  subq_1.c0 as c5, 
  cast(nullif(subq_1.c3,
    subq_1.c0) as VARCHAR(16)) as c6, 
  subq_0.c0 as c7
from 
  (select  
          ref_0.id as c0
        from 
          main.t0 as ref_0
        where (((0) 
              or (ref_0.id is NULL)) 
            and ((EXISTS (
                select  
                    ref_0.name as c0, 
                    ref_0.name as c1, 
                    ref_1.name as c2, 
                    ref_1.id as c3, 
                    ref_1.id as c4
                  from 
                    main.t0 as ref_1
                  where 1)) 
              and ((1) 
                and (ref_0.id is not NULL)))) 
          or ((((0) 
                and ((1) 
                  or (0))) 
              or ((0) 
                or ((ref_0.id is NULL) 
                  and (1)))) 
            or (1))
        limit 99) as subq_0
    left join (select  
          ref_2.name as c0, 
          ref_2.name as c1, 
          ref_2.name as c2, 
          ref_2.name as c3
        from 
          main.t0 as ref_2
        where (ref_2.id is NULL) 
          and (ref_2.id is NULL)
        limit 82) as subq_1
    on (EXISTS (
        select  
            subq_1.c1 as c0, 
            subq_1.c3 as c1, 
            subq_0.c0 as c2, 
            subq_0.c0 as c3
          from 
            main.t0 as ref_3
          where subq_1.c0 is NULL
          limit 134))
where subq_1.c3 is not NULL
limit 24;
