create or replace view semiUp8913181658860086553 as select person_id as v26, movie_id as v3 from cast_info AS ci where (person_id) in (select id from name AS n where name LIKE 'Z%');
create or replace view semiUp545066171476062016 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiUp8686780001557050740 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select id from company_name AS cn);
create or replace view semiUp3354550579182505384 as select v3, v25 from semiUp545066171476062016 where (v3) in (select v3 from semiUp8686780001557050740);
create or replace view semiUp359919739536452633 as select v26, v3 from semiUp8913181658860086553 where (v3) in (select v3 from semiUp3354550579182505384);
create or replace view semiUp6837102656220251606 as select v26, v3 from semiUp359919739536452633 where (v3) in (select id from title AS t);
create or replace view semiDown8105117552348477735 as select id as v26, name as v27 from name AS n where (id) in (select v26 from semiUp6837102656220251606) and name LIKE 'Z%';
create or replace view semiDown1902683030043804288 as select id as v3 from title AS t where (id) in (select v3 from semiUp6837102656220251606);
create or replace view semiDown8530749565350742325 as select v3, v25 from semiUp3354550579182505384 where (v3) in (select v3 from semiUp6837102656220251606);
create or replace view semiDown8385631086050118301 as select id as v25 from keyword AS k where (id) in (select v25 from semiDown8530749565350742325) and keyword= 'character-name-in-title';
create or replace view semiDown1515238775127979809 as select v3, v20 from semiUp8686780001557050740 where (v3) in (select v3 from semiDown8530749565350742325);
create or replace view semiDown4478581086086733293 as select id as v20 from company_name AS cn where (id) in (select v20 from semiDown1515238775127979809);
create or replace view aggView7766498171469424897 as select v20 from semiDown4478581086086733293;
create or replace view aggJoin8166023147594265595 as select v3 from semiDown1515238775127979809 join aggView7766498171469424897 using(v20);
create or replace view aggView6790112820968060346 as select v3 from aggJoin8166023147594265595 group by v3;
create or replace view aggJoin679929670200504558 as select v3, v25 from semiDown8530749565350742325 join aggView6790112820968060346 using(v3);
create or replace view aggView6319122858300758390 as select v25 from semiDown8385631086050118301;
create or replace view aggJoin1425923595530190449 as select v3 from aggJoin679929670200504558 join aggView6319122858300758390 using(v25);
create or replace view aggView8744320110442035077 as select v3 from semiDown1902683030043804288;
create or replace view aggJoin8824144920770845543 as select v26, v3 from semiUp6837102656220251606 join aggView8744320110442035077 using(v3);
create or replace view aggView256017388340457731 as select v26, v27 as v47 from semiDown8105117552348477735;
create or replace view aggJoin433283988315903050 as select v3, v47 from aggJoin8824144920770845543 join aggView256017388340457731 using(v26);
create or replace view aggView6729845643909161923 as select v3 from aggJoin1425923595530190449 group by v3;
create or replace view aggJoin4161741080426002351 as select v47 as v47 from aggJoin433283988315903050 join aggView6729845643909161923 using(v3);
select MIN(v47) as v47 from aggJoin4161741080426002351;

