create or replace view semiUp8450952778802662601 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiUp1905639599233158156 as select movie_id as v12 from movie_info AS mi where (movie_id) in (select v12 from semiUp8450952778802662601) and info= 'Bulgaria';
create or replace view semiUp3093851794404103045 as select id as v12, title as v13 from title AS t where (id) in (select v12 from semiUp1905639599233158156) and production_year>2010;
create or replace view tAux71 as select v13 from semiUp3093851794404103045;
create or replace view semiDown5190563490017427377 as select v12, v13 from semiUp3093851794404103045 where (v13) in (select v13 from tAux71);
create or replace view semiDown2249265572425982 as select v12 from semiUp1905639599233158156 where (v12) in (select v12 from semiDown5190563490017427377);
create or replace view semiDown5713168530280484749 as select v12, v1 from semiUp8450952778802662601 where (v12) in (select v12 from semiDown2249265572425982);
create or replace view semiDown5889871269802857942 as select id as v1 from keyword AS k where (id) in (select v1 from semiDown5713168530280484749) and keyword LIKE '%sequel%';
create or replace view aggView4890533578027236037 as select v1 from semiDown5889871269802857942;
create or replace view aggJoin6739105713713326108 as select v12 from semiDown5713168530280484749 join aggView4890533578027236037 using(v1);
create or replace view aggView7445084370392135694 as select v12 from aggJoin6739105713713326108 group by v12;
create or replace view aggJoin8081153321457785118 as select v12 from semiDown2249265572425982 join aggView7445084370392135694 using(v12);
create or replace view aggView5702178987572284309 as select v12 from aggJoin8081153321457785118 group by v12;
create or replace view aggJoin4561141060514491298 as select v13 from semiDown5190563490017427377 join aggView5702178987572284309 using(v12);
create or replace view aggView9056577853741089143 as select v13, MIN(v13) as v24 from aggJoin4561141060514491298 group by v13;
select MIN(v24) as v24 from aggView9056577853741089143;