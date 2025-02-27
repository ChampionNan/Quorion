create or replace view semiUp5956999943550780330 as select movie_id as v40, subject_id as v5, status_id as v7 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct2 where kind LIKE '%complete%');
create or replace view semiUp8799319342391289600 as select id as v40, title as v41, kind_id as v26 from title AS t where (kind_id) in (select id from kind_type AS kt where kind= 'movie') and production_year>1950;
create or replace view semiUp1414462761660918115 as select person_id as v31, movie_id as v40, person_role_id as v9 from cast_info AS ci where (person_id) in (select id from name AS n);
create or replace view semiUp8932132715382668076 as select movie_id as v40, keyword_id as v23 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'));
create or replace view semiUp5179776814543987438 as select v40, v5, v7 from semiUp5956999943550780330 where (v5) in (select id from comp_cast_type AS cct1 where kind= 'cast');
create or replace view semiUp6919995357270357734 as select v40, v23 from semiUp8932132715382668076 where (v40) in (select v40 from semiUp5179776814543987438);
create or replace view semiUp3709778005119306989 as select v40, v41, v26 from semiUp8799319342391289600 where (v40) in (select v40 from semiUp6919995357270357734);
create or replace view semiUp3095518636344797184 as select v31, v40, v9 from semiUp1414462761660918115 where (v9) in (select id from char_name AS chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%');
create or replace view semiUp3375750810303584727 as select v31, v40, v9 from semiUp3095518636344797184 where (v40) in (select v40 from semiUp3709778005119306989);
create or replace view semiDown5073097582164601328 as select id as v9 from char_name AS chn where (id) in (select v9 from semiUp3375750810303584727) and ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%';
create or replace view semiDown5423085234379587702 as select v40, v41, v26 from semiUp3709778005119306989 where (v40) in (select v40 from semiUp3375750810303584727);
create or replace view semiDown4798218532154584386 as select id as v31 from name AS n where (id) in (select v31 from semiUp3375750810303584727);
create or replace view semiDown1509490851122264924 as select id as v26 from kind_type AS kt where (id) in (select v26 from semiDown5423085234379587702) and kind= 'movie';
create or replace view semiDown3109898017496701555 as select v40, v23 from semiUp6919995357270357734 where (v40) in (select v40 from semiDown5423085234379587702);
create or replace view semiDown8066168556750618833 as select id as v23 from keyword AS k where (id) in (select v23 from semiDown3109898017496701555) and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view semiDown8094665974846053623 as select v40, v5, v7 from semiUp5179776814543987438 where (v40) in (select v40 from semiDown3109898017496701555);
create or replace view semiDown2594937884364528974 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown8094665974846053623) and kind= 'cast';
create or replace view semiDown3470188658005646307 as select id as v7 from comp_cast_type AS cct2 where (id) in (select v7 from semiDown8094665974846053623) and kind LIKE '%complete%';
create or replace view aggView172799408179264852 as select v5 from semiDown2594937884364528974;
create or replace view aggJoin3748393098579237004 as select v40, v7 from semiDown8094665974846053623 join aggView172799408179264852 using(v5);
create or replace view aggView3752658930632057269 as select v7 from semiDown3470188658005646307;
create or replace view aggJoin77309119910309275 as select v40 from aggJoin3748393098579237004 join aggView3752658930632057269 using(v7);
create or replace view aggView4629905873189710768 as select v40 from aggJoin77309119910309275 group by v40;
create or replace view aggJoin46185436447234572 as select v40, v23 from semiDown3109898017496701555 join aggView4629905873189710768 using(v40);
create or replace view aggView7312798266938060097 as select v23 from semiDown8066168556750618833;
create or replace view aggJoin6395588505381682718 as select v40 from aggJoin46185436447234572 join aggView7312798266938060097 using(v23);
create or replace view aggView448619501754109347 as select v40 from aggJoin6395588505381682718 group by v40;
create or replace view aggJoin6461009148562026813 as select v40, v41, v26 from semiDown5423085234379587702 join aggView448619501754109347 using(v40);
create or replace view aggView4184313203027666943 as select v26 from semiDown1509490851122264924;
create or replace view aggJoin2294026501926391409 as select v40, v41 from aggJoin6461009148562026813 join aggView4184313203027666943 using(v26);
create or replace view aggView2562695720665991352 as select v9 from semiDown5073097582164601328;
create or replace view aggJoin4103230936913053004 as select v31, v40 from semiUp3375750810303584727 join aggView2562695720665991352 using(v9);
create or replace view aggView2037188976405137993 as select v40, MIN(v41) as v52 from aggJoin2294026501926391409 group by v40;
create or replace view aggJoin7228980799296349183 as select v31, v52 from aggJoin4103230936913053004 join aggView2037188976405137993 using(v40);
create or replace view aggView1228820754987490749 as select v31 from semiDown4798218532154584386;
create or replace view aggJoin5047655573887690899 as select v52 from aggJoin7228980799296349183 join aggView1228820754987490749 using(v31);
select MIN(v52) as v52 from aggJoin5047655573887690899;

