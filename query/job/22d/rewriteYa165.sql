create or replace view semiUp8258959246782167227 as select movie_id as v37, info_type_id as v12, info as v32 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info<'8.5';
create or replace view semiUp8086281159452111504 as select movie_id as v37, keyword_id as v14 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('murder','murder-in-title','blood','violence'));
create or replace view semiUp4192196859154710180 as select movie_id as v37, info_type_id as v10 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'countries') and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view semiUp2950653851952927134 as select movie_id as v37, company_id as v1, company_type_id as v8 from movie_companies AS mc where (movie_id) in (select v37 from semiUp4192196859154710180);
create or replace view semiUp6155430038869310329 as select id as v37, title as v38, kind_id as v17 from title AS t where (kind_id) in (select id from kind_type AS kt where kind IN ('movie','episode')) and production_year>2005;
create or replace view semiUp891560668908198266 as select v37, v1, v8 from semiUp2950653851952927134 where (v8) in (select id from company_type AS ct);
create or replace view semiUp499148279446102174 as select v37, v1, v8 from semiUp891560668908198266 where (v1) in (select id from company_name AS cn where country_code<> '[us]');
create or replace view semiUp4309535783748292063 as select v37, v38, v17 from semiUp6155430038869310329 where (v37) in (select v37 from semiUp499148279446102174);
create or replace view semiUp4802213925570259707 as select v37, v12, v32 from semiUp8258959246782167227 where (v37) in (select v37 from semiUp4309535783748292063);
create or replace view semiUp5336293356908638170 as select v37, v14 from semiUp8086281159452111504 where (v37) in (select v37 from semiUp4802213925570259707);
create or replace view semiDown9069323616600616097 as select id as v14 from keyword AS k where (id) in (select v14 from semiUp5336293356908638170) and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view semiDown5146239433311029115 as select v37, v12, v32 from semiUp4802213925570259707 where (v37) in (select v37 from semiUp5336293356908638170);
create or replace view semiDown434426076442407508 as select id as v12 from info_type AS it2 where (id) in (select v12 from semiDown5146239433311029115) and info= 'rating';
create or replace view semiDown6334113713909617359 as select v37, v38, v17 from semiUp4309535783748292063 where (v37) in (select v37 from semiDown5146239433311029115);
create or replace view semiDown4296216370459823313 as select id as v17 from kind_type AS kt where (id) in (select v17 from semiDown6334113713909617359) and kind IN ('movie','episode');
create or replace view semiDown4041580748889819402 as select v37, v1, v8 from semiUp499148279446102174 where (v37) in (select v37 from semiDown6334113713909617359);
create or replace view semiDown3922793037902060889 as select id as v8 from company_type AS ct where (id) in (select v8 from semiDown4041580748889819402);
create or replace view semiDown2023557385496299266 as select id as v1, name as v2 from company_name AS cn where (id) in (select v1 from semiDown4041580748889819402) and country_code<> '[us]';
create or replace view semiDown2955867569896089855 as select v37, v10 from semiUp4192196859154710180 where (v37) in (select v37 from semiDown4041580748889819402);
create or replace view semiDown623960118067152802 as select id as v10 from info_type AS it1 where (id) in (select v10 from semiDown2955867569896089855) and info= 'countries';
create or replace view aggView4802090597071554542 as select v10 from semiDown623960118067152802;
create or replace view aggJoin3788919470377787413 as select v37 from semiDown2955867569896089855 join aggView4802090597071554542 using(v10);
create or replace view aggView4125281921818229140 as select v37 from aggJoin3788919470377787413 group by v37;
create or replace view aggJoin3714086941309924517 as select v37, v1, v8 from semiDown4041580748889819402 join aggView4125281921818229140 using(v37);
create or replace view aggView5450971515407734718 as select v8 from semiDown3922793037902060889;
create or replace view aggJoin1982054681082264660 as select v37, v1 from aggJoin3714086941309924517 join aggView5450971515407734718 using(v8);
create or replace view aggView3039138787598238520 as select v1, v2 as v49 from semiDown2023557385496299266;
create or replace view aggJoin5389646679985883292 as select v37, v49 from aggJoin1982054681082264660 join aggView3039138787598238520 using(v1);
create or replace view aggView2434431237622762007 as select v17 from semiDown4296216370459823313;
create or replace view aggJoin8595755972210478153 as select v37, v38 from semiDown6334113713909617359 join aggView2434431237622762007 using(v17);
create or replace view aggView1058004002405626708 as select v37, MIN(v49) as v49 from aggJoin5389646679985883292 group by v37,v49;
create or replace view aggJoin3270651001731704804 as select v37, v38, v49 from aggJoin8595755972210478153 join aggView1058004002405626708 using(v37);
create or replace view aggView1699775665923492832 as select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin3270651001731704804 group by v37,v49;
create or replace view aggJoin5584122451950400670 as select v37, v12, v32, v49, v51 from semiDown5146239433311029115 join aggView1699775665923492832 using(v37);
create or replace view aggView9012442544798517775 as select v12 from semiDown434426076442407508;
create or replace view aggJoin333415918413741523 as select v37, v32, v49, v51 from aggJoin5584122451950400670 join aggView9012442544798517775 using(v12);
create or replace view aggView6490992127582711914 as select v14 from semiDown9069323616600616097;
create or replace view aggJoin4009609976400529766 as select v37 from semiUp5336293356908638170 join aggView6490992127582711914 using(v14);
create or replace view aggView4613955944444080595 as select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin333415918413741523 group by v37,v49,v51;
create or replace view aggJoin8987740553016352019 as select v49, v51, v50 from aggJoin4009609976400529766 join aggView4613955944444080595 using(v37);
select MIN(v49) as v49, MIN(v50) as v50, MIN(v51) as v51 from aggJoin8987740553016352019;

