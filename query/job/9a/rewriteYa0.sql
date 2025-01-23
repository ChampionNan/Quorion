create or replace view semiUp3239513638400458236 as select movie_id as v18, company_id as v32 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]') and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%'));
create or replace view semiUp3195521446729118271 as select person_id as v35, movie_id as v18, person_role_id as v9, role_id as v22 from cast_info AS ci where (role_id) in (select id from role_type AS rt where role= 'actress') and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)');
create or replace view semiUp2713099205337163959 as select id as v18, title as v47 from title AS t where (id) in (select v18 from semiUp3239513638400458236) and production_year>=2005 and production_year<=2015;
create or replace view semiUp5044453619919374806 as select v35, v18, v9, v22 from semiUp3195521446729118271 where (v18) in (select v18 from semiUp2713099205337163959);
create or replace view semiUp8034767166548131844 as select id as v35 from name AS n where (id) in (select v35 from semiUp5044453619919374806) and gender= 'f' and name LIKE '%Ang%';
create or replace view semiUp2266924090626008820 as select person_id as v35, name as v3 from aka_name AS an where (person_id) in (select v35 from semiUp8034767166548131844);
create or replace view semiUp5590781432590100207 as select id as v9, name as v10 from char_name AS chn;
create or replace view semiDown5563512855819702016 as select v35, v3 from semiUp2266924090626008820;
create or replace view semiDown1262302096779050809 as select v35 from semiUp8034767166548131844 where (v35) in (select v35 from semiDown5563512855819702016);
create or replace view semiDown2045303640859208919 as select v35, v18, v9, v22 from semiUp5044453619919374806 where (v35) in (select v35 from semiDown1262302096779050809);
create or replace view semiDown7023267546711992653 as select id as v22 from role_type AS rt where (id) in (select v22 from semiDown2045303640859208919) and role= 'actress';
create or replace view semiDown366310515448625795 as select v18, v47 from semiUp2713099205337163959 where (v18) in (select v18 from semiDown2045303640859208919);
create or replace view semiDown5939281534206559612 as select v18, v32 from semiUp3239513638400458236 where (v18) in (select v18 from semiDown366310515448625795);
create or replace view semiDown2687009566160378159 as select id as v32 from company_name AS cn where (id) in (select v32 from semiDown5939281534206559612) and country_code= '[us]';
create or replace view aggView7528063964263721592 as select v32 from semiDown2687009566160378159;
create or replace view aggJoin5124554629692006087 as select v18 from semiDown5939281534206559612 join aggView7528063964263721592 using(v32);
create or replace view aggView8796822167892489953 as select v18 from aggJoin5124554629692006087 group by v18;
create or replace view aggJoin87922716913822988 as select v18, v47 from semiDown366310515448625795 join aggView8796822167892489953 using(v18);
create or replace view aggView1695799941980303917 as select v18, MIN(v47) as v60 from aggJoin87922716913822988 group by v18;
create or replace view aggJoin6961928188967242057 as select v35, v9, v22, v60 from semiDown2045303640859208919 join aggView1695799941980303917 using(v18);
create or replace view aggView2259350195620295008 as select v22 from semiDown7023267546711992653;
create or replace view aggJoin3231121952595320287 as select v35, v9, v60 from aggJoin6961928188967242057 join aggView2259350195620295008 using(v22);
create or replace view aggView1904791576215312665 as select v35, v9, MIN(v60) as v60 from aggJoin3231121952595320287 group by v35,v9,v60;
create or replace view aggJoin469632477401574429 as select v35, v9, v60 from semiDown1262302096779050809 join aggView1904791576215312665 using(v35);
create or replace view aggView5279587506258318444 as select v35, v9, MIN(v60) as v60 from aggJoin469632477401574429 group by v35,v9,v60;
create or replace view aggJoin1396189030696082106 as select v3, v9, v60 from semiDown5563512855819702016 join aggView5279587506258318444 using(v35);
create or replace view aggView7262182254307617095 as select v9, MIN(v60) as v60, MIN(v3) as v58 from aggJoin1396189030696082106 group by v9,v60;
create or replace view aggJoin3965782936811610342 as select v9, v10, v60, v58 from semiUp5590781432590100207 join aggView7262182254307617095 using(v9);
select MIN(v58) as v58, MIN(v10) as v59, MIN(v60) as v60 from aggJoin3965782936811610342;

