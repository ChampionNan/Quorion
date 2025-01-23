create or replace view aggView1245032287227125094 as select id as v3 from info_type as it2 where info= 'rating';
create or replace view aggJoin7300597542647837298 as select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1245032287227125094 where mi_idx.info_type_id=aggView1245032287227125094.v3 and info<'8.5';
create or replace view aggView2999153154329333797 as select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence');
create or replace view aggJoin6382531265993198662 as select movie_id as v23 from movie_keyword as mk, aggView2999153154329333797 where mk.keyword_id=aggView2999153154329333797.v5;
create or replace view aggView8915847123722593545 as select v23, MIN(v18) as v35 from aggJoin7300597542647837298 group by v23;
create or replace view aggJoin8306682135495723082 as select v23, v35 from aggJoin6382531265993198662 join aggView8915847123722593545 using(v23);
create or replace view aggView8545583389237243508 as select v23, MIN(v35) as v35 from aggJoin8306682135495723082 group by v23;
create or replace view aggJoin1286669842615746218 as select id as v23, title as v24, kind_id as v8, production_year as v27, v35 from title as t, aggView8545583389237243508 where t.id=aggView8545583389237243508.v23 and production_year>2010;
create or replace view aggView1196259142673057750 as select id as v8 from kind_type as kt where kind= 'movie';
create or replace view aggJoin4215011387873546404 as select v23, v24, v27, v35 from aggJoin1286669842615746218 join aggView1196259142673057750 using(v8);
create or replace view aggView1313496191070808291 as select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin4215011387873546404 group by v23;
create or replace view aggJoin863497639414447859 as select info_type_id as v1, info as v13, v35, v36 from movie_info as mi, aggView1313496191070808291 where mi.movie_id=aggView1313496191070808291.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3905314978141101780 as select id as v1 from info_type as it1 where info= 'countries';
create or replace view aggJoin122768242388242949 as select v13, v35, v36 from aggJoin863497639414447859 join aggView3905314978141101780 using(v1);
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin122768242388242949;
