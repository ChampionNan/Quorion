create or replace view semiUp5409585468230942325 as select movie_id as v31, person_role_id as v1, role_id as v29 from cast_info AS ci where (person_role_id) in (select id from char_name AS chn) and note LIKE '%(voice)%' and note LIKE '%(uncredited)%';
create or replace view semiUp1071405523615497867 as select movie_id as v31, company_id as v15, company_type_id as v22 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[ru]');
create or replace view semiUp2218581123414762449 as select v31, v15, v22 from semiUp1071405523615497867 where (v22) in (select id from company_type AS ct);
create or replace view semiUp2677935484331996959 as select v31, v1, v29 from semiUp5409585468230942325 where (v29) in (select id from role_type AS rt where role= 'actor');
create or replace view semiUp7696868504585541331 as select v31, v15, v22 from semiUp2218581123414762449 where (v31) in (select v31 from semiUp2677935484331996959);
create or replace view semiUp882549904510074368 as select v31, v15, v22 from semiUp7696868504585541331 where (v31) in (select id from title AS t where production_year>2005);
create or replace view semiDown2116720967594105472 as select id as v22 from company_type AS ct where (id) in (select v22 from semiUp882549904510074368);
create or replace view semiDown2225283498260909119 as select id as v15 from company_name AS cn where (id) in (select v15 from semiUp882549904510074368) and country_code= '[ru]';
create or replace view semiDown5479105835438667519 as select v31, v1, v29 from semiUp2677935484331996959 where (v31) in (select v31 from semiUp882549904510074368);
create or replace view semiDown468884687944648906 as select id as v31, title as v32 from title AS t where (id) in (select v31 from semiUp882549904510074368) and production_year>2005;
create or replace view semiDown3874166736885642145 as select id as v29 from role_type AS rt where (id) in (select v29 from semiDown5479105835438667519) and role= 'actor';
create or replace view semiDown7301777608360255497 as select id as v1, name as v2 from char_name AS chn where (id) in (select v1 from semiDown5479105835438667519);
create or replace view aggView6842975954353963124 as select v1, v2 as v43 from semiDown7301777608360255497;
create or replace view aggJoin8409233526584183652 as select v31, v29, v43 from semiDown5479105835438667519 join aggView6842975954353963124 using(v1);
create or replace view aggView904665349919956387 as select v29 from semiDown3874166736885642145;
create or replace view aggJoin8029701517925740591 as select v31, v43 from aggJoin8409233526584183652 join aggView904665349919956387 using(v29);
create or replace view aggView8929427593831698047 as select v31, MIN(v43) as v43 from aggJoin8029701517925740591 group by v31,v43;
create or replace view aggJoin2837141593077779880 as select v31, v15, v22, v43 from semiUp882549904510074368 join aggView8929427593831698047 using(v31);
create or replace view aggView8004634353811662222 as select v31, v32 as v44 from semiDown468884687944648906;
create or replace view aggJoin5673412494482386862 as select v15, v22, v43, v44 from aggJoin2837141593077779880 join aggView8004634353811662222 using(v31);
create or replace view aggView988329981163755604 as select v15 from semiDown2225283498260909119;
create or replace view aggJoin1612324487407086728 as select v22, v43, v44 from aggJoin5673412494482386862 join aggView988329981163755604 using(v15);
create or replace view aggView4519129750077226644 as select v22 from semiDown2116720967594105472;
create or replace view aggJoin3432562380541376495 as select v43, v44 from aggJoin1612324487407086728 join aggView4519129750077226644 using(v22);
select MIN(v43) as v43, MIN(v44) as v44 from aggJoin3432562380541376495;

