create or replace view semiUp7096604467740864785 as select id as v47, title as v48, kind_id as v28 from title AS t where (kind_id) in (select id from kind_type AS kt where kind= 'movie') and production_year>2005;
create or replace view semiUp6233941720837238083 as select v47, v48, v28 from semiUp7096604467740864785;
create or replace view semiUp4195368537561132851 as select movie_id as v47, info_type_id as v23, info as v33 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info>'8.0';
create or replace view semiUp4677590923183851770 as select movie_id as v47, subject_id as v5, status_id as v7 from complete_cast AS cc where (movie_id) in (select v47 from semiUp4195368537561132851);
create or replace view semiUp4907465391318953991 as select v47, v48, v28 from semiUp6233941720837238083 where (v47) in (select v47 from semiUp4677590923183851770);
create or replace view semiUp1007013989667026614 as select id as v5 from comp_cast_type AS cct1 where kind= 'cast';
create or replace view semiUp5677501123619633541 as select movie_id as v47, keyword_id as v25 from movie_keyword AS mk;
create or replace view semiUp6961184192786700393 as select id as v25 from keyword AS k where (id) in (select v25 from semiUp5677501123619633541) and keyword IN ('superhero','marvel-comics','based-on-comic','fight');
create or replace view semiUp2399472732145671982 as select person_id as v38, movie_id as v47, person_role_id as v9 from cast_info AS ci;
create or replace view semiUp5397347132377831004 as select id as v9, name as v10 from char_name AS chn where (id) in (select v9 from semiUp2399472732145671982) and ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view semiUp6756581596820250778 as select id as v38 from name AS n;
create or replace view semiDown6785711013923949788 as select v9, v10 from semiUp5397347132377831004;
create or replace view semiDown8936377374890704471 as select v38, v47, v9 from semiUp2399472732145671982 where (v9) in (select v9 from semiDown6785711013923949788);
create or replace view semiDown1912382188319342102 as select v25 from semiUp6961184192786700393;
create or replace view semiDown4897669259181602410 as select v47, v25 from semiUp5677501123619633541 where (v25) in (select v25 from semiDown1912382188319342102);
create or replace view semiDown3617575706100515886 as select v5 from semiUp1007013989667026614;
create or replace view semiDown6507004775197396961 as select v47, v48, v28 from semiUp4907465391318953991;
create or replace view semiDown3783976939013313340 as select id as v7 from comp_cast_type AS cct2 where kind LIKE '%complete%';
create or replace view semiDown910221867255261652 as select id as v28 from kind_type AS kt where (id) in (select v28 from semiDown6507004775197396961) and kind= 'movie';
create or replace view semiDown1832639623198019662 as select v47, v5, v7 from semiUp4677590923183851770 where (v47) in (select v47 from semiDown6507004775197396961);
create or replace view semiDown2147637361511209224 as select v47, v23, v33 from semiUp4195368537561132851 where (v47) in (select v47 from semiDown1832639623198019662);
create or replace view semiDown2155508577907791538 as select id as v23 from info_type AS it2 where (id) in (select v23 from semiDown2147637361511209224) and info= 'rating';
create or replace view aggView3517659540006799383 as select v23 from semiDown2155508577907791538;
create or replace view aggJoin5673973539366992441 as select v47, v33 from semiDown2147637361511209224 join aggView3517659540006799383 using(v23);
create or replace view aggView6444726058963773124 as select v47, MIN(v33) as v60 from aggJoin5673973539366992441 group by v47;
create or replace view aggJoin1347327722995998443 as select v47, v5, v7, v60 from semiDown1832639623198019662 join aggView6444726058963773124 using(v47);
create or replace view aggView5579901299269210206 as select v47, v5, v7, MIN(v60) as v60 from aggJoin1347327722995998443 group by v47,v5,v7,v60;
create or replace view aggJoin1389301339410180235 as select v47, v48, v28, v5, v7, v60 from semiDown6507004775197396961 join aggView5579901299269210206 using(v47);
create or replace view aggView1390036898685614949 as select v28 from semiDown910221867255261652;
create or replace view aggJoin9084444500570923271 as select v47, v48, v5, v7, v60 from aggJoin1389301339410180235 join aggView1390036898685614949 using(v28);
create or replace view aggView7500269883667319444 as select v7 from semiDown3783976939013313340 group by v7;
create or replace view aggJoin2689279191615149119 as select v47, v48, v5, v7, v60 as v60 from aggJoin9084444500570923271 join aggView7500269883667319444 using(v7);
create or replace view aggView1073428653810755080 as select v5, v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin2689279191615149119 group by v5,v47,v60;
create or replace view aggJoin1174469078159732918 as select v5, v47, v60, v61 from semiDown3617575706100515886 join aggView1073428653810755080 using(v5);
create or replace view aggView4243989031149968288 as select v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin1174469078159732918 group by v47,v61,v60;
create or replace view aggJoin8428759034147467623 as select v47, v25, v60, v61 from semiDown4897669259181602410 join aggView4243989031149968288 using(v47);
create or replace view aggView7538668252699546491 as select v25, v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin8428759034147467623 group by v25,v47,v61,v60;
create or replace view aggJoin1327248636734945692 as select v47, v60, v61 from semiDown1912382188319342102 join aggView7538668252699546491 using(v25);
create or replace view aggView1472522559117602562 as select v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin1327248636734945692 group by v47,v61,v60;
create or replace view aggJoin3460107395754476380 as select v38, v47, v9, v60, v61 from semiDown8936377374890704471 join aggView1472522559117602562 using(v47);
create or replace view aggView1091277713775012789 as select v9, v38, MIN(v60) as v60, MIN(v61) as v61 from aggJoin3460107395754476380 group by v9,v38,v61,v60;
create or replace view aggJoin1518886318632817794 as select v10, v38, v60, v61 from semiDown6785711013923949788 join aggView1091277713775012789 using(v9);
create or replace view aggView6114438010378176888 as select v38, MIN(v60) as v60, MIN(v61) as v61, MIN(v10) as v59 from aggJoin1518886318632817794 group by v38,v61,v60;
create or replace view aggJoin2897898684593435896 as select v38, v60, v61, v59 from semiUp6756581596820250778 join aggView6114438010378176888 using(v38);
select MIN(v59) as v59, MIN(v60) as v60, MIN(v61) as v61 from aggJoin2897898684593435896;

