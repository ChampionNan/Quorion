create or replace view semiUp6058685107387563544 as select movie_id as v40, subject_id as v5, status_id as v7 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct2 where kind LIKE '%complete%');
create or replace view semiUp888717045259268618 as select id as v40, title as v41, kind_id as v26 from title AS t where (kind_id) in (select id from kind_type AS kt where kind= 'movie') and production_year>1950;
create or replace view semiUp3310414451951159154 as select v40, v5, v7 from semiUp6058685107387563544 where (v5) in (select id from comp_cast_type AS cct1 where kind= 'cast');
create or replace view semiUp7613193431439667861 as select person_id as v31, movie_id as v40, person_role_id as v9 from cast_info AS ci where (movie_id) in (select v40 from semiUp3310414451951159154);
create or replace view semiUp9010900304735964747 as select movie_id as v40, keyword_id as v23 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'));
create or replace view semiUp1431399517579079891 as select v31, v40, v9 from semiUp7613193431439667861 where (v40) in (select v40 from semiUp9010900304735964747);
create or replace view semiUp5917193359792987241 as select v31, v40, v9 from semiUp1431399517579079891 where (v31) in (select id from name AS n);
create or replace view semiUp3851607580536485195 as select v31, v40, v9 from semiUp5917193359792987241 where (v9) in (select id from char_name AS chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%');
create or replace view semiUp6848402446168687657 as select v40, v41, v26 from semiUp888717045259268618 where (v40) in (select v40 from semiUp3851607580536485195);
create or replace view tAux6 as select v41 from semiUp6848402446168687657;
create or replace view semiDown3632787284450820161 as select v40, v41, v26 from semiUp6848402446168687657 where (v41) in (select v41 from tAux6);
create or replace view semiDown7973862678601007572 as select id as v26 from kind_type AS kt where (id) in (select v26 from semiDown3632787284450820161) and kind= 'movie';
create or replace view semiDown8689702745613126613 as select v31, v40, v9 from semiUp3851607580536485195 where (v40) in (select v40 from semiDown3632787284450820161);
create or replace view semiDown3657960836102238295 as select id as v9 from char_name AS chn where (id) in (select v9 from semiDown8689702745613126613) and ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%';
create or replace view semiDown981035353378003787 as select v40, v5, v7 from semiUp3310414451951159154 where (v40) in (select v40 from semiDown8689702745613126613);
create or replace view semiDown407016430134862511 as select id as v31 from name AS n where (id) in (select v31 from semiDown8689702745613126613);
create or replace view semiDown4925830755028770259 as select v40, v23 from semiUp9010900304735964747 where (v40) in (select v40 from semiDown8689702745613126613);
create or replace view semiDown4786647235932071186 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown981035353378003787) and kind= 'cast';
create or replace view semiDown2771797923755566092 as select id as v7 from comp_cast_type AS cct2 where (id) in (select v7 from semiDown981035353378003787) and kind LIKE '%complete%';
create or replace view semiDown2307192358553284354 as select id as v23 from keyword AS k where (id) in (select v23 from semiDown4925830755028770259) and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggView3494685338185832641 as select v23 from semiDown2307192358553284354;
create or replace view aggJoin4125130620303786902 as select v40 from semiDown4925830755028770259 join aggView3494685338185832641 using(v23);
create or replace view aggView7597557891569173480 as select v5 from semiDown4786647235932071186;
create or replace view aggJoin2988813328131939504 as select v40, v7 from semiDown981035353378003787 join aggView7597557891569173480 using(v5);
create or replace view aggView6379888075299673038 as select v7 from semiDown2771797923755566092;
create or replace view aggJoin2203598356971654592 as select v40 from aggJoin2988813328131939504 join aggView6379888075299673038 using(v7);
create or replace view aggView3322402570828766086 as select v40 from aggJoin4125130620303786902 group by v40;
create or replace view aggJoin5297557304004969869 as select v31, v40, v9 from semiDown8689702745613126613 join aggView3322402570828766086 using(v40);
create or replace view aggView1138854131517751717 as select v9 from semiDown3657960836102238295;
create or replace view aggJoin2244050495991903374 as select v31, v40 from aggJoin5297557304004969869 join aggView1138854131517751717 using(v9);
create or replace view aggView5425328939053301230 as select v40 from aggJoin2203598356971654592 group by v40;
create or replace view aggJoin2247259992557991224 as select v31, v40 from aggJoin2244050495991903374 join aggView5425328939053301230 using(v40);
create or replace view aggView5730098189107021661 as select v31 from semiDown407016430134862511;
create or replace view aggJoin5395087216805874824 as select v40 from aggJoin2247259992557991224 join aggView5730098189107021661 using(v31);
create or replace view aggView1378865570054184323 as select v26 from semiDown7973862678601007572;
create or replace view aggJoin8538607839058990678 as select v40, v41 from semiDown3632787284450820161 join aggView1378865570054184323 using(v26);
create or replace view aggView7860667327843334893 as select v40 from aggJoin5395087216805874824 group by v40;
create or replace view aggJoin5421991543393171542 as select v41 from aggJoin8538607839058990678 join aggView7860667327843334893 using(v40);
create or replace view aggView6259985777280852187 as select v41, MIN(v41) as v52 from aggJoin5421991543393171542 group by v41;
select MIN(v52) as v52 from aggView6259985777280852187;

