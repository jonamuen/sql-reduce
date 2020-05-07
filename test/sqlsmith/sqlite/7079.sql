insert into main.t0 values (
cast(nullif(cast(null as INT),
  case when ((4 is not NULL) 
        or (67 is NULL)) 
      and (1) then cast(null as INT) else cast(null as INT) end
    ) as INT), 
cast(null as VARCHAR(16)));
