create or replace view aggView684945467550873255 as select id as v20 from info_type as it2 where info= 'rating';
create or replace view aggJoin659853096930872610 as select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView684945467550873255 where mi_idx.info_type_id=aggView684945467550873255.v20 and info<'8.5';
create or replace view aggView2129378716435729849 as select v45, MIN(v40) as v58 from aggJoin659853096930872610 group by v45;
create or replace view aggJoin139861553470283802 as select movie_id as v45, subject_id as v5, status_id as v7, v58 from complete_cast as cc, aggView2129378716435729849 where cc.movie_id=aggView2129378716435729849.v45;
create or replace view aggView4922861666403100992 as select v45, v7, v5, MIN(v58) as v58 from aggJoin139861553470283802 group by v45,v7,v5;
create or replace view aggJoin619448673993343886 as select id as v45, title as v46, kind_id as v25, production_year as v49, v7, v5, v58 from title as t, aggView4922861666403100992 where t.id=aggView4922861666403100992.v45 and production_year>2005;
create or replace view aggView7528325472834915993 as select id as v25 from kind_type as kt where kind IN ('movie','episode');
create or replace view aggJoin6368396950979988859 as select v45, v46, v49, v7, v5, v58 from aggJoin619448673993343886 join aggView7528325472834915993 using(v25);
create or replace view aggView6201197152428862382 as select v45, v7, v5, MIN(v58) as v58, MIN(v46) as v59 from aggJoin6368396950979988859 group by v45,v7,v5;
create or replace view aggJoin7149434147904428615 as select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v7, v5, v58, v59 from movie_companies as mc, aggView6201197152428862382 where mc.movie_id=aggView6201197152428862382.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%';
create or replace view aggView4069806562680390989 as select v9, v16, v7, v45, v5, MIN(v58) as v58, MIN(v59) as v59 from aggJoin7149434147904428615 group by v9,v16,v7,v45,v5;
create or replace view aggJoin8063517839965055078 as select name as v10, country_code as v11, v16, v7, v45, v5, v58, v59 from company_name as cn, aggView4069806562680390989 where cn.id=aggView4069806562680390989.v9 and country_code<> '[us]';
create or replace view aggView5715904492088574655 as select v5, v16, v7, v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v10) as v57 from aggJoin8063517839965055078 group by v5,v16,v7,v45;
create or replace view aggJoin5024471313641621162 as select id as v5, kind as v6, v16, v7, v45, v58, v59, v57 from comp_cast_type as cct1, aggView5715904492088574655 where cct1.id=aggView5715904492088574655.v5 and kind= 'cast';
create or replace view aggView5738945655923713944 as select v7, v16, v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin5024471313641621162 group by v7,v16,v45;
create or replace view aggJoin5495738447124417707 as select id as v7, kind as v8, v16, v45, v58, v59, v57 from comp_cast_type as cct2, aggView5738945655923713944 where cct2.id=aggView5738945655923713944.v7 and kind= 'complete';
create or replace view aggView8008379526790216984 as select v16, v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin5495738447124417707 group by v16,v45;
create or replace view aggJoin4878832270605879556 as select id as v16, v45, v58, v59, v57 from company_type as ct, aggView8008379526790216984 where ct.id=aggView8008379526790216984.v16;
create or replace view aggView2935739290633196639 as select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin4878832270605879556 group by v45;
create or replace view aggJoin5042485155025515313 as select movie_id as v45, info_type_id as v18, info as v35, v58, v59, v57 from movie_info as mi, aggView2935739290633196639 where mi.movie_id=aggView2935739290633196639.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view aggView6671508129345006286 as select v18, v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin5042485155025515313 group by v18,v45;
create or replace view aggJoin2194210618738690150 as select info as v19, v45, v58, v59, v57 from info_type as it1, aggView6671508129345006286 where it1.id=aggView6671508129345006286.v18 and info= 'countries';
create or replace view aggView7096221584934135597 as select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin2194210618738690150 group by v45;
create or replace view aggJoin4455736671331079885 as select movie_id as v45, keyword_id as v22, v58, v59, v57 from movie_keyword as mk, aggView7096221584934135597 where mk.movie_id=aggView7096221584934135597.v45;
create or replace view aggView5412030984728936242 as select v22, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin4455736671331079885 group by v22;
create or replace view aggJoin3056281540633274131 as select keyword as v23, v58, v59, v57 from keyword as k, aggView5412030984728936242 where k.id=aggView5412030984728936242.v22 and keyword IN ('murder','murder-in-title','blood','violence');
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3056281540633274131;
