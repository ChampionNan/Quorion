create or replace view semiUp5434322191275999626 as select movie_id as v40, company_id as v13, company_type_id as v20 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where name= 'YouTube' and country_code= '[us]') and note LIKE '%(200%)%' and note LIKE '%(worldwide)%';
create or replace view semiUp6017871988391191461 as select movie_id as v40, keyword_id as v24 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k);
create or replace view semiUp8195768871277545847 as select movie_id as v40, info_type_id as v22, info as v35 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'release dates') and note LIKE '%internet%' and info LIKE 'USA:% 200%';
create or replace view semiUp5575970263404487250 as select v40, v13, v20 from semiUp5434322191275999626 where (v20) in (select id from company_type AS ct);
create or replace view semiUp6580342271401350406 as select v40, v22, v35 from semiUp8195768871277545847 where (v40) in (select id from title AS t where production_year<=2010 and production_year>=2005);
create or replace view semiUp8241594969029432078 as select v40, v24 from semiUp6017871988391191461 where (v40) in (select v40 from semiUp5575970263404487250);
create or replace view semiUp1197994465409477865 as select movie_id as v40 from aka_title AS aka_t where (movie_id) in (select v40 from semiUp6580342271401350406);
create or replace view semiUp7743348707692028386 as select v40, v24 from semiUp8241594969029432078 where (v40) in (select v40 from semiUp1197994465409477865);
create or replace view semiDown6767926393638439321 as select v40, v13, v20 from semiUp5575970263404487250 where (v40) in (select v40 from semiUp7743348707692028386);
create or replace view semiDown5891743431747306607 as select id as v24 from keyword AS k where (id) in (select v24 from semiUp7743348707692028386);
create or replace view semiDown7217534617764471364 as select v40 from semiUp1197994465409477865 where (v40) in (select v40 from semiUp7743348707692028386);
create or replace view semiDown112891318743862688 as select id as v13 from company_name AS cn where (id) in (select v13 from semiDown6767926393638439321) and name= 'YouTube' and country_code= '[us]';
create or replace view semiDown4574168548774627824 as select id as v20 from company_type AS ct where (id) in (select v20 from semiDown6767926393638439321);
create or replace view semiDown6388949736999138541 as select v40, v22, v35 from semiUp6580342271401350406 where (v40) in (select v40 from semiDown7217534617764471364);
create or replace view semiDown9027206678048694384 as select id as v22 from info_type AS it1 where (id) in (select v22 from semiDown6388949736999138541) and info= 'release dates';
create or replace view semiDown1156085994298281515 as select id as v40, title as v41 from title AS t where (id) in (select v40 from semiDown6388949736999138541) and production_year<=2010 and production_year>=2005;
create or replace view aggView5901700620570798544 as select v40, v41 as v53 from semiDown1156085994298281515;
create or replace view aggJoin220466105418213839 as select v40, v22, v35, v53 from semiDown6388949736999138541 join aggView5901700620570798544 using(v40);
create or replace view aggView2444834949511856922 as select v22 from semiDown9027206678048694384;
create or replace view aggJoin1355305233721109563 as select v40, v35, v53 from aggJoin220466105418213839 join aggView2444834949511856922 using(v22);
create or replace view aggView3955140137267248575 as select v20 from semiDown4574168548774627824;
create or replace view aggJoin3408468677640529204 as select v40, v13 from semiDown6767926393638439321 join aggView3955140137267248575 using(v20);
create or replace view aggView4510611527700209035 as select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin1355305233721109563 group by v40,v53;
create or replace view aggJoin8446834889391636380 as select v40, v53, v52 from semiDown7217534617764471364 join aggView4510611527700209035 using(v40);
create or replace view aggView2403955243481814549 as select v13 from semiDown112891318743862688;
create or replace view aggJoin7999585591330304715 as select v40 from aggJoin3408468677640529204 join aggView2403955243481814549 using(v13);
create or replace view aggView6315004148764205757 as select v40 from aggJoin7999585591330304715 group by v40;
create or replace view aggJoin6377023265198700127 as select v40, v24 from semiUp7743348707692028386 join aggView6315004148764205757 using(v40);
create or replace view aggView1920599186207976655 as select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin8446834889391636380 group by v40,v52,v53;
create or replace view aggJoin7430929072691115134 as select v24, v53, v52 from aggJoin6377023265198700127 join aggView1920599186207976655 using(v40);
create or replace view aggView4039586242227681758 as select v24 from semiDown5891743431747306607;
create or replace view aggJoin4142906984837261976 as select v53, v52 from aggJoin7430929072691115134 join aggView4039586242227681758 using(v24);
select MIN(v52) as v52, MIN(v53) as v53 from aggJoin4142906984837261976;

