create or replace view semiUp5042487357552463437 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiUp5007787958307952280 as select v14, v3 from semiUp5042487357552463437 where (v14) in (select id from title AS t where production_year>1990);
create or replace view semiUp5281102936873023867 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it where info= 'rating') and info>'2.0';
create or replace view semiUp4592063935950888069 as select v14, v3 from semiUp5007787958307952280 where (v14) in (select v14 from semiUp5281102936873023867);
create or replace view semiDown3552950337239242418 as select id as v3 from keyword AS k where (id) in (select v3 from semiUp4592063935950888069) and keyword LIKE '%sequel%';
create or replace view semiDown941855952513311156 as select v14, v1, v9 from semiUp5281102936873023867 where (v14) in (select v14 from semiUp4592063935950888069);
create or replace view semiDown2216675685570788461 as select id as v14, title as v15 from title AS t where (id) in (select v14 from semiUp4592063935950888069) and production_year>1990;
create or replace view semiDown2617567818873244701 as select id as v1 from info_type AS it where (id) in (select v1 from semiDown941855952513311156) and info= 'rating';
create or replace view aggView1833738541614014303 as select v1 from semiDown2617567818873244701;
create or replace view aggJoin7667896822036132406 as select v14, v9 from semiDown941855952513311156 join aggView1833738541614014303 using(v1);
create or replace view aggView5475632423670461302 as select v14, v15 as v27 from semiDown2216675685570788461;
create or replace view aggJoin6883160492821908642 as select v14, v3, v27 from semiUp4592063935950888069 join aggView5475632423670461302 using(v14);
create or replace view aggView5048854524652160825 as select v3 from semiDown3552950337239242418;
create or replace view aggJoin9025872682526759621 as select v14, v27 from aggJoin6883160492821908642 join aggView5048854524652160825 using(v3);
create or replace view aggView3096018715952210693 as select v14, MIN(v9) as v26 from aggJoin7667896822036132406 group by v14;
create or replace view aggJoin8840247296962992975 as select v27 as v27, v26 from aggJoin9025872682526759621 join aggView3096018715952210693 using(v14);
select MIN(v26) as v26, MIN(v27) as v27 from aggJoin8840247296962992975;