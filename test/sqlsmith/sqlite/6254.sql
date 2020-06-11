select  
  ref_1.name as c0, 
  ref_0.id as c1, 
  ref_1.name as c2, 
  case when EXISTS (
      select  
          ref_2.name as c0, 
          ref_0.name as c1, 
          ref_0.name as c2, 
          78 as c3, 
          ref_0.name as c4, 
          ref_2.id as c5
        from 
          main.t0 as ref_2
        where ref_1.id is not NULL
        limit 129) then ref_1.id else ref_1.id end
     as c3, 
  ref_1.name as c4
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on ((1) 
        and (((0) 
            or (((ref_1.id is not NULL) 
                or ((1) 
                  and (0))) 
              and ((((0) 
                    and (((0) 
                        and ((0) 
                          and (0))) 
                      and ((ref_1.id is NULL) 
                        or ((0) 
                          and (ref_1.name is not NULL))))) 
                  and (ref_0.id is not NULL)) 
                and ((ref_0.name is not NULL) 
                  and ((1) 
                    or ((ref_1.name is not NULL) 
                      or ((0) 
                        and (ref_0.id is not NULL)))))))) 
          or ((87 is not NULL) 
            and ((ref_0.id is not NULL) 
              and (ref_1.id is not NULL)))))
where (((ref_0.name is not NULL) 
      or ((((((ref_1.id is NULL) 
                or (0)) 
              or (1)) 
            and ((ref_0.id is NULL) 
              and (1))) 
          and ((1) 
            and ((ref_1.name is NULL) 
              or (ref_1.id is NULL)))) 
        or (ref_1.id is NULL))) 
    or (((0) 
        and (1)) 
      or (0))) 
  and (((23 is not NULL) 
      or (EXISTS (
        select distinct 
            ref_3.id as c0, 
            ref_3.name as c1, 
            84 as c2, 
            ref_0.name as c3, 
            42 as c4, 
            (select name from main.t0 limit 1 offset 2)
               as c5, 
            (select name from main.t0 limit 1 offset 6)
               as c6, 
            ref_0.name as c7
          from 
            main.t0 as ref_3
          where ((1) 
              or (ref_0.id is not NULL)) 
            and (1)
          limit 128))) 
    or ((((1) 
          or (1)) 
        or (((ref_1.id is not NULL) 
            and ((((0) 
                  or (ref_0.name is not NULL)) 
                or (ref_1.name is NULL)) 
              or (0))) 
          or (((1) 
              and (ref_1.name is NULL)) 
            and ((((0) 
                  or ((((ref_0.id is not NULL) 
                        and (ref_1.name is not NULL)) 
                      or (((ref_1.id is NULL) 
                          and (((select id from main.t0 limit 1 offset 6)
                                 is NULL) 
                            or (1))) 
                        or ((0) 
                          or (((1) 
                              and (0)) 
                            and ((select id from main.t0 limit 1 offset 6)
                                 is not NULL))))) 
                    or ((0) 
                      and (ref_0.name is not NULL)))) 
                or (0)) 
              and (ref_1.id is NULL))))) 
      or ((0) 
        and (ref_0.name is NULL))))
limit 138;
