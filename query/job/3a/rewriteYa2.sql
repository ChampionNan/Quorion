create or replace view semiUp1199146326806224851 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (movie_id) in (select movie_id from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view semiUp6811424534846615438 as select v12, v1 from semiUp1199146326806224851 where (v1) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiUp3726074209822860598 as select id as v12, title as v13 from title AS t where (id) in (select v12 from semiUp6811424534846615438) and production_year>2005;
create or replace view tAux7 as select v13 from semiUp3726074209822860598;
create or replace view semiDown5695491915427342418 as select v12, v13 from semiUp3726074209822860598 where (v13) in (select v13 from tAux7);
create or replace view semiDown1062481375947172586 as select v12, v1 from semiUp6811424534846615438 where (v12) in (select v12 from semiDown5695491915427342418);
create or replace view semiDown3533884508587798717 as select id as v1 from keyword AS k where (id) in (select v1 from semiDown1062481375947172586) and keyword LIKE '%sequel%';
create or replace view semiDown3186934141215796188 as select movie_id as v12 from movie_info AS mi where (movie_id) in (select v12 from semiDown1062481375947172586) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4651935855951105900 as select v1 from semiDown3533884508587798717;
create or replace view aggJoin1608413467296246178 as select v12 from semiDown1062481375947172586 join aggView4651935855951105900 using(v1);
create or replace view aggView6340398978119637995 as select v12 from semiDown3186934141215796188 group by v12;
create or replace view aggJoin6392028424218558009 as select v12 from aggJoin1608413467296246178 join aggView6340398978119637995 using(v12);
create or replace view aggView5912208338559519040 as select v12 from aggJoin6392028424218558009 group by v12;
create or replace view aggJoin8634221729703779941 as select v13 from semiDown5695491915427342418 join aggView5912208338559519040 using(v12);
create or replace view aggView7887113713756804178 as select v13, MIN(v13) as v24 from aggJoin8634221729703779941 group by v13;
select MIN(v24) as v24 from aggView7887113713756804178;
