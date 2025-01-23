create or replace view semiUp8435563968246258237 as select person_id as v24, info_type_id as v16, info as v36 from person_info AS pi where (info_type_id) in (select id from info_type AS it where info= 'mini biography');
create or replace view semiUp3590903839480722242 as select linked_movie_id as v38, link_type_id as v18 from movie_link AS ml where (link_type_id) in (select id from link_type AS lt where link IN ('references','referenced in','features','featured in'));
create or replace view semiUp8836062222945343105 as select person_id as v24, movie_id as v38 from cast_info AS ci where (person_id) in (select person_id from aka_name AS an where ((name LIKE '%a%') OR (name LIKE 'A%')));
create or replace view semiUp2833959102957152169 as select v24, v38 from semiUp8836062222945343105 where (v38) in (select id from title AS t where production_year<=2010 and production_year>=1980);
create or replace view semiUp2321454258426836108 as select v24, v38 from semiUp2833959102957152169 where (v38) in (select v38 from semiUp3590903839480722242);
create or replace view semiUp5077661988523935619 as select v24, v16, v36 from semiUp8435563968246258237 where (v24) in (select id from name AS n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view semiUp9033476947517538757 as select v24, v38 from semiUp2321454258426836108 where (v24) in (select v24 from semiUp5077661988523935619);
create or replace view semiDown423697498765906177 as select v38, v18 from semiUp3590903839480722242 where (v38) in (select v38 from semiUp9033476947517538757);
create or replace view semiDown4520262594466263890 as select person_id as v24 from aka_name AS an where (person_id) in (select v24 from semiUp9033476947517538757) and ((name LIKE '%a%') OR (name LIKE 'A%'));
create or replace view semiDown7787853062290321467 as select id as v38 from title AS t where (id) in (select v38 from semiUp9033476947517538757) and production_year<=2010 and production_year>=1980;
create or replace view semiDown3750276918354863624 as select v24, v16, v36 from semiUp5077661988523935619 where (v24) in (select v24 from semiUp9033476947517538757);
create or replace view semiDown4900281279892667913 as select id as v18 from link_type AS lt where (id) in (select v18 from semiDown423697498765906177) and link IN ('references','referenced in','features','featured in');
create or replace view semiDown1052916246204025434 as select id as v16 from info_type AS it where (id) in (select v16 from semiDown3750276918354863624) and info= 'mini biography';
create or replace view semiDown1847935599085215914 as select id as v24, name as v25 from name AS n where (id) in (select v24 from semiDown3750276918354863624) and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F';
create or replace view aggView6300623558066955335 as select v16 from semiDown1052916246204025434;
create or replace view aggJoin5271525379145576491 as select v24, v36 from semiDown3750276918354863624 join aggView6300623558066955335 using(v16);
create or replace view aggView6971014338561081196 as select v24, v25 as v50 from semiDown1847935599085215914;
create or replace view aggJoin6104058622863765278 as select v24, v36, v50 from aggJoin5271525379145576491 join aggView6971014338561081196 using(v24);
create or replace view aggView7318692572648001431 as select v18 from semiDown4900281279892667913;
create or replace view aggJoin2026327244201197457 as select v38 from semiDown423697498765906177 join aggView7318692572648001431 using(v18);
create or replace view aggView155921141032215659 as select v38 from aggJoin2026327244201197457 group by v38;
create or replace view aggJoin7111679140173825357 as select v24, v38 from semiUp9033476947517538757 join aggView155921141032215659 using(v38);
create or replace view aggView5899526789297691520 as select v24 from semiDown4520262594466263890 group by v24;
create or replace view aggJoin2399413041913381154 as select v24, v38 from aggJoin7111679140173825357 join aggView5899526789297691520 using(v24);
create or replace view aggView1409052137624216769 as select v24, MIN(v50) as v50, MIN(v36) as v51 from aggJoin6104058622863765278 group by v24,v50;
create or replace view aggJoin3281051226775091961 as select v38, v50, v51 from aggJoin2399413041913381154 join aggView1409052137624216769 using(v24);
create or replace view aggView7012230353107182183 as select v38 from semiDown7787853062290321467;
create or replace view aggJoin4998626399300771840 as select v50, v51 from aggJoin3281051226775091961 join aggView7012230353107182183 using(v38);
select MIN(v50) as v50, MIN(v51) as v51 from aggJoin4998626399300771840;

