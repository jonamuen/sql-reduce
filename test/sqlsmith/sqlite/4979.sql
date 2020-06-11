select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  95 as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.name as c10, 
  ref_0.name as c11, 
  ref_0.id as c12, 
  ref_0.id as c13, 
  ref_0.id as c14, 
  case when ((0) 
        and (0)) 
      or (0) then case when ((((ref_0.id is not NULL) 
              or (ref_0.name is NULL)) 
            and ((1) 
              and (EXISTS (
                select  
                    ref_1.id as c0, 
                    ref_1.id as c1
                  from 
                    main.t0 as ref_1
                  where EXISTS (
                    select  
                        ref_2.name as c0
                      from 
                        main.t0 as ref_2
                      where 1)
                  limit 112)))) 
          or (ref_0.name is not NULL)) 
        or (ref_0.id is NULL) then (select name from main.t0 limit 1 offset 72)
         else (select name from main.t0 limit 1 offset 72)
         end
       else case when ((((ref_0.id is not NULL) 
              or (ref_0.name is NULL)) 
            and ((1) 
              and (EXISTS (
                select  
                    ref_1.id as c0, 
                    ref_1.id as c1
                  from 
                    main.t0 as ref_1
                  where EXISTS (
                    select  
                        ref_2.name as c0
                      from 
                        main.t0 as ref_2
                      where 1)
                  limit 112)))) 
          or (ref_0.name is not NULL)) 
        or (ref_0.id is NULL) then (select name from main.t0 limit 1 offset 72)
         else (select name from main.t0 limit 1 offset 72)
         end
       end
     as c15, 
  ref_0.id as c16, 
  ref_0.name as c17, 
  ref_0.name as c18, 
  (select name from main.t0 limit 1 offset 5)
     as c19, 
  ref_0.name as c20
from 
  main.t0 as ref_0
where (0) 
  or (ref_0.id is NULL);
