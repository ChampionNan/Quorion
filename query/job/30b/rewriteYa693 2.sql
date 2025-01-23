create or replace view nAux41 as select id as v36, name as v37 from name where gender= 'm';
create or replace view semiUp5479109188829556507 as select movie_id as v45, info_type_id as v16, info as v26 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'genres') and info IN ('Horror','Thriller');
create or replace view semiUp4860194383169043422 as select movie_id as v45, info_type_id as v18, info as v31 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'votes');
create or replace view mi_idxAux5 as select v45, v31 from semiUp4860194383169043422;
create or replace view miAux79 as select v45, v26 from semiUp5479109188829556507;
create or replace view semiUp8565754033378823289 as select movie_id as v45, keyword_id as v20 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'));
create or replace view semiUp111843949173113600 as select movie_id as v45, subject_id as v5, status_id as v7 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct2 where kind= 'complete+verified');
create or replace view semiUp6480568143108741209 as select v45, v5, v7 from semiUp111843949173113600 where (v5) in (select id from comp_cast_type AS cct1 where kind IN ('cast','crew'));
create or replace view semiUp5913838514290799418 as select id as v45, title as v46 from title AS t where (id) in (select v45 from semiUp6480568143108741209) and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000;
create or replace view semiUp7495021464617620689 as select v45, v46 from semiUp5913838514290799418 where (v45) in (select v45 from semiUp8565754033378823289);
create or replace view tAux14 as select v45, v46 from semiUp7495021464617620689;
create or replace view semiUp5221425315816051582 as select v45, v31 from mi_idxAux5 where (v45) in (select v45 from tAux14);
create or replace view semiUp3999843638986386843 as select v45, v31 from semiUp5221425315816051582 where (v45) in (select v45 from miAux79);
create or replace view semiUp4630944295832419539 as select person_id as v36, movie_id as v45 from cast_info AS ci where (movie_id) in (select v45 from semiUp3999843638986386843) and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)');
create or replace view semiUp449212349043984680 as select v36, v37 from nAux41 where (v36) in (select v36 from semiUp4630944295832419539);
create or replace view semiDown9126697832070946119 as select v36, v45 from semiUp4630944295832419539 where (v36) in (select v36 from semiUp449212349043984680);
create or replace view semiDown2157820353328542203 as select id as v36, name as v37 from name AS n where (name, id) in (select v37, v36 from semiUp449212349043984680) and gender= 'm';
create or replace view semiDown5174882412160532348 as select v45, v31 from semiUp3999843638986386843 where (v45) in (select v45 from semiDown9126697832070946119);
create or replace view semiDown2728960075035949996 as select v45, v46 from tAux14 where (v45) in (select v45 from semiDown5174882412160532348);
create or replace view semiDown6309012991703973453 as select v45, v26 from miAux79 where (v45) in (select v45 from semiDown5174882412160532348);
create or replace view semiDown8497245047420019838 as select v45, v18, v31 from semiUp4860194383169043422 where (v45, v31) in (select v45, v31 from semiDown5174882412160532348);
create or replace view semiDown2803849997540513048 as select v45, v46 from semiUp7495021464617620689 where (v46, v45) in (select v46, v45 from semiDown2728960075035949996);
create or replace view semiDown1771351490093396549 as select v45, v16, v26 from semiUp5479109188829556507 where (v45, v26) in (select v45, v26 from semiDown6309012991703973453);
create or replace view semiDown365790185465152944 as select id as v18 from info_type AS it2 where (id) in (select v18 from semiDown8497245047420019838) and info= 'votes';
create or replace view semiDown8214710785884508684 as select v45, v5, v7 from semiUp6480568143108741209 where (v45) in (select v45 from semiDown2803849997540513048);
create or replace view semiDown2227400953207379604 as select v45, v20 from semiUp8565754033378823289 where (v45) in (select v45 from semiDown2803849997540513048);
create or replace view semiDown3527100797340023137 as select id as v16 from info_type AS it1 where (id) in (select v16 from semiDown1771351490093396549) and info= 'genres';
create or replace view semiDown512304057178435457 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown8214710785884508684) and kind IN ('cast','crew');
create or replace view semiDown9136255083103301020 as select id as v7 from comp_cast_type AS cct2 where (id) in (select v7 from semiDown8214710785884508684) and kind= 'complete+verified';
create or replace view semiDown4618584517813797404 as select id as v20 from keyword AS k where (id) in (select v20 from semiDown2227400953207379604) and keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital');
create or replace view aggView7517133590357354217 as select v37, v36, v37 as v59 from semiDown2157820353328542203;
create or replace view aggView5550546143357493269 as select v20 from semiDown4618584517813797404;
create or replace view aggJoin5818654907534999769 as select v45 from semiDown2227400953207379604 join aggView5550546143357493269 using(v20);
create or replace view aggView8259323844368370986 as select v5 from semiDown512304057178435457;
create or replace view aggJoin47572412171458680 as select v45, v7 from semiDown8214710785884508684 join aggView8259323844368370986 using(v5);
create or replace view aggView7103900930736333894 as select v7 from semiDown9136255083103301020;
create or replace view aggJoin4703296449518721333 as select v45 from aggJoin47572412171458680 join aggView7103900930736333894 using(v7);
create or replace view aggView6718239790115531743 as select v16 from semiDown3527100797340023137;
create or replace view aggJoin8847710892089977882 as select v45, v26 from semiDown1771351490093396549 join aggView6718239790115531743 using(v16);
create or replace view aggView8746522330255545346 as select v45, v26, MIN(v26) as v57 from aggJoin8847710892089977882 group by v45,v26;
create or replace view aggView8938553457287162864 as select v45 from aggJoin4703296449518721333 group by v45;
create or replace view aggJoin3040896590938221572 as select v45, v46 from semiDown2803849997540513048 join aggView8938553457287162864 using(v45);
create or replace view aggView1623558168361454246 as select v45 from aggJoin5818654907534999769 group by v45;
create or replace view aggJoin6809834908377031687 as select v45, v46 from aggJoin3040896590938221572 join aggView1623558168361454246 using(v45);
create or replace view aggView4963876043743082731 as select v46, v45, MIN(v46) as v60 from aggJoin6809834908377031687 group by v46,v45;
create or replace view aggView7826820478143270284 as select v18 from semiDown365790185465152944;
create or replace view aggJoin9039227363220601924 as select v45, v31 from semiDown8497245047420019838 join aggView7826820478143270284 using(v18);
create or replace view aggView4729021427009448995 as select v45, v31, MIN(v31) as v58 from aggJoin9039227363220601924 group by v45,v31;
create or replace view aggView7652475452167750786 as select v45, MIN(v60) as v60 from aggView4963876043743082731 group by v45,v60;
create or replace view aggJoin8955926315372782189 as select v45, v58 as v58, v60 from aggView4729021427009448995 join aggView7652475452167750786 using(v45);
create or replace view aggView2139739282400945049 as select v45, MIN(v57) as v57 from aggView8746522330255545346 group by v45,v57;
create or replace view aggJoin2669735569369922587 as select v45, v58 as v58, v60 as v60, v57 from aggJoin8955926315372782189 join aggView2139739282400945049 using(v45);
create or replace view aggView749812031090645988 as select v45, MIN(v58) as v58, MIN(v60) as v60, MIN(v57) as v57 from aggJoin2669735569369922587 group by v45,v58,v60,v57;
create or replace view aggJoin1767805356910049127 as select v36, v58, v60, v57 from semiDown9126697832070946119 join aggView749812031090645988 using(v45);
create or replace view aggView4849790124780832124 as select v36, MIN(v58) as v58, MIN(v60) as v60, MIN(v57) as v57 from aggJoin1767805356910049127 group by v36,v58,v60,v57;
create or replace view aggJoin7426372431637559215 as select v59 as v59, v58, v60, v57 from aggView7517133590357354217 join aggView4849790124780832124 using(v36);
select MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59, MIN(v60) as v60 from aggJoin7426372431637559215;

