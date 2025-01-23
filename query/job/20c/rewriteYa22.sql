create or replace view semiUp8921791688168104378 as select id as v40, title as v41, kind_id as v26 from title AS t where (kind_id) in (select id from kind_type AS kt where kind= 'movie') and production_year>2000;
create or replace view tAux23 as select v40, v41 from semiUp8921791688168104378;
create or replace view nAux45 as select id as v31, name as v32 from name;
create or replace view semiUp1422288896118852884 as select movie_id as v40, subject_id as v5, status_id as v7 from complete_cast AS cc where (subject_id) in (select id from comp_cast_type AS cct1 where kind= 'cast');
create or replace view semiUp1769200410086818074 as select person_id as v31, movie_id as v40, person_role_id as v9 from cast_info AS ci where (person_id) in (select v31 from nAux45);
create or replace view semiUp2725866855755514214 as select movie_id as v40, keyword_id as v23 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'));
create or replace view semiUp3678261551491020330 as select v31, v40, v9 from semiUp1769200410086818074 where (v9) in (select id from char_name AS chn where ((name LIKE '%man%') OR (name LIKE '%Man%')));
create or replace view semiUp2601817810066106239 as select v40, v5, v7 from semiUp1422288896118852884 where (v7) in (select id from comp_cast_type AS cct2 where kind LIKE '%complete%');
create or replace view semiUp4979696134830690005 as select v31, v40, v9 from semiUp3678261551491020330 where (v40) in (select v40 from semiUp2601817810066106239);
create or replace view semiUp4057179088360749503 as select v31, v40, v9 from semiUp4979696134830690005 where (v40) in (select v40 from semiUp2725866855755514214);
create or replace view semiUp3417880106272192403 as select v40, v41 from tAux23 where (v40) in (select v40 from semiUp4057179088360749503);
create or replace view semiDown4614695794265333346 as select v40, v41, v26 from semiUp8921791688168104378 where (v40, v41) in (select v40, v41 from semiUp3417880106272192403);
create or replace view semiDown3749149307788212097 as select v31, v40, v9 from semiUp4057179088360749503 where (v40) in (select v40 from semiUp3417880106272192403);
create or replace view semiDown560324729511657114 as select id as v26 from kind_type AS kt where (id) in (select v26 from semiDown4614695794265333346) and kind= 'movie';
create or replace view semiDown8759456128864340870 as select v40, v5, v7 from semiUp2601817810066106239 where (v40) in (select v40 from semiDown3749149307788212097);
create or replace view semiDown5316894364360026195 as select id as v9 from char_name AS chn where (id) in (select v9 from semiDown3749149307788212097) and ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view semiDown8235181670001821267 as select v31, v32 from nAux45 where (v31) in (select v31 from semiDown3749149307788212097);
create or replace view semiDown4341621711540919980 as select v40, v23 from semiUp2725866855755514214 where (v40) in (select v40 from semiDown3749149307788212097);
create or replace view semiDown1722424670240695966 as select id as v7 from comp_cast_type AS cct2 where (id) in (select v7 from semiDown8759456128864340870) and kind LIKE '%complete%';
create or replace view semiDown8973518680645605370 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown8759456128864340870) and kind= 'cast';
create or replace view semiDown6937207621147932606 as select id as v31, name as v32 from name AS n where (id, name) in (select v31, v32 from semiDown8235181670001821267);
create or replace view semiDown8342727856868863315 as select id as v23 from keyword AS k where (id) in (select v23 from semiDown4341621711540919980) and keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser');
create or replace view aggView116838939142331232 as select v32, v31, v32 as v52 from semiDown6937207621147932606;
create or replace view aggView4411016431543335080 as select v26 from semiDown560324729511657114;
create or replace view aggJoin3428255815528417244 as select v40, v41 from semiDown4614695794265333346 join aggView4411016431543335080 using(v26);
create or replace view aggView9118338285035775778 as select v40, v41, MIN(v41) as v53 from aggJoin3428255815528417244 group by v40,v41;
create or replace view aggView3551132717874176027 as select v23 from semiDown8342727856868863315;
create or replace view aggJoin7115203753636972267 as select v40 from semiDown4341621711540919980 join aggView3551132717874176027 using(v23);
create or replace view aggView4869593307755468590 as select v7 from semiDown1722424670240695966;
create or replace view aggJoin4102893319081564576 as select v40, v5 from semiDown8759456128864340870 join aggView4869593307755468590 using(v7);
create or replace view aggView270199652506965218 as select v5 from semiDown8973518680645605370;
create or replace view aggJoin6344405342791310344 as select v40 from aggJoin4102893319081564576 join aggView270199652506965218 using(v5);
create or replace view aggView5111444434535591343 as select v40 from aggJoin7115203753636972267 group by v40;
create or replace view aggJoin6380443292188022073 as select v31, v40, v9 from semiDown3749149307788212097 join aggView5111444434535591343 using(v40);
create or replace view aggView5280063076587773968 as select v9 from semiDown5316894364360026195;
create or replace view aggJoin147938596002565462 as select v31, v40 from aggJoin6380443292188022073 join aggView5280063076587773968 using(v9);
create or replace view aggView2085225128209016151 as select v31, MIN(v52) as v52 from aggView116838939142331232 group by v31,v52;
create or replace view aggJoin1175646342272457641 as select v40, v52 from aggJoin147938596002565462 join aggView2085225128209016151 using(v31);
create or replace view aggView8373773319660229185 as select v40 from aggJoin6344405342791310344 group by v40;
create or replace view aggJoin7195926672123811256 as select v40, v52 as v52 from aggJoin1175646342272457641 join aggView8373773319660229185 using(v40);
create or replace view aggView2870259035984506603 as select v40, MIN(v52) as v52 from aggJoin7195926672123811256 group by v40,v52;
create or replace view aggJoin2780364761379638121 as select v53 as v53, v52 from aggView9118338285035775778 join aggView2870259035984506603 using(v40);
select MIN(v52) as v52, MIN(v53) as v53 from aggJoin2780364761379638121;

