create or replace view aggView3931131792898379533 as select id as v10 from info_type as it where info= 'rating';
create or replace view aggJoin8695014632533445863 as select movie_id as v22, info as v29 from movie_info_idx as mi_idx, aggView3931131792898379533 where mi_idx.info_type_id=aggView3931131792898379533.v10;
create or replace view aggView817237423198572639 as select v22, MIN(v29) as v44 from aggJoin8695014632533445863 group by v22;
create or replace view aggJoin6949190121351735321 as select movie_id as v22, company_id as v1, company_type_id as v8, v44 from movie_companies as mc, aggView817237423198572639 where mc.movie_id=aggView817237423198572639.v22;
create or replace view aggView5936974844819620255 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin7319198372988917775 as select v22, v8, v44 from aggJoin6949190121351735321 join aggView5936974844819620255 using(v1);
create or replace view aggView1657037092680759627 as select id as v14 from kind_type as kt where kind= 'movie';
create or replace view aggJoin632101080554830078 as select id as v22, title as v32 from title as t, aggView1657037092680759627 where t.kind_id=aggView1657037092680759627.v14;
create or replace view aggView8675173195137240885 as select id as v12 from info_type as it2 where info= 'release dates';
create or replace view aggJoin5530699232275257875 as select movie_id as v22, info as v24 from movie_info as mi, aggView8675173195137240885 where mi.info_type_id=aggView8675173195137240885.v12;
create or replace view aggView1859095671000260946 as select id as v8 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2012722994690671788 as select v22, v44 from aggJoin7319198372988917775 join aggView1859095671000260946 using(v8);
create or replace view aggView6058709650481707112 as select v22, MIN(v44) as v44 from aggJoin2012722994690671788 group by v22;
create or replace view aggJoin4742100293870568968 as select v22, v32, v44 from aggJoin632101080554830078 join aggView6058709650481707112 using(v22);
create or replace view aggView2812331833080115014 as select v22, MIN(v44) as v44, MIN(v32) as v45 from aggJoin4742100293870568968 group by v22;
create or replace view aggJoin4847189512789021271 as select v24, v44, v45 from aggJoin5530699232275257875 join aggView2812331833080115014 using(v22);
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4847189512789021271;
