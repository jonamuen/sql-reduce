select  
  subq_0.c2 as c0, 
  subq_0.c1 as c1, 
  53 as c2, 
  subq_0.c0 as c3
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        case when ((EXISTS (
                select  
                    ref_0.id as c0, 
                    ref_1.name as c1, 
                    ref_0.name as c2, 
                    ref_1.name as c3, 
                    ref_0.id as c4
                  from 
                    main.t0 as ref_1
                  where 0
                  limit 109)) 
              and (0)) 
            and (1) then ref_0.id else ref_0.id end
           as c2
      from 
        main.t0 as ref_0
      where (ref_0.id is NULL) 
        or ((ref_0.name is not NULL) 
          or ((ref_0.name is NULL) 
            or ((ref_0.id is not NULL) 
              or (((1) 
                  and (1)) 
                and (ref_0.name is not NULL)))))) as subq_0
where subq_0.c0 is NULL;
