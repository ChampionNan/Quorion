create or replace view semiUp4179760345677403227 as select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info<'8.5';
create or replace view semiUp1245340057780698920 as select movie_id as v45, subject_id as v5, status_id as v7 from complete_cast AS cc where (movie_id) in (select v45 from semiUp4179760345677403227);
create or replace view semiUp7145155482694479143 as select id as v45, title as v46, kind_id as v25 from title AS t where (kind_id) in (select id from kind_type AS kt where kind IN ('movie','episode')) and production_year>2005;
create or replace view semiUp1031620371601591454 as select v45, v46, v25 from semiUp7145155482694479143 where (v45) in (select v45 from semiUp1245340057780698920);
create or replace view semiUp3812657400869194997 as select movie_id as v45, company_id as v9, company_type_id as v16 from movie_companies AS mc where (movie_id) in (select v45 from semiUp1031620371601591454) and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%';
create or replace view semiUp5049490888195375103 as select id as v9, name as v10 from company_name AS cn where (id) in (select v9 from semiUp3812657400869194997) and country_code<> '[us]';
create or replace view semiUp7539829978814706768 as select id as v5 from comp_cast_type AS cct1 where kind= 'cast';
create or replace view semiUp2704872080741051851 as select id as v7 from comp_cast_type AS cct2 where kind= 'complete';
create or replace view semiUp1452893566278383854 as select id as v16 from company_type AS ct;
create or replace view semiUp1183275954048918602 as select movie_id as v45, info_type_id as v18 from movie_info AS mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view semiUp2978629849538321322 as select id as v18 from info_type AS it1 where (id) in (select v18 from semiUp1183275954048918602) and info= 'countries';
create or replace view semiUp4242758045020193277 as select movie_id as v45, keyword_id as v22 from movie_keyword AS mk;
create or replace view semiUp2703396985642315817 as select id as v22 from keyword AS k where (id) in (select v22 from semiUp4242758045020193277) and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view semiDown2609724873605340973 as select v45, v22 from semiUp4242758045020193277 where (v22) in (select v22 from semiUp2703396985642315817);
create or replace view semiDown8474008768734597552 as select v18 from semiUp2978629849538321322;
create or replace view semiDown5055754911563218605 as select v45, v18 from semiUp1183275954048918602 where (v18) in (select v18 from semiDown8474008768734597552);
create or replace view semiDown2311733493201578858 as select v16 from semiUp1452893566278383854;
create or replace view semiDown1332065052525941315 as select v7 from semiUp2704872080741051851;
create or replace view semiDown4836208631665892836 as select v5 from semiUp7539829978814706768;
create or replace view semiDown7046219709430873244 as select v9, v10 from semiUp5049490888195375103;
create or replace view semiDown7666278524286089198 as select v45, v9, v16 from semiUp3812657400869194997 where (v9) in (select v9 from semiDown7046219709430873244);
create or replace view semiDown959659803849539311 as select v45, v46, v25 from semiUp1031620371601591454 where (v45) in (select v45 from semiDown7666278524286089198);
create or replace view semiDown5450197512236616801 as select id as v25 from kind_type AS kt where (id) in (select v25 from semiDown959659803849539311) and kind IN ('movie','episode');
create or replace view semiDown5429059076191009661 as select v45, v5, v7 from semiUp1245340057780698920 where (v45) in (select v45 from semiDown959659803849539311);
create or replace view semiDown8706939577509142940 as select v45, v20, v40 from semiUp4179760345677403227 where (v45) in (select v45 from semiDown5429059076191009661);
create or replace view semiDown7454253753909078739 as select id as v20 from info_type AS it2 where (id) in (select v20 from semiDown8706939577509142940) and info= 'rating';
create or replace view aggView731529401462202274 as select v20 from semiDown7454253753909078739;
create or replace view aggJoin7149736271757659334 as select v45, v40 from semiDown8706939577509142940 join aggView731529401462202274 using(v20);
create or replace view aggView504144512231106741 as select v45, MIN(v40) as v58 from aggJoin7149736271757659334 group by v45;
create or replace view aggJoin4634310619530991421 as select v45, v5, v7, v58 from semiDown5429059076191009661 join aggView504144512231106741 using(v45);
create or replace view aggView3055035035792290051 as select v45, v5, v7, MIN(v58) as v58 from aggJoin4634310619530991421 group by v45,v5,v7,v58;
create or replace view aggJoin2729653780323392385 as select v45, v46, v25, v5, v7, v58 from semiDown959659803849539311 join aggView3055035035792290051 using(v45);
create or replace view aggView7688412029169993767 as select v25 from semiDown5450197512236616801;
create or replace view aggJoin9187859975055909091 as select v45, v46, v5, v7, v58 from aggJoin2729653780323392385 join aggView7688412029169993767 using(v25);
create or replace view aggView7737849305400134146 as select v45, v5, v7, MIN(v58) as v58, MIN(v46) as v59 from aggJoin9187859975055909091 group by v45,v5,v7,v58;
create or replace view aggJoin7899646353263221976 as select v45, v9, v16, v5, v7, v58, v59 from semiDown7666278524286089198 join aggView7737849305400134146 using(v45);
create or replace view aggView8272282399630205066 as select v9, v45, v16, v5, v7, MIN(v58) as v58, MIN(v59) as v59 from aggJoin7899646353263221976 group by v9,v45,v16,v5,v7,v58,v59;
create or replace view aggJoin8128218327280265450 as select v10, v45, v16, v5, v7, v58, v59 from semiDown7046219709430873244 join aggView8272282399630205066 using(v9);
create or replace view aggView7697842890315559863 as select v5, v45, v16, v7, MIN(v58) as v58, MIN(v59) as v59, MIN(v10) as v57 from aggJoin8128218327280265450 group by v5,v45,v16,v7,v58,v59;
create or replace view aggJoin7259831595577151239 as select v5, v45, v16, v7, v58, v59, v57 from semiDown4836208631665892836 join aggView7697842890315559863 using(v5);
create or replace view aggView1356922738699645670 as select v7, v45, v16, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin7259831595577151239 group by v7,v45,v16,v58,v59,v57;
create or replace view aggJoin7066426513348219296 as select v7, v45, v16, v58, v59, v57 from semiDown1332065052525941315 join aggView1356922738699645670 using(v7);
create or replace view aggView5581350656869011024 as select v16, v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin7066426513348219296 group by v16,v45,v58,v59,v57;
create or replace view aggJoin8323796817383062508 as select v16, v45, v58, v59, v57 from semiDown2311733493201578858 join aggView5581350656869011024 using(v16);
create or replace view aggView9095753681784374272 as select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin8323796817383062508 group by v45,v58,v59,v57;
create or replace view aggJoin1368926109729525311 as select v45, v18, v58, v59, v57 from semiDown5055754911563218605 join aggView9095753681784374272 using(v45);
create or replace view aggView4552667114757235594 as select v18, v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin1368926109729525311 group by v18,v45,v58,v59,v57;
create or replace view aggJoin4134073438243292471 as select v45, v58, v59, v57 from semiDown8474008768734597552 join aggView4552667114757235594 using(v18);
create or replace view aggView344157483573206388 as select v45, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin4134073438243292471 group by v45,v58,v59,v57;
create or replace view aggJoin8316660607379539799 as select v45, v22, v58, v59, v57 from semiDown2609724873605340973 join aggView344157483573206388 using(v45);
create or replace view aggView3739073236401550479 as select v22, MIN(v58) as v58, MIN(v59) as v59, MIN(v57) as v57 from aggJoin8316660607379539799 group by v22,v58,v59,v57;
create or replace view aggJoin2014231690576182329 as select v58, v59, v57 from semiUp2703396985642315817 join aggView3739073236401550479 using(v22);
select MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin2014231690576182329;

