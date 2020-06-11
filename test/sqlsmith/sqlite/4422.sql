select  
  ref_1.id as c0
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on (ref_0.id = ref_1.id )
where (EXISTS (
    select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_2.id as c3, 
        ref_0.id as c4, 
        ref_0.name as c5
      from 
        main.t0 as ref_2
      where ref_0.name is NULL
      limit 153)) 
  or ((((0) 
        and (EXISTS (
          select  
              ref_0.id as c0, 
              ref_3.name as c1, 
              ref_3.name as c2, 
              ref_0.name as c3, 
              ref_1.name as c4, 
              ref_3.name as c5, 
              ref_1.id as c6
            from 
              main.t0 as ref_3
            where (EXISTS (
                select  
                    ref_0.name as c0, 
                    ref_0.name as c1, 
                    ref_4.id as c2
                  from 
                    main.t0 as ref_4
                  where 99 is not NULL)) 
              or (ref_1.name is NULL)
            limit 152))) 
      and ((ref_0.name is NULL) 
        or (ref_0.id is not NULL))) 
    and (EXISTS (
      select  
          (select name from main.t0 limit 1 offset 1)
             as c0
        from 
          main.t0 as ref_5
        where (ref_5.name is NULL) 
          and ((0) 
            or (ref_5.id is not NULL))
        limit 81)));
