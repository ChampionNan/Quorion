create or replace view aggView2023109325014609204 as select id as v10 from info_type as it2 where info= 'rating';
create or replace view aggJoin8707113803013432049 as select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView2023109325014609204 where mi_idx.info_type_id=aggView2023109325014609204.v10 and info>'8.0';
create or replace view aggView4996986813864496854 as select v31, MIN(v20) as v44 from aggJoin8707113803013432049 group by v31;
create or replace view aggJoin3147298397027853538 as select id as v31, title as v32, production_year as v35, v44 from title as t, aggView4996986813864496854 where t.id=aggView4996986813864496854.v31 and production_year>=2008 and production_year<=2014;
create or replace view aggView1605820179846056383 as select v31, MIN(v44) as v44, MIN(v32) as v45 from aggJoin3147298397027853538 group by v31;
create or replace view aggJoin5969477144111488387 as select movie_id as v31, info_type_id as v8, info as v15, v44, v45 from movie_info as mi, aggView1605820179846056383 where mi.movie_id=aggView1605820179846056383.v31 and info IN ('Horror','Thriller');
create or replace view aggView5957999496858144544 as select id as v8 from info_type as it1 where info= 'genres';
create or replace view aggJoin1800144733558406394 as select v31, v15, v44, v45 from aggJoin5969477144111488387 join aggView5957999496858144544 using(v8);
create or replace view aggView6369399431381985436 as select v31, MIN(v44) as v44, MIN(v45) as v45, MIN(v15) as v43 from aggJoin1800144733558406394 group by v31;
create or replace view aggJoin4058026277904746642 as select person_id as v22, note as v5, v44, v45, v43 from cast_info as ci, aggView6369399431381985436 where ci.movie_id=aggView6369399431381985436.v31 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)');
create or replace view aggView1846755951290242851 as select v22, MIN(v44) as v44, MIN(v45) as v45, MIN(v43) as v43 from aggJoin4058026277904746642 group by v22;
create or replace view aggJoin4945698911071935231 as select gender as v26, v44, v45, v43 from name as n, aggView1846755951290242851 where n.id=aggView1846755951290242851.v22 and gender= 'f';
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4945698911071935231;
