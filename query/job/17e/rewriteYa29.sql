create or replace view semiUp2643701133848576112 as select person_id as v26, movie_id as v3 from cast_info AS ci where (person_id) in (select id from name AS n);
create or replace view semiUp8220622300741555792 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiUp5217234045789178617 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select v3 from semiUp8220622300741555792);
create or replace view semiUp5837674843194339755 as select v3, v20 from semiUp5217234045789178617 where (v20) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp1545235277690904421 as select v26, v3 from semiUp2643701133848576112 where (v3) in (select v3 from semiUp5837674843194339755);
create or replace view semiUp9085832829062443535 as select v26, v3 from semiUp1545235277690904421 where (v3) in (select id from title AS t);
create or replace view semiDown5283749218241523562 as select id as v3 from title AS t where (id) in (select v3 from semiUp9085832829062443535);
create or replace view semiDown2373529842801378295 as select v3, v20 from semiUp5837674843194339755 where (v3) in (select v3 from semiUp9085832829062443535);
create or replace view semiDown3264423189390627929 as select id as v26, name as v27 from name AS n where (id) in (select v26 from semiUp9085832829062443535);
create or replace view semiDown4342700432391825826 as select id as v20 from company_name AS cn where (id) in (select v20 from semiDown2373529842801378295) and country_code= '[us]';
create or replace view semiDown3349500108682385275 as select v3, v25 from semiUp8220622300741555792 where (v3) in (select v3 from semiDown2373529842801378295);
create or replace view semiDown1033983167267103502 as select id as v25 from keyword AS k where (id) in (select v25 from semiDown3349500108682385275) and keyword= 'character-name-in-title';
create or replace view aggView4066033646609654041 as select v25 from semiDown1033983167267103502;
create or replace view aggJoin1135860918573617085 as select v3 from semiDown3349500108682385275 join aggView4066033646609654041 using(v25);
create or replace view aggView2854258245695583569 as select v3 from aggJoin1135860918573617085 group by v3;
create or replace view aggJoin4302908132875477829 as select v3, v20 from semiDown2373529842801378295 join aggView2854258245695583569 using(v3);
create or replace view aggView775926840255074458 as select v20 from semiDown4342700432391825826;
create or replace view aggJoin3525276710968905465 as select v3 from aggJoin4302908132875477829 join aggView775926840255074458 using(v20);
create or replace view aggView3341815475515218957 as select v3 from aggJoin3525276710968905465 group by v3;
create or replace view aggJoin6339749772219125546 as select v26, v3 from semiUp9085832829062443535 join aggView3341815475515218957 using(v3);
create or replace view aggView7479896034900946508 as select v26, v27 as v47 from semiDown3264423189390627929;
create or replace view aggJoin6599311417983661012 as select v3, v47 from aggJoin6339749772219125546 join aggView7479896034900946508 using(v26);
create or replace view aggView4625476364043909310 as select v3 from semiDown5283749218241523562;
create or replace view aggJoin1607481103493676200 as select v47 from aggJoin6599311417983661012 join aggView4625476364043909310 using(v3);
select MIN(v47) as v47 from aggJoin1607481103493676200;

