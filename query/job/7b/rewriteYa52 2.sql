create or replace view semiUp5184093014571189658 as select person_id as v24, info_type_id as v16 from person_info AS pi where (info_type_id) in (select id from info_type AS it where info= 'mini biography') and note= 'Volker Boehm';
create or replace view semiUp5722577453932303614 as select linked_movie_id as v38, link_type_id as v18 from movie_link AS ml where (link_type_id) in (select id from link_type AS lt where link= 'features');
create or replace view semiUp7913209990037120438 as select person_id as v24, movie_id as v38 from cast_info AS ci where (movie_id) in (select id from title AS t where production_year<=1984 and production_year>=1980);
create or replace view semiUp7594502802979966211 as select v24, v38 from semiUp7913209990037120438 where (v38) in (select v38 from semiUp5722577453932303614);
create or replace view semiUp9037226193424588873 as select id as v24, name as v25 from name AS n where (id) in (select v24 from semiUp5184093014571189658) and gender= 'm' and name_pcode_cf LIKE 'D%';
create or replace view semiUp5696271303212191098 as select person_id as v24 from aka_name AS an where (person_id) in (select v24 from semiUp9037226193424588873) and name LIKE '%a%';
create or replace view semiUp8662261247306288260 as select v24, v38 from semiUp7594502802979966211 where (v24) in (select v24 from semiUp5696271303212191098);
create or replace view semiDown2149858375782927172 as select v38, v18 from semiUp5722577453932303614 where (v38) in (select v38 from semiUp8662261247306288260);
create or replace view semiDown1678143506036442320 as select id as v38, title as v39 from title AS t where (id) in (select v38 from semiUp8662261247306288260) and production_year<=1984 and production_year>=1980;
create or replace view semiDown8144984101727990433 as select v24 from semiUp5696271303212191098 where (v24) in (select v24 from semiUp8662261247306288260);
create or replace view semiDown7024178380425299071 as select id as v18 from link_type AS lt where (id) in (select v18 from semiDown2149858375782927172) and link= 'features';
create or replace view semiDown7162685737286262834 as select v24, v25 from semiUp9037226193424588873 where (v24) in (select v24 from semiDown8144984101727990433);
create or replace view semiDown4966422593073951000 as select v24, v16 from semiUp5184093014571189658 where (v24) in (select v24 from semiDown7162685737286262834);
create or replace view semiDown2110726392927124379 as select id as v16 from info_type AS it where (id) in (select v16 from semiDown4966422593073951000) and info= 'mini biography';
create or replace view aggView356532177450541366 as select v16 from semiDown2110726392927124379;
create or replace view aggJoin6295617667791070516 as select v24 from semiDown4966422593073951000 join aggView356532177450541366 using(v16);
create or replace view aggView1840527175989312289 as select v24 from aggJoin6295617667791070516 group by v24;
create or replace view aggJoin2565002501442438235 as select v24, v25 from semiDown7162685737286262834 join aggView1840527175989312289 using(v24);
create or replace view aggView4387879283521210257 as select v18 from semiDown7024178380425299071;
create or replace view aggJoin1591200147828915155 as select v38 from semiDown2149858375782927172 join aggView4387879283521210257 using(v18);
create or replace view aggView9071441261743065296 as select v24, MIN(v25) as v50 from aggJoin2565002501442438235 group by v24;
create or replace view aggJoin7057317207984614756 as select v24, v50 from semiDown8144984101727990433 join aggView9071441261743065296 using(v24);
create or replace view aggView2901678833267796941 as select v38 from aggJoin1591200147828915155 group by v38;
create or replace view aggJoin4629906926515216653 as select v24, v38 from semiUp8662261247306288260 join aggView2901678833267796941 using(v38);
create or replace view aggView3202725504157492251 as select v24, MIN(v50) as v50 from aggJoin7057317207984614756 group by v24,v50;
create or replace view aggJoin2737964451090301837 as select v38, v50 from aggJoin4629906926515216653 join aggView3202725504157492251 using(v24);
create or replace view aggView6608889928306466194 as select v38, v39 as v51 from semiDown1678143506036442320;
create or replace view aggJoin574072356673940192 as select v50, v51 from aggJoin2737964451090301837 join aggView6608889928306466194 using(v38);
select MIN(v50) as v50, MIN(v51) as v51 from aggJoin574072356673940192;
