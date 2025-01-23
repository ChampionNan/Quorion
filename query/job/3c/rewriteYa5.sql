create or replace view semiUp8225196710145038978 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (movie_id) in (select movie_id from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view semiUp4858388859675807153 as select v12, v1 from semiUp8225196710145038978 where (v12) in (select id from title AS t where production_year>1990);
create or replace view semiUp6406662733523823437 as select v12, v1 from semiUp4858388859675807153 where (v1) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiDown4457185752121438422 as select id as v1 from keyword AS k where (id) in (select v1 from semiUp6406662733523823437) and keyword LIKE '%sequel%';
create or replace view semiDown4818535061918045733 as select movie_id as v12 from movie_info AS mi where (movie_id) in (select v12 from semiUp6406662733523823437) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiDown5563100554665025551 as select id as v12, title as v13 from title AS t where (id) in (select v12 from semiUp6406662733523823437) and production_year>1990;
create or replace view aggView7219567318829945200 as select v1 from semiDown4457185752121438422;
create or replace view aggJoin7230181221065696013 as select v12 from semiUp6406662733523823437 join aggView7219567318829945200 using(v1);
create or replace view aggView3165366028286268196 as select v12 from semiDown4818535061918045733 group by v12;
create or replace view aggJoin7112909275060447910 as select v12 from aggJoin7230181221065696013 join aggView3165366028286268196 using(v12);
create or replace view aggView1242056929237500687 as select v12, v13 as v24 from semiDown5563100554665025551;
create or replace view aggJoin3683686704568543183 as select v24 from aggJoin7112909275060447910 join aggView1242056929237500687 using(v12);
select MIN(v24) as v24 from aggJoin3683686704568543183;