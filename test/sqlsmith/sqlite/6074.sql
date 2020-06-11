insert into main.t0 values (
cast(coalesce(cast(null as INT),
  cast(coalesce(cast(null as INT),
    case when (1) 
        and (95 is NULL) then cast(null as INT) else cast(null as INT) end
      ) as INT)) as INT), 
cast(null as VARCHAR(16)));
