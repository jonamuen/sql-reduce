select  
  case when subq_0.c0 is NULL then subq_0.c0 else subq_0.c0 end
     as c0
from 
  (select  
        98 as c0
      from 
        main.t0 as ref_0
      where ((ref_0.id is not NULL) 
          or ((ref_0.id is not NULL) 
            or (ref_0.name is not NULL))) 
        or ((select id from main.t0 limit 1 offset 1)
             is NULL)) as subq_0
where EXISTS (
  select  
      95 as c0, 
      97 as c1, 
      ref_1.name as c2, 
      ref_1.name as c3, 
      ref_1.name as c4, 
      subq_0.c0 as c5, 
      35 as c6, 
      subq_0.c0 as c7, 
      subq_0.c0 as c8, 
      ref_1.id as c9, 
      subq_0.c0 as c10, 
      subq_0.c0 as c11, 
      ref_1.id as c12, 
      case when (0) 
          or ((1) 
            or ((0) 
              and (EXISTS (
                select  
                    subq_0.c0 as c0, 
                    ref_1.id as c1, 
                    ref_1.name as c2, 
                    subq_0.c0 as c3, 
                    ref_1.id as c4, 
                    ref_1.name as c5, 
                    subq_0.c0 as c6, 
                    subq_0.c0 as c7, 
                    ref_1.id as c8, 
                    ref_2.name as c9
                  from 
                    main.t0 as ref_2
                  where ref_1.id is not NULL
                  limit 61)))) then ref_1.name else ref_1.name end
         as c13, 
      subq_0.c0 as c14, 
      case when 1 then subq_0.c0 else subq_0.c0 end
         as c15, 
      subq_0.c0 as c16, 
      ref_1.id as c17, 
      subq_0.c0 as c18, 
      ref_1.name as c19, 
      subq_0.c0 as c20, 
      ref_1.id as c21, 
      ref_1.id as c22, 
      subq_0.c0 as c23, 
      subq_0.c0 as c24, 
      ref_1.name as c25, 
      case when (ref_1.name is NULL) 
          and (76 is not NULL) then subq_0.c0 else subq_0.c0 end
         as c26, 
      ref_1.id as c27
    from 
      main.t0 as ref_1
    where (EXISTS (
        select  
            ref_1.name as c0, 
            subq_0.c0 as c1, 
            ref_3.name as c2, 
            ref_3.id as c3, 
            subq_0.c0 as c4, 
            subq_0.c0 as c5, 
            ref_3.name as c6, 
            ref_1.name as c7, 
            ref_1.id as c8, 
            ref_1.name as c9, 
            ref_3.id as c10, 
            ref_1.id as c11, 
            subq_0.c0 as c12, 
            ref_1.id as c13, 
            ref_1.id as c14, 
            subq_0.c0 as c15
          from 
            main.t0 as ref_3
          where (1) 
            and ((ref_1.id is not NULL) 
              and (ref_3.id is not NULL))
          limit 138)) 
      or ((ref_1.name is NULL) 
        and (EXISTS (
          select  
              subq_0.c0 as c0, 
              ref_4.id as c1, 
              ref_1.id as c2, 
              ref_1.id as c3, 
              subq_0.c0 as c4, 
              subq_0.c0 as c5, 
              ref_1.name as c6, 
              subq_0.c0 as c7, 
              ref_4.name as c8, 
              ref_1.name as c9, 
              subq_0.c0 as c10
            from 
              main.t0 as ref_4
            where ref_1.name is not NULL))));
