select  
  subq_0.c2 as c0, 
  cast(coalesce(subq_0.c18,
    subq_0.c9) as INT) as c1
from 
  (select  
        cast(coalesce(case when 0 then ref_0.name else ref_0.name end
            ,
          cast(null as VARCHAR(16))) as VARCHAR(16)) as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        ref_0.name as c8, 
        case when 0 then ref_0.id else ref_0.id end
           as c9, 
        ref_0.id as c10, 
        ref_0.id as c11, 
        35 as c12, 
        ref_0.id as c13, 
        ref_0.name as c14, 
        93 as c15, 
        ref_0.id as c16, 
        ref_0.name as c17, 
        ref_0.id as c18
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL) as subq_0
where subq_0.c5 is not NULL
limit 57;
