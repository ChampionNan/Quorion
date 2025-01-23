create or replace view aggView2885475767063781243 as select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6042408380281614873 as select movie_id as v40 from movie_keyword as mk, aggView2885475767063781243 where mk.keyword_id=aggView2885475767063781243.v23;
create or replace view aggView26720661271848099 as select v40 from aggJoin6042408380281614873 group by v40;
create or replace view aggJoin7292502522822215329 as select id as v40, title as v41, kind_id as v26, production_year as v44 from title as t, aggView26720661271848099 where t.id=aggView26720661271848099.v40 and production_year>1950;
create or replace view aggView6420054744849203986 as select id as v26 from kind_type as kt where kind= 'movie';
create or replace view aggJoin3979420636579714742 as select v40, v41, v44 from aggJoin7292502522822215329 join aggView6420054744849203986 using(v26);
create or replace view aggView6917545328904672264 as select v40, MIN(v41) as v52 from aggJoin3979420636579714742 group by v40;
create or replace view aggJoin4367005246686062700 as select movie_id as v40, subject_id as v5, status_id as v7, v52 from complete_cast as cc, aggView6917545328904672264 where cc.movie_id=aggView6917545328904672264.v40;
create or replace view aggView8527138831566026195 as select id as v5 from comp_cast_type as cct1 where kind= 'cast';
create or replace view aggJoin159374962019763770 as select v40, v7, v52 from aggJoin4367005246686062700 join aggView8527138831566026195 using(v5);
create or replace view aggView8571362589427655616 as select v7, v40, MIN(v52) as v52 from aggJoin159374962019763770 group by v7,v40;
create or replace view aggJoin6552237780307485942 as select kind as v8, v40, v52 from comp_cast_type as cct2, aggView8571362589427655616 where cct2.id=aggView8571362589427655616.v7 and kind LIKE '%complete%';
create or replace view aggView6140427320919410971 as select v40, MIN(v52) as v52 from aggJoin6552237780307485942 group by v40;
create or replace view aggJoin7430451360698621600 as select person_id as v31, movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView6140427320919410971 where ci.movie_id=aggView6140427320919410971.v40;
create or replace view aggView7264655607538143097 as select v9, v31, MIN(v52) as v52 from aggJoin7430451360698621600 group by v9,v31;
create or replace view aggJoin4059864751398936692 as select name as v10, v31, v52 from char_name as chn, aggView7264655607538143097 where chn.id=aggView7264655607538143097.v9 and ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%';
create or replace view aggView4793595452373784182 as select v31, MIN(v52) as v52 from aggJoin4059864751398936692 group by v31;
create or replace view aggJoin8043061940880470847 as select id as v31, v52 from name as n, aggView4793595452373784182 where n.id=aggView4793595452373784182.v31;
select MIN(v52) as v52 from aggJoin8043061940880470847;
