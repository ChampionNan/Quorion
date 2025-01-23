create or replace view semiUp5030223956077177134 as select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx AS mi_idx where (movie_id) in (select id from title AS t where production_year>=2000 and production_year<=2010) and info>'7.0';
create or replace view semiUp535103681813788257 as select movie_id as v29, company_id as v1, company_type_id as v8 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct where kind= 'production companies');
create or replace view semiUp3307125830434311675 as select movie_id as v29, info_type_id as v21 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'genres') and info IN ('Drama','Horror','Western','Family');
create or replace view semiUp5243937350087888865 as select v29, v1, v8 from semiUp535103681813788257 where (v1) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp6456271803029250260 as select v29, v26, v27 from semiUp5030223956077177134 where (v26) in (select id from info_type AS it2 where info= 'rating');
create or replace view semiUp227276581820475632 as select v29, v26, v27 from semiUp6456271803029250260 where (v29) in (select v29 from semiUp3307125830434311675);
create or replace view semiUp8372282100901076209 as select v29, v1, v8 from semiUp5243937350087888865 where (v29) in (select v29 from semiUp227276581820475632);
create or replace view semiDown3322710235632237566 as select id as v8 from company_type AS ct where (id) in (select v8 from semiUp8372282100901076209) and kind= 'production companies';
create or replace view semiDown8723864024522982708 as select id as v1, name as v2 from company_name AS cn where (id) in (select v1 from semiUp8372282100901076209) and country_code= '[us]';
create or replace view semiDown3225650861454629716 as select v29, v26, v27 from semiUp227276581820475632 where (v29) in (select v29 from semiUp8372282100901076209);
create or replace view semiDown8048975844987066734 as select id as v26 from info_type AS it2 where (id) in (select v26 from semiDown3225650861454629716) and info= 'rating';
create or replace view semiDown5508130114605370375 as select v29, v21 from semiUp3307125830434311675 where (v29) in (select v29 from semiDown3225650861454629716);
create or replace view semiDown2347735318652139648 as select id as v29, title as v30 from title AS t where (id) in (select v29 from semiDown3225650861454629716) and production_year>=2000 and production_year<=2010;
create or replace view semiDown736028381573241022 as select id as v21 from info_type AS it1 where (id) in (select v21 from semiDown5508130114605370375) and info= 'genres';
create or replace view aggView5858417253207238928 as select v21 from semiDown736028381573241022;
create or replace view aggJoin9204803583733009455 as select v29 from semiDown5508130114605370375 join aggView5858417253207238928 using(v21);
create or replace view aggView818109859919543591 as select v26 from semiDown8048975844987066734;
create or replace view aggJoin6816847497503227374 as select v29, v27 from semiDown3225650861454629716 join aggView818109859919543591 using(v26);
create or replace view aggView2506834263815800025 as select v29, v30 as v43 from semiDown2347735318652139648;
create or replace view aggJoin6276971401133335500 as select v29, v27, v43 from aggJoin6816847497503227374 join aggView2506834263815800025 using(v29);
create or replace view aggView8449422432007975600 as select v29 from aggJoin9204803583733009455 group by v29;
create or replace view aggJoin6347104017568056241 as select v29, v27, v43 as v43 from aggJoin6276971401133335500 join aggView8449422432007975600 using(v29);
create or replace view aggView1019685843813833510 as select v8 from semiDown3322710235632237566;
create or replace view aggJoin7619100451699012905 as select v29, v1 from semiUp8372282100901076209 join aggView1019685843813833510 using(v8);
create or replace view aggView5355366064211434906 as select v1, v2 as v41 from semiDown8723864024522982708;
create or replace view aggJoin2793020847925700278 as select v29, v41 from aggJoin7619100451699012905 join aggView5355366064211434906 using(v1);
create or replace view aggView3246443037220293832 as select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin6347104017568056241 group by v29,v43;
create or replace view aggJoin4923334353472638331 as select v41 as v41, v43, v42 from aggJoin2793020847925700278 join aggView3246443037220293832 using(v29);
select MIN(v41) as v41, MIN(v42) as v42, MIN(v43) as v43 from aggJoin4923334353472638331;

