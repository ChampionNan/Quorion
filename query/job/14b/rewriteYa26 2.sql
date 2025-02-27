create or replace view semiUp2260522912411775907 as select movie_id as v23, keyword_id as v5 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('murder','murder-in-title'));
create or replace view semiUp1141570237186886037 as select movie_id as v23, info_type_id as v1 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'countries') and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiUp4014368386882178215 as select id as v23, title as v24, kind_id as v8 from title AS t where (id) in (select v23 from semiUp1141570237186886037) and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%'));
create or replace view semiUp3738830357567310685 as select v23, v24, v8 from semiUp4014368386882178215 where (v8) in (select id from kind_type AS kt where kind= 'movie');
create or replace view semiUp6542281882683365070 as select movie_id as v23, info_type_id as v3, info as v18 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info>'6.0';
create or replace view semiUp8449789416341629171 as select v23, v5 from semiUp2260522912411775907 where (v23) in (select v23 from semiUp3738830357567310685);
create or replace view semiUp7277273529549236820 as select v23, v5 from semiUp8449789416341629171 where (v23) in (select v23 from semiUp6542281882683365070);
create or replace view semiDown6948140636665750803 as select id as v5 from keyword AS k where (id) in (select v5 from semiUp7277273529549236820) and keyword IN ('murder','murder-in-title');
create or replace view semiDown9203083785583930193 as select v23, v24, v8 from semiUp3738830357567310685 where (v23) in (select v23 from semiUp7277273529549236820);
create or replace view semiDown4803163039193055021 as select v23, v3, v18 from semiUp6542281882683365070 where (v23) in (select v23 from semiUp7277273529549236820);
create or replace view semiDown2011127081469264786 as select id as v8 from kind_type AS kt where (id) in (select v8 from semiDown9203083785583930193) and kind= 'movie';
create or replace view semiDown8601444967725799047 as select v23, v1 from semiUp1141570237186886037 where (v23) in (select v23 from semiDown9203083785583930193);
create or replace view semiDown606525682311975147 as select id as v3 from info_type AS it2 where (id) in (select v3 from semiDown4803163039193055021) and info= 'rating';
create or replace view semiDown4089085753107308012 as select id as v1 from info_type AS it1 where (id) in (select v1 from semiDown8601444967725799047) and info= 'countries';
create or replace view aggView8871899295701725108 as select v1 from semiDown4089085753107308012;
create or replace view aggJoin5007830100343727830 as select v23 from semiDown8601444967725799047 join aggView8871899295701725108 using(v1);
create or replace view aggView7237813606551977314 as select v23 from aggJoin5007830100343727830 group by v23;
create or replace view aggJoin963070590047278637 as select v23, v24, v8 from semiDown9203083785583930193 join aggView7237813606551977314 using(v23);
create or replace view aggView3475927686652574467 as select v8 from semiDown2011127081469264786;
create or replace view aggJoin3265302545624730177 as select v23, v24 from aggJoin963070590047278637 join aggView3475927686652574467 using(v8);
create or replace view aggView3734367200973748571 as select v3 from semiDown606525682311975147;
create or replace view aggJoin371797918552959499 as select v23, v18 from semiDown4803163039193055021 join aggView3734367200973748571 using(v3);
create or replace view aggView4731831318673975478 as select v23, MIN(v18) as v35 from aggJoin371797918552959499 group by v23;
create or replace view aggJoin1210809050980822284 as select v23, v5, v35 from semiUp7277273529549236820 join aggView4731831318673975478 using(v23);
create or replace view aggView900415453549287383 as select v23, MIN(v24) as v36 from aggJoin3265302545624730177 group by v23;
create or replace view aggJoin3669419475752950026 as select v5, v35 as v35, v36 from aggJoin1210809050980822284 join aggView900415453549287383 using(v23);
create or replace view aggView2696423807882375492 as select v5 from semiDown6948140636665750803;
create or replace view aggJoin2211415806963858414 as select v35, v36 from aggJoin3669419475752950026 join aggView2696423807882375492 using(v5);
select MIN(v35) as v35, MIN(v36) as v36 from aggJoin2211415806963858414;

