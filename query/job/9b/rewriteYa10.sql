create or replace view semiUp5977108410291067324 as select person_id as v35, name as v3 from aka_name AS an where (person_id) in (select id from name AS n where gender= 'f' and name LIKE '%Angel%');
create or replace view semiUp4749950611259756475 as select person_id as v35, movie_id as v18, person_role_id as v9, role_id as v22 from cast_info AS ci where (person_id) in (select v35 from semiUp5977108410291067324) and note= '(voice)';
create or replace view semiUp263152822782985918 as select movie_id as v18, company_id as v32 from movie_companies AS mc where (movie_id) in (select id from title AS t where production_year>=2007 and production_year<=2010) and ((note LIKE '%(USA)%') OR (note LIKE '%(worldwide)%')) and note LIKE '%(200%)%';
create or replace view semiUp2097792254054127101 as select v35, v18, v9, v22 from semiUp4749950611259756475 where (v22) in (select id from role_type AS rt where role= 'actress');
create or replace view semiUp6786380668397284216 as select v18, v32 from semiUp263152822782985918 where (v32) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp1084657185427000252 as select v35, v18, v9, v22 from semiUp2097792254054127101 where (v18) in (select v18 from semiUp6786380668397284216);
create or replace view semiUp7140367881502804467 as select id as v9, name as v10 from char_name AS chn where (id) in (select v9 from semiUp1084657185427000252);
create or replace view semiDown8130220816189528451 as select v35, v18, v9, v22 from semiUp1084657185427000252 where (v9) in (select v9 from semiUp7140367881502804467);
create or replace view semiDown7217322190132137148 as select id as v22 from role_type AS rt where (id) in (select v22 from semiDown8130220816189528451) and role= 'actress';
create or replace view semiDown9145140218385866917 as select v18, v32 from semiUp6786380668397284216 where (v18) in (select v18 from semiDown8130220816189528451);
create or replace view semiDown6003844450364538630 as select v35, v3 from semiUp5977108410291067324 where (v35) in (select v35 from semiDown8130220816189528451);
create or replace view semiDown6642425886076957596 as select id as v32 from company_name AS cn where (id) in (select v32 from semiDown9145140218385866917) and country_code= '[us]';
create or replace view semiDown8815197656402183199 as select id as v18, title as v47 from title AS t where (id) in (select v18 from semiDown9145140218385866917) and production_year>=2007 and production_year<=2010;
create or replace view semiDown8798752400014053055 as select id as v35, name as v36 from name AS n where (id) in (select v35 from semiDown6003844450364538630) and gender= 'f' and name LIKE '%Angel%';
create or replace view aggView5143473105150729630 as select v32 from semiDown6642425886076957596;
create or replace view aggJoin4888607443587753923 as select v18 from semiDown9145140218385866917 join aggView5143473105150729630 using(v32);
create or replace view aggView5384835918139819565 as select v18, v47 as v61 from semiDown8815197656402183199;
create or replace view aggJoin7279940302648833550 as select v18, v61 from aggJoin4888607443587753923 join aggView5384835918139819565 using(v18);
create or replace view aggView2577985017740142234 as select v35, v36 as v60 from semiDown8798752400014053055;
create or replace view aggJoin5270490808619280903 as select v35, v3, v60 from semiDown6003844450364538630 join aggView2577985017740142234 using(v35);
create or replace view aggView6205598308598524656 as select v35, MIN(v60) as v60, MIN(v3) as v58 from aggJoin5270490808619280903 group by v35,v60;
create or replace view aggJoin7925329123569616604 as select v18, v9, v22, v60, v58 from semiDown8130220816189528451 join aggView6205598308598524656 using(v35);
create or replace view aggView6712872619960893738 as select v18, MIN(v61) as v61 from aggJoin7279940302648833550 group by v18,v61;
create or replace view aggJoin5604048369711446910 as select v9, v22, v60 as v60, v58 as v58, v61 from aggJoin7925329123569616604 join aggView6712872619960893738 using(v18);
create or replace view aggView835100725184517333 as select v22 from semiDown7217322190132137148;
create or replace view aggJoin6274729459339882292 as select v9, v60, v58, v61 from aggJoin5604048369711446910 join aggView835100725184517333 using(v22);
create or replace view aggView4146903629962346269 as select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin6274729459339882292 group by v9,v58,v61,v60;
create or replace view aggJoin892631056598718212 as select v10, v60, v58, v61 from semiUp7140367881502804467 join aggView4146903629962346269 using(v9);
select MIN(v58) as v58, MIN(v10) as v59, MIN(v60) as v60, MIN(v61) as v61 from aggJoin892631056598718212;

