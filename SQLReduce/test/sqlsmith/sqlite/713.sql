select  
  subq_0.c18 as c0, 
  cast(nullif(79,
    cast(nullif(23,
      cast(coalesce(72,
        88) as INTEGER)) as INTEGER)) as INTEGER) as c1
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        case when ref_0.id is NULL then ref_0.id else ref_0.id end
           as c8, 
        ref_0.name as c9, 
        ref_0.name as c10, 
        ref_0.id as c11, 
        ref_0.name as c12, 
        ref_0.id as c13, 
        ref_0.name as c14, 
        ref_0.name as c15, 
        ref_0.id as c16, 
        ref_0.id as c17, 
        case when ref_0.id is NULL then ref_0.id else ref_0.id end
           as c18, 
        ref_0.name as c19, 
        ref_0.id as c20, 
        ref_0.id as c21, 
        ref_0.name as c22, 
        ref_0.id as c23
      from 
        main.t0 as ref_0
      where ((EXISTS (
            select  
                ref_1.name as c0, 
                ref_0.name as c1, 
                ref_0.id as c2, 
                ref_1.id as c3, 
                ref_0.id as c4
              from 
                main.t0 as ref_1
              where (ref_0.name is not NULL) 
                or (1))) 
          and ((ref_0.id is not NULL) 
            or (ref_0.id is NULL))) 
        or (ref_0.id is NULL)
      limit 149) as subq_0
where subq_0.c16 is NULL
limit 118;
