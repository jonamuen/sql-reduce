select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  (select id from main.t0 limit 1 offset 6)
     as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where (ref_0.id is not NULL) 
  or (((EXISTS (
        select  
            ref_0.id as c0, 
            27 as c1
          from 
            main.t0 as ref_1
          where ((0) 
              or ((ref_1.id is NULL) 
                or (0))) 
            or (ref_0.id is not NULL))) 
      and (EXISTS (
        select  
            ref_2.name as c0
          from 
            main.t0 as ref_2
          where EXISTS (
            select  
                (select name from main.t0 limit 1 offset 4)
                   as c0, 
                ref_0.id as c1, 
                ref_2.name as c2, 
                ref_3.name as c3
              from 
                main.t0 as ref_3
              where ref_2.name is NULL)
          limit 147))) 
    and (((ref_0.id is NULL) 
        and (ref_0.name is NULL)) 
      and (((ref_0.name is not NULL) 
          and (EXISTS (
            select  
                ref_0.id as c0, 
                ref_0.name as c1
              from 
                main.t0 as ref_4
              where (select id from main.t0 limit 1 offset 6)
                   is NULL))) 
        or ((EXISTS (
            select  
                ref_0.name as c0, 
                21 as c1
              from 
                main.t0 as ref_5
              where 1
              limit 151)) 
          or (63 is NULL)))));
