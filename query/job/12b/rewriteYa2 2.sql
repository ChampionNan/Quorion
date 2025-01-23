create or replace view semiUp5537802293003403554 as select movie_id as v29, company_id as v1, company_type_id as v8 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp2570382395684109308 as select v29, v1, v8 from semiUp5537802293003403554 where (v8) in (select id from company_type AS ct where kind IN ('production companies','distributors'));
create or replace view semiUp7055239311275594702 as select id as v29, title as v30 from title AS t where (id) in (select v29 from semiUp2570382395684109308) and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%'));
create or replace view semiUp3502960524316150099 as select movie_id as v29, info_type_id as v21, info as v22 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'budget');
create or replace view miAux97 as select v29, v22 from semiUp3502960524316150099;
create or replace view semiUp8354242652255239161 as select movie_id as v29, info_type_id as v26 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'bottom 10 rank');
create or replace view semiUp5301910145701872496 as select v29, v30 from semiUp7055239311275594702 where (v29) in (select v29 from semiUp8354242652255239161);
create or replace view tAux1 as select v29, v30 from semiUp5301910145701872496;
create or replace view semiUp2601243757656111509 as select v29, v22 from miAux97 where (v29) in (select v29 from tAux1);
create or replace view semiDown5223245011752931424 as select v29, v30 from tAux1 where (v29) in (select v29 from semiUp2601243757656111509);
create or replace view semiDown9077107628887705842 as select v29, v21, v22 from semiUp3502960524316150099 where (v29, v22) in (select v29, v22 from semiUp2601243757656111509);
create or replace view semiDown7031104882105453298 as select v29, v30 from semiUp5301910145701872496 where (v29, v30) in (select v29, v30 from semiDown5223245011752931424);
create or replace view semiDown500898535380874031 as select id as v21 from info_type AS it1 where (id) in (select v21 from semiDown9077107628887705842) and info= 'budget';
create or replace view semiDown8939779406278243937 as select v29, v26 from semiUp8354242652255239161 where (v29) in (select v29 from semiDown7031104882105453298);
create or replace view semiDown8315944416013234438 as select v29, v1, v8 from semiUp2570382395684109308 where (v29) in (select v29 from semiDown7031104882105453298);
create or replace view semiDown1075323354660699387 as select id as v26 from info_type AS it2 where (id) in (select v26 from semiDown8939779406278243937) and info= 'bottom 10 rank';
create or replace view semiDown6021686475641495607 as select id as v8 from company_type AS ct where (id) in (select v8 from semiDown8315944416013234438) and kind IN ('production companies','distributors');
create or replace view semiDown9094192776138371238 as select id as v1 from company_name AS cn where (id) in (select v1 from semiDown8315944416013234438) and country_code= '[us]';
create or replace view aggView4314689242815876380 as select v26 from semiDown1075323354660699387;
create or replace view aggJoin1903942894654188065 as select v29 from semiDown8939779406278243937 join aggView4314689242815876380 using(v26);
create or replace view aggView8440888618482044369 as select v8 from semiDown6021686475641495607;
create or replace view aggJoin126404840049489680 as select v29, v1 from semiDown8315944416013234438 join aggView8440888618482044369 using(v8);
create or replace view aggView7358233926711917448 as select v1 from semiDown9094192776138371238;
create or replace view aggJoin3555720874711177920 as select v29 from aggJoin126404840049489680 join aggView7358233926711917448 using(v1);
create or replace view aggView8940091381083590046 as select v29 from aggJoin1903942894654188065 group by v29;
create or replace view aggJoin4692963219161862149 as select v29, v30 from semiDown7031104882105453298 join aggView8940091381083590046 using(v29);
create or replace view aggView1971656868793920529 as select v29 from aggJoin3555720874711177920 group by v29;
create or replace view aggJoin4284531044425167939 as select v29, v30 from aggJoin4692963219161862149 join aggView1971656868793920529 using(v29);
create or replace view aggView5199882751506427872 as select v29, v30, MIN(v30) as v42 from aggJoin4284531044425167939 group by v29,v30;
create or replace view aggView5951292330444156946 as select v21 from semiDown500898535380874031;
create or replace view aggJoin83906431438418940 as select v29, v22 from semiDown9077107628887705842 join aggView5951292330444156946 using(v21);
create or replace view aggView3332439763917788581 as select v29, v22, MIN(v22) as v41 from aggJoin83906431438418940 group by v29,v22;
create or replace view aggView3158815155086700815 as select v29, MIN(v42) as v42 from aggView5199882751506427872 group by v29,v42;
create or replace view aggJoin8557991929759644714 as select v41 as v41, v42 from aggView3332439763917788581 join aggView3158815155086700815 using(v29);
select MIN(v41) as v41, MIN(v42) as v42 from aggJoin8557991929759644714;

