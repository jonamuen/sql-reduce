insert into main.t0 values (
case when 79 is not NULL then cast(null as INT) else cast(null as INT) end
  , 
cast(coalesce(cast(null as VARCHAR(16)),
  cast(null as VARCHAR(16))) as VARCHAR(16)));
