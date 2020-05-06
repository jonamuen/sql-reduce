select  
  case when (((ref_0.id is NULL) 
          or ((0) 
            and ((ref_0.name is NULL) 
              and ((EXISTS (
                  select  
                      ref_0.id as c0, 
                      ref_0.id as c1
                    from 
                      main.t0 as ref_1
                    where EXISTS (
                      select  
                          ref_2.name as c0
                        from 
                          main.t0 as ref_2
                        where ref_2.name is not NULL)
                    limit 99)) 
                or (EXISTS (
                  select  
                      ref_0.id as c0, 
                      ref_0.name as c1, 
                      ref_3.name as c2
                    from 
                      main.t0 as ref_3
                    where 1
                    limit 123)))))) 
        and (EXISTS (
          select distinct 
              ref_4.id as c0, 
              ref_4.name as c1, 
              ref_4.name as c2, 
              ref_4.id as c3, 
              ref_0.id as c4, 
              ref_4.name as c5
            from 
              main.t0 as ref_4
            where (0) 
              or (0)
            limit 126))) 
      or ((ref_0.name is NULL) 
        or (66 is NULL)) then 35 else 35 end
     as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  (select id from main.t0 limit 1 offset 3)
     as c5
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 73;
