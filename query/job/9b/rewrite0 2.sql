create or replace view aggView1893389340200902148 as select person_id as v35, MIN(name) as v58 from aka_name as an group by person_id;
create or replace view aggJoin4020759426674756746 as select id as v35, name as v36, gender as v39, v58 from name as n, aggView1893389340200902148 where n.id=aggView1893389340200902148.v35 and gender= 'f' and name LIKE '%Angel%';
create or replace view aggView5993511315830978647 as select id as v22 from role_type as rt where role= 'actress';
create or replace view aggJoin1060427094280655954 as select person_id as v35, movie_id as v18, person_role_id as v9, note as v20 from cast_info as ci, aggView5993511315830978647 where ci.role_id=aggView5993511315830978647.v22 and note= '(voice)';
create or replace view aggView2296589695565697886 as select v35, MIN(v58) as v58, MIN(v36) as v60 from aggJoin4020759426674756746 group by v35;
create or replace view aggJoin5865120556378118422 as select v18, v9, v20, v58, v60 from aggJoin1060427094280655954 join aggView2296589695565697886 using(v35);
create or replace view aggView5815874630033493521 as select v18, v9, MIN(v58) as v58, MIN(v60) as v60 from aggJoin5865120556378118422 group by v18,v9;
create or replace view aggJoin7838637309734542012 as select movie_id as v18, company_id as v32, note as v34, v9, v58, v60 from movie_companies as mc, aggView5815874630033493521 where mc.movie_id=aggView5815874630033493521.v18 and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%';
create or replace view aggView646107324225408347 as select v18, v32, v9, MIN(v58) as v58, MIN(v60) as v60 from aggJoin7838637309734542012 group by v18,v32,v9;
create or replace view aggJoin7221866902417083559 as select title as v47, production_year as v50, v32, v9, v58, v60 from title as t, aggView646107324225408347 where t.id=aggView646107324225408347.v18 and production_year>=2007 and production_year<=2010;
create or replace view aggView4321762844206240872 as select v32, v9, MIN(v58) as v58, MIN(v60) as v60, MIN(v47) as v61 from aggJoin7221866902417083559 group by v32,v9;
create or replace view aggJoin4538774153065094181 as select id as v32, country_code as v25, v9, v58, v60, v61 from company_name as cn, aggView4321762844206240872 where cn.id=aggView4321762844206240872.v32 and country_code= '[us]';
create or replace view aggView3118818879328207359 as select v9, MIN(v58) as v58, MIN(v60) as v60, MIN(v61) as v61 from aggJoin4538774153065094181 group by v9;
create or replace view aggJoin6743593744918390488 as select id as v9, name as v10, v58, v60, v61 from char_name as chn, aggView3118818879328207359 where chn.id=aggView3118818879328207359.v9;
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6743593744918390488;
