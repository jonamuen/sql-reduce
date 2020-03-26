select  
  ref_1.name as c0
from 
  (select  
          ref_0.name as c0, 
          ref_0.name as c1, 
          ref_0.id as c2, 
          ref_0.id as c3, 
          ref_0.name as c4, 
          ref_0.name as c5, 
          ref_0.name as c6, 
          ref_0.name as c7, 
          ref_0.id as c8, 
          ref_0.name as c9, 
          ref_0.name as c10, 
          (select name from main.t0 limit 1 offset 3)
             as c11, 
          ref_0.name as c12, 
          ref_0.id as c13, 
          case when ref_0.id is not NULL then (select name from main.t0 limit 1 offset 5)
               else (select name from main.t0 limit 1 offset 5)
               end
             as c14
        from 
          main.t0 as ref_0
        where 0
        limit 112) as subq_0
    inner join main.t0 as ref_1
    on (ref_1.id is NULL)
where ref_1.name is NULL
limit 112;
