create or replace view semiUp2028488402886901992 as select movie_id as v12, keyword_id as v1 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiUp1825276895096577342 as select movie_id as v12 from movie_info AS mi where (movie_id) in (select v12 from semiUp2028488402886901992) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view semiUp7229823681794126650 as select id as v12, title as v13 from title AS t where (id) in (select v12 from semiUp1825276895096577342) and production_year>1990;
create or replace view tAux27 as select v13 from semiUp7229823681794126650;
create or replace view semiDown180152798277247984 as select v12, v13 from semiUp7229823681794126650 where (v13) in (select v13 from tAux27);
create or replace view semiDown505869053248120145 as select v12 from semiUp1825276895096577342 where (v12) in (select v12 from semiDown180152798277247984);
create or replace view semiDown4622706880635948703 as select v12, v1 from semiUp2028488402886901992 where (v12) in (select v12 from semiDown505869053248120145);
create or replace view semiDown1838814811587967790 as select id as v1 from keyword AS k where (id) in (select v1 from semiDown4622706880635948703) and keyword LIKE '%sequel%';
create or replace view aggView1130871856436432711 as select v1 from semiDown1838814811587967790;
create or replace view aggJoin3376889733697373370 as select v12 from semiDown4622706880635948703 join aggView1130871856436432711 using(v1);
create or replace view aggView6776853880965917341 as select v12 from aggJoin3376889733697373370 group by v12;
create or replace view aggJoin3765026999865490945 as select v12 from semiDown505869053248120145 join aggView6776853880965917341 using(v12);
create or replace view aggView8402567805685523306 as select v12 from aggJoin3765026999865490945 group by v12;
create or replace view aggJoin6868012821358090913 as select v13 from semiDown180152798277247984 join aggView8402567805685523306 using(v12);
create or replace view aggView8690198756609597675 as select v13, MIN(v13) as v24 from aggJoin6868012821358090913 group by v13;
select MIN(v24) as v24 from aggView8690198756609597675;
