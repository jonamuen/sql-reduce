WITH 
jennifer_0 AS (select  
    ref_0.name as c0, 
    ref_0.name as c1, 
    ref_0.id as c2, 
    (select name from main.t0 limit 1 offset 4)
       as c3, 
    ref_0.id as c4
  from 
    main.t0 as ref_0
  where (select id from main.t0 limit 1 offset 6)
       is NULL
  limit 99)
select  
    cast(coalesce(ref_1.name,
      ref_1.name) as VARCHAR(16)) as c0, 
    79 as c1, 
    ref_1.id as c2, 
    ref_1.id as c3, 
    39 as c4, 
    ref_1.id as c5
  from 
    main.t0 as ref_1
  where ((ref_1.name is not NULL) 
      and (1)) 
    and ((1) 
      or ((ref_1.name is NULL) 
        and ((1) 
          or (ref_1.id is not NULL))))
  limit 69
;
