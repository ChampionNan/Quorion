create or replace view semiUp6982367663857825808 as select movie_id as v29, company_id as v1, company_type_id as v8 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct where kind= 'production companies');
create or replace view semiUp198298250358854010 as select v29, v1, v8 from semiUp6982367663857825808 where (v1) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp2227437330612718689 as select movie_id as v29, info_type_id as v21 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'genres') and info IN ('Drama','Horror');
create or replace view semiUp584923883672246657 as select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx AS mi_idx where (movie_id) in (select v29 from semiUp2227437330612718689) and info>'8.0';
create or replace view semiUp979866159680982635 as select v29, v1, v8 from semiUp198298250358854010 where (v29) in (select id from title AS t where production_year<=2008 and production_year>=2005);
create or replace view semiUp6006484809007048113 as select v29, v26, v27 from semiUp584923883672246657 where (v26) in (select id from info_type AS it2 where info= 'rating');
create or replace view semiUp5246692168763615959 as select v29, v1, v8 from semiUp979866159680982635 where (v29) in (select v29 from semiUp6006484809007048113);
create or replace view semiDown8381937016447387070 as select id as v8 from company_type AS ct where (id) in (select v8 from semiUp5246692168763615959) and kind= 'production companies';
create or replace view semiDown1246773372409032079 as select v29, v26, v27 from semiUp6006484809007048113 where (v29) in (select v29 from semiUp5246692168763615959);
create or replace view semiDown373891388998709024 as select id as v1, name as v2 from company_name AS cn where (id) in (select v1 from semiUp5246692168763615959) and country_code= '[us]';
create or replace view semiDown5734524199182694000 as select id as v29, title as v30 from title AS t where (id) in (select v29 from semiUp5246692168763615959) and production_year<=2008 and production_year>=2005;
create or replace view semiDown1127851351516554920 as select id as v26 from info_type AS it2 where (id) in (select v26 from semiDown1246773372409032079) and info= 'rating';
create or replace view semiDown1778558978488855014 as select v29, v21 from semiUp2227437330612718689 where (v29) in (select v29 from semiDown1246773372409032079);
create or replace view semiDown9154468331102888690 as select id as v21 from info_type AS it1 where (id) in (select v21 from semiDown1778558978488855014) and info= 'genres';
create or replace view aggView1669577490397157909 as select v21 from semiDown9154468331102888690;
create or replace view aggJoin5703986398561810022 as select v29 from semiDown1778558978488855014 join aggView1669577490397157909 using(v21);
create or replace view aggView2351789069421053535 as select v26 from semiDown1127851351516554920;
create or replace view aggJoin5784258511673732995 as select v29, v27 from semiDown1246773372409032079 join aggView2351789069421053535 using(v26);
create or replace view aggView6847035525463960302 as select v29 from aggJoin5703986398561810022 group by v29;
create or replace view aggJoin8630616905964869524 as select v29, v27 from aggJoin5784258511673732995 join aggView6847035525463960302 using(v29);
create or replace view aggView1367113484099351221 as select v8 from semiDown8381937016447387070;
create or replace view aggJoin8814761992625661067 as select v29, v1 from semiUp5246692168763615959 join aggView1367113484099351221 using(v8);
create or replace view aggView2730708643859569568 as select v29, MIN(v27) as v42 from aggJoin8630616905964869524 group by v29;
create or replace view aggJoin1512024673706148221 as select v29, v1, v42 from aggJoin8814761992625661067 join aggView2730708643859569568 using(v29);
create or replace view aggView1339244941808177213 as select v1, v2 as v41 from semiDown373891388998709024;
create or replace view aggJoin8540781313043895144 as select v29, v42, v41 from aggJoin1512024673706148221 join aggView1339244941808177213 using(v1);
create or replace view aggView4822672041164984147 as select v29, v30 as v43 from semiDown5734524199182694000;
create or replace view aggJoin3663404479299490503 as select v42, v41, v43 from aggJoin8540781313043895144 join aggView4822672041164984147 using(v29);
select MIN(v41) as v41, MIN(v42) as v42, MIN(v43) as v43 from aggJoin3663404479299490503;

