create or replace view cnAux12 as select id as v25, name as v10 from company_name where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view tAux40 as select id as v37, title as v41 from title where production_year= 1998;
create or replace view semiUp4631107957138260867 as select movie_id as v37, company_id as v25, company_type_id as v26 from movie_companies AS mc where (movie_id) in (select v37 from tAux40);
create or replace view semiUp6671534148339943733 as select movie_id as v37, subject_id as v5, status_id as v7 from complete_cast AS cc where (subject_id) in (select id from comp_cast_type AS cct1 where kind IN ('cast','crew'));
create or replace view semiUp5232358268613262999 as select movie_id as v37, keyword_id as v35 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'sequel');
create or replace view semiUp8327488353206194134 as select v37, v25, v26 from semiUp4631107957138260867 where (v25) in (select v25 from cnAux12);
create or replace view semiUp4958063767672555950 as select v37, v5, v7 from semiUp6671534148339943733 where (v7) in (select id from comp_cast_type AS cct2 where kind= 'complete');
create or replace view semiUp3395691838337840371 as select v37, v5, v7 from semiUp4958063767672555950 where (v37) in (select v37 from semiUp5232358268613262999);
create or replace view semiUp1223176240119022212 as select v37, v25, v26 from semiUp8327488353206194134 where (v26) in (select id from company_type AS ct where kind= 'production companies');
create or replace view semiUp333235567094585830 as select movie_id as v37 from movie_info AS mi where (movie_id) in (select v37 from semiUp3395691838337840371) and info IN ('Sweden','Germany','Swedish','German');
create or replace view semiUp2666101073634731665 as select movie_id as v37, link_type_id as v21 from movie_link AS ml where (movie_id) in (select v37 from semiUp333235567094585830);
create or replace view semiUp8779696829635776778 as select v37, v21 from semiUp2666101073634731665 where (v37) in (select v37 from semiUp1223176240119022212);
create or replace view semiUp7876054809759644462 as select id as v21, link as v22 from link_type AS lt where (id) in (select v21 from semiUp8779696829635776778) and link LIKE '%follow%';
create or replace view semiDown685081970872122897 as select v37, v21 from semiUp8779696829635776778 where (v21) in (select v21 from semiUp7876054809759644462);
create or replace view semiDown2914070104553520575 as select v37 from semiUp333235567094585830 where (v37) in (select v37 from semiDown685081970872122897);
create or replace view semiDown3435712114216730745 as select v37, v25, v26 from semiUp1223176240119022212 where (v37) in (select v37 from semiDown685081970872122897);
create or replace view semiDown7978250317805773799 as select v37, v5, v7 from semiUp3395691838337840371 where (v37) in (select v37 from semiDown2914070104553520575);
create or replace view semiDown3190541246614708697 as select id as v26 from company_type AS ct where (id) in (select v26 from semiDown3435712114216730745) and kind= 'production companies';
create or replace view semiDown2906948241114312443 as select v37, v41 from tAux40 where (v37) in (select v37 from semiDown3435712114216730745);
create or replace view semiDown1187255536706472844 as select v25, v10 from cnAux12 where (v25) in (select v25 from semiDown3435712114216730745);
create or replace view semiDown7569571165351879899 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown7978250317805773799) and kind IN ('cast','crew');
create or replace view semiDown1127127809872765655 as select id as v7 from comp_cast_type AS cct2 where (id) in (select v7 from semiDown7978250317805773799) and kind= 'complete';
create or replace view semiDown5637788650350906836 as select v37, v35 from semiUp5232358268613262999 where (v37) in (select v37 from semiDown7978250317805773799);
create or replace view semiDown3077844412956507696 as select id as v37, title as v41 from title AS t where (title, id) in (select v41, v37 from semiDown2906948241114312443) and production_year= 1998;
create or replace view semiDown7779001593551245315 as select id as v25, name as v10 from company_name AS cn where (id, name) in (select v25, v10 from semiDown1187255536706472844) and ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view semiDown3067849114074328727 as select id as v35 from keyword AS k where (id) in (select v35 from semiDown5637788650350906836) and keyword= 'sequel';
create or replace view aggView9187045519103715255 as select v41, v37, v41 as v54 from semiDown3077844412956507696;
create or replace view aggView3255247577054453907 as select v25, v10, v10 as v52 from semiDown7779001593551245315;
create or replace view aggView4951737576379316134 as select v35 from semiDown3067849114074328727;
create or replace view aggJoin8717450521892390451 as select v37 from semiDown5637788650350906836 join aggView4951737576379316134 using(v35);
create or replace view aggView3928652315086639372 as select v5 from semiDown7569571165351879899;
create or replace view aggJoin8514947775369567567 as select v37, v7 from semiDown7978250317805773799 join aggView3928652315086639372 using(v5);
create or replace view aggView1633721198748539496 as select v37 from aggJoin8717450521892390451 group by v37;
create or replace view aggJoin4793338906562604402 as select v37, v7 from aggJoin8514947775369567567 join aggView1633721198748539496 using(v37);
create or replace view aggView2478069534839913228 as select v7 from semiDown1127127809872765655;
create or replace view aggJoin5403138105996115621 as select v37 from aggJoin4793338906562604402 join aggView2478069534839913228 using(v7);
create or replace view aggView1000759609365423227 as select v25, MIN(v52) as v52 from aggView3255247577054453907 group by v25,v52;
create or replace view aggJoin2038952576547439556 as select v37, v26, v52 from semiDown3435712114216730745 join aggView1000759609365423227 using(v25);
create or replace view aggView117234320274688966 as select v37, MIN(v54) as v54 from aggView9187045519103715255 group by v37,v54;
create or replace view aggJoin1768884093063865970 as select v37, v26, v52 as v52, v54 from aggJoin2038952576547439556 join aggView117234320274688966 using(v37);
create or replace view aggView7598324890708394988 as select v26 from semiDown3190541246614708697;
create or replace view aggJoin2831325140982918853 as select v37, v52, v54 from aggJoin1768884093063865970 join aggView7598324890708394988 using(v26);
create or replace view aggView2985689837582660095 as select v37 from aggJoin5403138105996115621 group by v37;
create or replace view aggJoin3462726792398473622 as select v37 from semiDown2914070104553520575 join aggView2985689837582660095 using(v37);
create or replace view aggView5874161535715400000 as select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2831325140982918853 group by v37,v52,v54;
create or replace view aggJoin3294325261068685423 as select v37, v21, v52, v54 from semiDown685081970872122897 join aggView5874161535715400000 using(v37);
create or replace view aggView7278473371979497674 as select v37 from aggJoin3462726792398473622 group by v37;
create or replace view aggJoin2737783548087364791 as select v21, v52 as v52, v54 as v54 from aggJoin3294325261068685423 join aggView7278473371979497674 using(v37);
create or replace view aggView5088055766256119897 as select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2737783548087364791 group by v21,v52,v54;
create or replace view aggJoin4188651813765245624 as select v22, v52, v54 from semiUp7876054809759644462 join aggView5088055766256119897 using(v21);
select MIN(v52) as v52, MIN(v22) as v53, MIN(v54) as v54 from aggJoin4188651813765245624;

