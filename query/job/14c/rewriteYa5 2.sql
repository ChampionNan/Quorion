create or replace view semiUp4182398149426336698 as select movie_id as v23, info_type_id as v3, info as v18 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info<'8.5';
create or replace view semiUp3564436507862382049 as select movie_id as v23, info_type_id as v1 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'countries') and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view semiUp11667462238139062 as select id as v23, title as v24, kind_id as v8 from title AS t where (kind_id) in (select id from kind_type AS kt where kind IN ('movie','episode')) and production_year>2005;
create or replace view semiUp5607847940855960656 as select v23, v3, v18 from semiUp4182398149426336698 where (v23) in (select v23 from semiUp3564436507862382049);
create or replace view mi_idxAux58 as select v23, v18 from semiUp5607847940855960656;
create or replace view semiUp7265823223268886224 as select movie_id as v23, keyword_id as v5 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('murder','murder-in-title','blood','violence'));
create or replace view semiUp5061080313062158721 as select v23, v24, v8 from semiUp11667462238139062 where (v23) in (select v23 from semiUp7265823223268886224);
create or replace view tAux6 as select v23, v24 from semiUp5061080313062158721;
create or replace view semiUp4741552161548186605 as select v23, v18 from mi_idxAux58 where (v23) in (select v23 from tAux6);
create or replace view semiDown6707929100421602679 as select v23, v24 from tAux6 where (v23) in (select v23 from semiUp4741552161548186605);
create or replace view semiDown8524800967195342976 as select v23, v3, v18 from semiUp5607847940855960656 where (v23, v18) in (select v23, v18 from semiUp4741552161548186605);
create or replace view semiDown217162937564290952 as select v23, v24, v8 from semiUp5061080313062158721 where (v23, v24) in (select v23, v24 from semiDown6707929100421602679);
create or replace view semiDown672884770535954536 as select id as v3 from info_type AS it2 where (id) in (select v3 from semiDown8524800967195342976) and info= 'rating';
create or replace view semiDown1745381141971929106 as select v23, v1 from semiUp3564436507862382049 where (v23) in (select v23 from semiDown8524800967195342976);
create or replace view semiDown4442203439382672261 as select id as v8 from kind_type AS kt where (id) in (select v8 from semiDown217162937564290952) and kind IN ('movie','episode');
create or replace view semiDown301030545770881676 as select v23, v5 from semiUp7265823223268886224 where (v23) in (select v23 from semiDown217162937564290952);
create or replace view semiDown5301117617227470189 as select id as v1 from info_type AS it1 where (id) in (select v1 from semiDown1745381141971929106) and info= 'countries';
create or replace view semiDown3031449338158716314 as select id as v5 from keyword AS k where (id) in (select v5 from semiDown301030545770881676) and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view aggView1994382736746144896 as select v5 from semiDown3031449338158716314;
create or replace view aggJoin3316267494746031384 as select v23 from semiDown301030545770881676 join aggView1994382736746144896 using(v5);
create or replace view aggView1217976553858510194 as select v8 from semiDown4442203439382672261;
create or replace view aggJoin7823967032399256973 as select v23, v24 from semiDown217162937564290952 join aggView1217976553858510194 using(v8);
create or replace view aggView5284359124504900455 as select v23 from aggJoin3316267494746031384 group by v23;
create or replace view aggJoin4577127264754947149 as select v23, v24 from aggJoin7823967032399256973 join aggView5284359124504900455 using(v23);
create or replace view aggView2336953229607464245 as select v23, v24, MIN(v24) as v36 from aggJoin4577127264754947149 group by v23,v24;
create or replace view aggView3610910145453454635 as select v1 from semiDown5301117617227470189;
create or replace view aggJoin3850821519933088472 as select v23 from semiDown1745381141971929106 join aggView3610910145453454635 using(v1);
create or replace view aggView293638808501905102 as select v3 from semiDown672884770535954536;
create or replace view aggJoin6193857112377873301 as select v23, v18 from semiDown8524800967195342976 join aggView293638808501905102 using(v3);
create or replace view aggView7960255177533094221 as select v23 from aggJoin3850821519933088472 group by v23;
create or replace view aggJoin8607320592354432071 as select v23, v18 from aggJoin6193857112377873301 join aggView7960255177533094221 using(v23);
create or replace view aggView5465411347134814455 as select v23, v18, MIN(v18) as v35 from aggJoin8607320592354432071 group by v23,v18;
create or replace view aggView5026556281035700361 as select v23, MIN(v36) as v36 from aggView2336953229607464245 group by v23,v36;
create or replace view aggJoin2766264181689613694 as select v35 as v35, v36 from aggView5465411347134814455 join aggView5026556281035700361 using(v23);
select MIN(v35) as v35, MIN(v36) as v36 from aggJoin2766264181689613694;

