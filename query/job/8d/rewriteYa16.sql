create or replace view semiUp7289557532315239204 as select movie_id as v11, company_id as v25 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp5845527797831719787 as select person_id as v2, movie_id as v11, role_id as v15 from cast_info AS ci where (person_id) in (select id from name AS n1);
create or replace view semiUp4331465427353284451 as select v2, v11, v15 from semiUp5845527797831719787 where (v11) in (select v11 from semiUp7289557532315239204);
create or replace view semiUp265263186220606793 as select v2, v11, v15 from semiUp4331465427353284451 where (v15) in (select id from role_type AS rt where role= 'costume designer');
create or replace view semiUp2134979331600660166 as select v2, v11, v15 from semiUp265263186220606793 where (v11) in (select id from title AS t);
create or replace view semiUp4404688740833945019 as select v2, v11, v15 from semiUp2134979331600660166 where (v2) in (select person_id from aka_name AS an1);
create or replace view semiDown4493378147490951982 as select id as v15 from role_type AS rt where (id) in (select v15 from semiUp4404688740833945019) and role= 'costume designer';
create or replace view semiDown8266661914395019099 as select person_id as v2, name as v3 from aka_name AS an1 where (person_id) in (select v2 from semiUp4404688740833945019);
create or replace view semiDown2343014893620519538 as select id as v11, title as v40 from title AS t where (id) in (select v11 from semiUp4404688740833945019);
create or replace view semiDown3329679775392622905 as select v11, v25 from semiUp7289557532315239204 where (v11) in (select v11 from semiUp4404688740833945019);
create or replace view semiDown2423427602317710336 as select id as v2 from name AS n1 where (id) in (select v2 from semiUp4404688740833945019);
create or replace view semiDown7636193431695174583 as select id as v25 from company_name AS cn where (id) in (select v25 from semiDown3329679775392622905) and country_code= '[us]';
create or replace view aggView913451341546040252 as select v25 from semiDown7636193431695174583;
create or replace view aggJoin1319574296469253368 as select v11 from semiDown3329679775392622905 join aggView913451341546040252 using(v25);
create or replace view aggView2118978353815980211 as select v11, v40 as v52 from semiDown2343014893620519538;
create or replace view aggJoin6153048488817809122 as select v2, v11, v15, v52 from semiUp4404688740833945019 join aggView2118978353815980211 using(v11);
create or replace view aggView5360761062192488919 as select v11 from aggJoin1319574296469253368 group by v11;
create or replace view aggJoin2617825951573260010 as select v2, v15, v52 as v52 from aggJoin6153048488817809122 join aggView5360761062192488919 using(v11);
create or replace view aggView3906551824723029356 as select v2 from semiDown2423427602317710336;
create or replace view aggJoin2504834541243090784 as select v2, v15, v52 from aggJoin2617825951573260010 join aggView3906551824723029356 using(v2);
create or replace view aggView7091444417190350833 as select v2, MIN(v3) as v51 from semiDown8266661914395019099 group by v2;
create or replace view aggJoin7958343417922466216 as select v15, v52 as v52, v51 from aggJoin2504834541243090784 join aggView7091444417190350833 using(v2);
create or replace view aggView8710466715811958317 as select v15 from semiDown4493378147490951982;
create or replace view aggJoin5747381320804492078 as select v52, v51 from aggJoin7958343417922466216 join aggView8710466715811958317 using(v15);
select MIN(v51) as v51, MIN(v52) as v52 from aggJoin5747381320804492078;

