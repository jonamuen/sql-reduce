select  
  subq_1.c4 as c0, 
  (select name from main.t0 limit 1 offset 5)
     as c1, 
  subq_1.c4 as c2
from 
  (select  
        subq_0.c2 as c0, 
        subq_0.c2 as c1, 
        subq_0.c1 as c2, 
        96 as c3, 
        subq_0.c1 as c4, 
        subq_0.c1 as c5
      from 
        main.t0 as ref_0
          inner join (select  
                ref_1.name as c0, 
                ref_1.id as c1, 
                (select name from main.t0 limit 1 offset 6)
                   as c2
              from 
                main.t0 as ref_1
              where 0) as subq_0
          on (subq_0.c1 is NULL)
      where 1) as subq_1
where (select id from main.t0 limit 1 offset 5)
     is not NULL;
