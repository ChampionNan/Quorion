create or replace view semiUp7079947541946131797 as select id as v36, title as v37, kind_id as v21 from title AS t where (kind_id) in (select id from kind_type AS kt where kind IN ('movie','tv movie','video movie','video game')) and production_year>1990;
create or replace view semiUp6212425049478718304 as select movie_id as v36, company_id as v7, company_type_id as v14 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct);
create or replace view semiUp7442109634654496222 as select v36, v7, v14 from semiUp6212425049478718304 where (v7) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp6983604184788400163 as select movie_id as v36, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k);
create or replace view semiUp4130601990495879227 as select movie_id as v36, status_id as v5 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct1 where kind= 'complete+verified');
create or replace view semiUp3672265672529966648 as select movie_id as v36, info_type_id as v16 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'release dates') and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%';
create or replace view semiUp1388307599010372569 as select v36, v37, v21 from semiUp7079947541946131797 where (v36) in (select v36 from semiUp4130601990495879227);
create or replace view semiUp6546659378007416516 as select v36, v37, v21 from semiUp1388307599010372569 where (v36) in (select v36 from semiUp3672265672529966648);
create or replace view semiUp1084836595848494872 as select v36, v7, v14 from semiUp7442109634654496222 where (v36) in (select v36 from semiUp6546659378007416516);
create or replace view semiUp3428118909419254242 as select v36, v18 from semiUp6983604184788400163 where (v36) in (select v36 from semiUp1084836595848494872);
create or replace view semiDown7455620933939827380 as select id as v18 from keyword AS k where (id) in (select v18 from semiUp3428118909419254242);
create or replace view semiDown1480113023188616280 as select v36, v7, v14 from semiUp1084836595848494872 where (v36) in (select v36 from semiUp3428118909419254242);
create or replace view semiDown8463612121918590713 as select id as v14 from company_type AS ct where (id) in (select v14 from semiDown1480113023188616280);
create or replace view semiDown2963931013880697768 as select id as v7 from company_name AS cn where (id) in (select v7 from semiDown1480113023188616280) and country_code= '[us]';
create or replace view semiDown4343629952677409728 as select v36, v37, v21 from semiUp6546659378007416516 where (v36) in (select v36 from semiDown1480113023188616280);
create or replace view semiDown5347501937355895293 as select id as v21, kind as v22 from kind_type AS kt where (id) in (select v21 from semiDown4343629952677409728) and kind IN ('movie','tv movie','video movie','video game');
create or replace view semiDown6186258834312690804 as select v36, v16 from semiUp3672265672529966648 where (v36) in (select v36 from semiDown4343629952677409728);
create or replace view semiDown3778463737342229129 as select v36, v5 from semiUp4130601990495879227 where (v36) in (select v36 from semiDown4343629952677409728);
create or replace view semiDown1359166252363757798 as select id as v16 from info_type AS it1 where (id) in (select v16 from semiDown6186258834312690804) and info= 'release dates';
create or replace view semiDown8860095657141986606 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown3778463737342229129) and kind= 'complete+verified';
create or replace view aggView8287643326372864407 as select v5 from semiDown8860095657141986606;
create or replace view aggJoin8058122541325398770 as select v36 from semiDown3778463737342229129 join aggView8287643326372864407 using(v5);
create or replace view aggView5312901949895340018 as select v16 from semiDown1359166252363757798;
create or replace view aggJoin187947866405603774 as select v36 from semiDown6186258834312690804 join aggView5312901949895340018 using(v16);
create or replace view aggView4198370405144396630 as select v36 from aggJoin8058122541325398770 group by v36;
create or replace view aggJoin4630625398479684075 as select v36, v37, v21 from semiDown4343629952677409728 join aggView4198370405144396630 using(v36);
create or replace view aggView3604817886024524898 as select v36 from aggJoin187947866405603774 group by v36;
create or replace view aggJoin5766924022449728444 as select v36, v37, v21 from aggJoin4630625398479684075 join aggView3604817886024524898 using(v36);
create or replace view aggView5495592174452488745 as select v21, v22 as v48 from semiDown5347501937355895293;
create or replace view aggJoin2922221834654618286 as select v36, v37, v48 from aggJoin5766924022449728444 join aggView5495592174452488745 using(v21);
create or replace view aggView8836082636765113007 as select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin2922221834654618286 group by v36,v48;
create or replace view aggJoin8421330615665476561 as select v36, v7, v14, v48, v49 from semiDown1480113023188616280 join aggView8836082636765113007 using(v36);
create or replace view aggView3043885759112141845 as select v7 from semiDown2963931013880697768;
create or replace view aggJoin7658510553408509248 as select v36, v14, v48, v49 from aggJoin8421330615665476561 join aggView3043885759112141845 using(v7);
create or replace view aggView3643121335896302518 as select v14 from semiDown8463612121918590713;
create or replace view aggJoin5077271505633093442 as select v36, v48, v49 from aggJoin7658510553408509248 join aggView3643121335896302518 using(v14);
create or replace view aggView3359710632315685379 as select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin5077271505633093442 group by v36,v48,v49;
create or replace view aggJoin2787311172297651441 as select v18, v48, v49 from semiUp3428118909419254242 join aggView3359710632315685379 using(v36);
create or replace view aggView6923012153343868013 as select v18 from semiDown7455620933939827380;
create or replace view aggJoin991875355378395053 as select v48, v49 from aggJoin2787311172297651441 join aggView6923012153343868013 using(v18);
select MIN(v48) as v48, MIN(v49) as v49 from aggJoin991875355378395053;

