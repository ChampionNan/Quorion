create or replace view semiUp6814596384315386905 as select movie_id as v37, info_type_id as v8, info as v18 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'genres') and info= 'Horror';
create or replace view semiUp7099177317418158431 as select movie_id as v37, info_type_id as v10, info as v23 from movie_info_idx AS mi_idx where (movie_id) in (select v37 from semiUp6814596384315386905);
create or replace view semiUp5750046699026099395 as select id as v10 from info_type AS it2 where (id) in (select v10 from semiUp7099177317418158431) and info= 'votes';
create or replace view semiUp8991616669792944001 as select movie_id as v37, keyword_id as v12 from movie_keyword AS mk;
create or replace view semiUp7449302781401051097 as select id as v12 from keyword AS k where (id) in (select v12 from semiUp8991616669792944001) and keyword IN ('murder','blood','gore','death','female-nudity');
create or replace view semiUp8480086297230026138 as select id as v37, title as v38 from title AS t;
create or replace view semiUp8056940307377514978 as select person_id as v28, movie_id as v37 from cast_info AS ci where (movie_id) in (select v37 from semiUp8480086297230026138) and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)');
create or replace view semiUp320256351767323702 as select id as v28, name as v29 from name AS n where (id) in (select v28 from semiUp8056940307377514978) and gender= 'm';
create or replace view semiDown8180427664843116306 as select v28, v37 from semiUp8056940307377514978 where (v28) in (select v28 from semiUp320256351767323702);
create or replace view semiDown5131300433240600720 as select v37, v38 from semiUp8480086297230026138 where (v37) in (select v37 from semiDown8180427664843116306);
create or replace view semiDown98435237944237648 as select v12 from semiUp7449302781401051097;
create or replace view semiDown6251342899287152461 as select v37, v12 from semiUp8991616669792944001 where (v12) in (select v12 from semiDown98435237944237648);
create or replace view semiDown259232053976418641 as select v10 from semiUp5750046699026099395;
create or replace view semiDown2954378438350830994 as select v37, v10, v23 from semiUp7099177317418158431 where (v10) in (select v10 from semiDown259232053976418641);
create or replace view semiDown7303559138943501471 as select v37, v8, v18 from semiUp6814596384315386905 where (v37) in (select v37 from semiDown2954378438350830994);
create or replace view semiDown8770279695264128345 as select id as v8 from info_type AS it1 where (id) in (select v8 from semiDown7303559138943501471) and info= 'genres';
create or replace view aggView6715280382189787518 as select v8 from semiDown8770279695264128345;
create or replace view aggJoin8431067056422067766 as select v37, v18 from semiDown7303559138943501471 join aggView6715280382189787518 using(v8);
create or replace view aggView8029120376443463605 as select v37, MIN(v18) as v49 from aggJoin8431067056422067766 group by v37;
create or replace view aggJoin6100945476144155511 as select v37, v10, v23, v49 from semiDown2954378438350830994 join aggView8029120376443463605 using(v37);
create or replace view aggView3662212650559329762 as select v10, v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin6100945476144155511 group by v10,v37,v49;
create or replace view aggJoin8091001309657917949 as select v37, v49, v50 from semiDown259232053976418641 join aggView3662212650559329762 using(v10);
create or replace view aggView8919965992302651634 as select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8091001309657917949 group by v37,v49,v50;
create or replace view aggJoin6840478219298776121 as select v37, v12, v49, v50 from semiDown6251342899287152461 join aggView8919965992302651634 using(v37);
create or replace view aggView2940969231613802931 as select v12, v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin6840478219298776121 group by v12,v37,v49,v50;
create or replace view aggJoin6980718184786073234 as select v37, v49, v50 from semiDown98435237944237648 join aggView2940969231613802931 using(v12);
create or replace view aggView4088885734884137244 as select v37, MIN(v49) as v49, MIN(v50) as v50 from aggJoin6980718184786073234 group by v37,v49,v50;
create or replace view aggJoin3728015276976998029 as select v37, v38, v49, v50 from semiDown5131300433240600720 join aggView4088885734884137244 using(v37);
create or replace view aggView6254790479059706610 as select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v52 from aggJoin3728015276976998029 group by v37,v49,v50;
create or replace view aggJoin8084779722662743458 as select v28, v37, v49, v50, v52 from semiDown8180427664843116306 join aggView6254790479059706610 using(v37);
create or replace view aggView1569089864758695750 as select v28, MIN(v49) as v49, MIN(v50) as v50, MIN(v52) as v52 from aggJoin8084779722662743458 group by v28,v52,v49,v50;
create or replace view aggJoin916051551975177306 as select v29, v49, v50, v52 from semiUp320256351767323702 join aggView1569089864758695750 using(v28);
select MIN(v49) as v49, MIN(v50) as v50, MIN(v29) as v51, MIN(v52) as v52 from aggJoin916051551975177306;

