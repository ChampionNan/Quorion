create or replace view aggView6165943341538871873 as select id as v20 from info_type as it2 where info= 'rating';
create or replace view aggJoin9041652855811003350 as select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6165943341538871873 where mi_idx.info_type_id=aggView6165943341538871873.v20 and info<'8.5';
create or replace view aggView4588161848945558170 as select v45, MIN(v40) as v58 from aggJoin9041652855811003350 group by v45;
create or replace view aggJoin6309569235444146234 as select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView4588161848945558170 where t.id=aggView4588161848945558170.v45 and production_year>2005;
create or replace view aggView4765869285583050213 as select v45, v25, MIN(v58) as v58, MIN(v46) as v59 from aggJoin6309569235444146234 group by v45,v25;
create or replace view aggJoin4709536927766135717 as select movie_id as v45, info_type_id as v18, info as v35, v25, v58, v59 from movie_info as mi, aggView4765869285583050213 where mi.movie_id=aggView4765869285583050213.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view aggView4299347576952273125 as select id as v18 from info_type as it1 where info= 'countries';
create or replace view aggJoin9081115331641088777 as select v45, v35, v25, v58, v59 from aggJoin4709536927766135717 join aggView4299347576952273125 using(v18);
create or replace view aggView6486121774948213570 as select v45, v25, MIN(v58) as v58, MIN(v59) as v59 from aggJoin9081115331641088777 group by v45,v25;
create or replace view aggJoin6748397243435354523 as select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v25, v58, v59 from movie_companies as mc, aggView6486121774948213570 where mc.movie_id=aggView6486121774948213570.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%';
create or replace view aggView9137728647769395693 as select id as v16 from company_type as ct;
create or replace view aggJoin2560102891455007496 as select v45, v9, v31, v25, v58, v59 from aggJoin6748397243435354523 join aggView9137728647769395693 using(v16);
create or replace view aggView6997878235203904152 as select v45, v25, v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin2560102891455007496 group by v45,v25,v9;
create or replace view aggJoin9092782715123167417 as select movie_id as v45, keyword_id as v22, v25, v9, v58, v59 from movie_keyword as mk, aggView6997878235203904152 where mk.movie_id=aggView6997878235203904152.v45;
create or replace view aggView406067283879832237 as select v25, v22, v45, v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin9092782715123167417 group by v25,v22,v45,v9;
create or replace view aggJoin344328724161571057 as select id as v25, kind as v26, v22, v45, v9, v58, v59 from kind_type as kt, aggView406067283879832237 where kt.id=aggView406067283879832237.v25 and kind IN ('movie','episode');
create or replace view aggView8337642215389438975 as select v22, v45, v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin344328724161571057 group by v22,v45,v9;
create or replace view aggJoin6991325863619969014 as select id as v22, keyword as v23, v45, v9, v58, v59 from keyword as k, aggView8337642215389438975 where k.id=aggView8337642215389438975.v22 and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view aggView442391634510049627 as select v45, v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin6991325863619969014 group by v45,v9;
create or replace view aggJoin4860347034359802603 as select movie_id as v45, subject_id as v5, status_id as v7, v9, v58, v59 from complete_cast as cc, aggView442391634510049627 where cc.movie_id=aggView442391634510049627.v45;
create or replace view aggView362313269802316994 as select id as v5 from comp_cast_type as cct1 where kind= 'cast';
create or replace view aggJoin4892067304184928052 as select v45, v7, v9, v58, v59 from aggJoin4860347034359802603 join aggView362313269802316994 using(v5);
create or replace view aggView5937164505892016321 as select id as v7 from comp_cast_type as cct2 where kind= 'complete';
create or replace view aggJoin6969163930080912318 as select v45, v9, v58, v59 from aggJoin4892067304184928052 join aggView5937164505892016321 using(v7);
create or replace view aggView7415170819194960476 as select v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin6969163930080912318 group by v9;
create or replace view aggJoin6059500137397074646 as select id as v9, name as v10, country_code as v11, v58, v59 from company_name as cn, aggView7415170819194960476 where cn.id=aggView7415170819194960476.v9 and country_code<> '[us]';
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin6059500137397074646;
