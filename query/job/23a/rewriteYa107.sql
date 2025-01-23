create or replace view semiUp4582508211243860933 as select movie_id as v36, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k);
create or replace view semiUp6191893299394628514 as select movie_id as v36, company_id as v7, company_type_id as v14 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct);
create or replace view semiUp4471324667060358190 as select v36, v7, v14 from semiUp6191893299394628514 where (v7) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp6680269826593572155 as select v36, v18 from semiUp4582508211243860933 where (v36) in (select v36 from semiUp4471324667060358190);
create or replace view semiUp9063344439711784619 as select movie_id as v36, info_type_id as v16 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'release dates') and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')) and note LIKE '%internet%';
create or replace view semiUp6555488567308733681 as select movie_id as v36, status_id as v5 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct1 where kind= 'complete+verified');
create or replace view semiUp6977059332106020046 as select v36, v18 from semiUp6680269826593572155 where (v36) in (select v36 from semiUp9063344439711784619);
create or replace view semiUp3558498358030853978 as select id as v36, title as v37, kind_id as v21 from title AS t where (id) in (select v36 from semiUp6977059332106020046) and production_year>2000;
create or replace view semiUp6303230033312443703 as select v36, v37, v21 from semiUp3558498358030853978 where (v36) in (select v36 from semiUp6555488567308733681);
create or replace view tAux21 as select v37, v21 from semiUp6303230033312443703;
create or replace view semiUp6819350642629516879 as select v37, v21 from tAux21 where (v21) in (select id from kind_type AS kt where kind= 'movie');
create or replace view semiDown7916378622945169213 as select id as v21, kind as v22 from kind_type AS kt where (id) in (select v21 from semiUp6819350642629516879) and kind= 'movie';
create or replace view semiDown6882759695955843232 as select v36, v37, v21 from semiUp6303230033312443703 where (v21, v37) in (select v21, v37 from semiUp6819350642629516879);
create or replace view semiDown7475619239028749647 as select v36, v5 from semiUp6555488567308733681 where (v36) in (select v36 from semiDown6882759695955843232);
create or replace view semiDown2208913741145811880 as select v36, v18 from semiUp6977059332106020046 where (v36) in (select v36 from semiDown6882759695955843232);
create or replace view semiDown4206651834352306974 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown7475619239028749647) and kind= 'complete+verified';
create or replace view semiDown4678332886133513288 as select v36, v16 from semiUp9063344439711784619 where (v36) in (select v36 from semiDown2208913741145811880);
create or replace view semiDown3079124397667515543 as select id as v18 from keyword AS k where (id) in (select v18 from semiDown2208913741145811880);
create or replace view semiDown77490438798269753 as select v36, v7, v14 from semiUp4471324667060358190 where (v36) in (select v36 from semiDown2208913741145811880);
create or replace view semiDown5193598996123213374 as select id as v16 from info_type AS it1 where (id) in (select v16 from semiDown4678332886133513288) and info= 'release dates';
create or replace view semiDown5791416049973930533 as select id as v14 from company_type AS ct where (id) in (select v14 from semiDown77490438798269753);
create or replace view semiDown7997764382881275298 as select id as v7 from company_name AS cn where (id) in (select v7 from semiDown77490438798269753) and country_code= '[us]';
create or replace view aggView5083502947942883886 as select v14 from semiDown5791416049973930533;
create or replace view aggJoin2262264826880818508 as select v36, v7 from semiDown77490438798269753 join aggView5083502947942883886 using(v14);
create or replace view aggView4123571084012721674 as select v16 from semiDown5193598996123213374;
create or replace view aggJoin2588636762581940446 as select v36 from semiDown4678332886133513288 join aggView4123571084012721674 using(v16);
create or replace view aggView7838024756032272859 as select v7 from semiDown7997764382881275298;
create or replace view aggJoin4414018474158668890 as select v36 from aggJoin2262264826880818508 join aggView7838024756032272859 using(v7);
create or replace view aggView1605367014088709365 as select v36 from aggJoin4414018474158668890 group by v36;
create or replace view aggJoin1277941934682905007 as select v36, v18 from semiDown2208913741145811880 join aggView1605367014088709365 using(v36);
create or replace view aggView6006069986157968206 as select v5 from semiDown4206651834352306974;
create or replace view aggJoin2847787113096091553 as select v36 from semiDown7475619239028749647 join aggView6006069986157968206 using(v5);
create or replace view aggView7957117615515754860 as select v36 from aggJoin2588636762581940446 group by v36;
create or replace view aggJoin5491538476833588589 as select v36, v18 from aggJoin1277941934682905007 join aggView7957117615515754860 using(v36);
create or replace view aggView3437721214370216637 as select v18 from semiDown3079124397667515543;
create or replace view aggJoin3139144432846548808 as select v36 from aggJoin5491538476833588589 join aggView3437721214370216637 using(v18);
create or replace view aggView1948407393586039987 as select v36 from aggJoin2847787113096091553 group by v36;
create or replace view aggJoin956157959695153647 as select v36, v37, v21 from semiDown6882759695955843232 join aggView1948407393586039987 using(v36);
create or replace view aggView3373688765850076798 as select v36 from aggJoin3139144432846548808 group by v36;
create or replace view aggJoin6165415391966246085 as select v37, v21 from aggJoin956157959695153647 join aggView3373688765850076798 using(v36);
create or replace view aggView7273816295272254115 as select v21, v37, MIN(v37) as v49 from aggJoin6165415391966246085 group by v21,v37;
create or replace view aggView1723270883124404513 as select v21, v22 as v48 from semiDown7916378622945169213;
create or replace view aggJoin5729698087026620880 as select v49, v48 from aggView7273816295272254115 join aggView1723270883124404513 using(v21);
select MIN(v48) as v48, MIN(v49) as v49 from aggJoin5729698087026620880;

