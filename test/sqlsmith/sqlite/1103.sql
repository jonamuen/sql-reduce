select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2
      from 
        main.t0 as ref_0
      where (40 is not NULL) 
        or ((((ref_0.id is not NULL) 
              or (EXISTS (
                select  
                    ref_1.name as c0
                  from 
                    main.t0 as ref_1
                  where ref_0.id is NULL))) 
            and ((ref_0.id is not NULL) 
              and (((0) 
                  or (((EXISTS (
                        select  
                            ref_2.name as c0, 
                            ref_0.name as c1, 
                            ref_0.id as c2, 
                            ref_2.name as c3, 
                            ref_2.name as c4, 
                            19 as c5, 
                            ref_0.id as c6, 
                            ref_0.name as c7, 
                            ref_0.id as c8, 
                            ref_2.id as c9, 
                            ref_0.name as c10, 
                            ref_2.name as c11, 
                            ref_0.name as c12, 
                            ref_2.name as c13, 
                            ref_0.name as c14
                          from 
                            main.t0 as ref_2
                          where ref_2.id is not NULL
                          limit 160)) 
                      and (ref_0.name is NULL)) 
                    and (ref_0.id is NULL))) 
                or (0)))) 
          and ((1) 
            and (0)))) as subq_0
where subq_0.c2 is not NULL
limit 78;
