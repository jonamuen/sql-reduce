insert into main.t0 values (
case when ((((41 is not NULL) 
          and (75 is NULL)) 
        and (EXISTS (
          select  
              ref_0.id as c0, 
              ref_0.id as c1, 
              ref_0.name as c2, 
              ref_0.name as c3, 
              ref_0.id as c4, 
              ref_0.name as c5, 
              ref_0.name as c6, 
              ref_0.name as c7, 
              ref_0.name as c8, 
              ref_0.name as c9, 
              ref_0.name as c10, 
              ref_0.id as c11
            from 
              main.t0 as ref_0
            where (0) 
              or (0)
            limit 100))) 
      or (EXISTS (
        select  
            ref_1.id as c0, 
            48 as c1, 
            ref_1.name as c2, 
            ref_1.name as c3
          from 
            main.t0 as ref_1
          where ref_1.id is not NULL
          limit 31))) 
    and (((EXISTS (
          select  
              ref_2.name as c0
            from 
              main.t0 as ref_2
            where ((ref_2.name is NULL) 
                and ((((1) 
                      or (1)) 
                    and (4 is NULL)) 
                  or ((ref_2.name is NULL) 
                    and (((0) 
                        and (ref_2.name is not NULL)) 
                      and ((EXISTS (
                          select  
                              ref_2.name as c0
                            from 
                              main.t0 as ref_3
                            where ref_2.name is NULL)) 
                        or (ref_2.name is not NULL)))))) 
              or (EXISTS (
                select  
                    ref_4.name as c0, 
                    ref_2.id as c1, 
                    ref_4.id as c2
                  from 
                    main.t0 as ref_4
                  where ((1) 
                      and (1)) 
                    or (((1) 
                        or ((0) 
                          and (EXISTS (
                            select  
                                ref_5.name as c0, 
                                ref_4.name as c1, 
                                ref_2.name as c2, 
                                ref_4.name as c3
                              from 
                                main.t0 as ref_5
                              where 1)))) 
                      and (1))))
            limit 116)) 
        or (81 is not NULL)) 
      and (1)) then cast(null as INT) else cast(null as INT) end
  , 
cast(null as VARCHAR(16)));
