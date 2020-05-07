select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  or (((1) 
      or (ref_0.id is NULL)) 
    or (EXISTS (
      select  
          ref_1.name as c0, 
          ref_1.id as c1
        from 
          main.t0 as ref_1
              left join main.t0 as ref_2
              on (ref_1.id = ref_2.id )
            left join main.t0 as ref_3
            on ((EXISTS (
                  select  
                      ref_1.name as c0, 
                      ref_2.name as c1
                    from 
                      main.t0 as ref_4
                    where 0)) 
                or (ref_0.id is not NULL))
        where (0) 
          or (0)
        limit 140)))
limit 187;
