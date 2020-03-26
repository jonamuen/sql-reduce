insert into main.t0 values (
cast(nullif(case when 47 is NULL then cast(null as INT) else cast(null as INT) end
    ,
  cast(null as INT)) as INT), 
cast(null as VARCHAR(16)));
