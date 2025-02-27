create or replace view semiUp6789840157452208560 as select movie_id as v23, info_type_id as v1 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'countries') and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view semiUp4558521823481696038 as select id as v23, title as v24, kind_id as v8 from title AS t where (kind_id) in (select id from kind_type AS kt where kind IN ('movie','episode')) and production_year>2005;
create or replace view semiUp5994054933035107269 as select movie_id as v23, info_type_id as v3, info as v18 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info<'8.5';
create or replace view semiUp5554560695703090877 as select movie_id as v23, keyword_id as v5 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('murder','murder-in-title','blood','violence'));
create or replace view semiUp1259474532591212387 as select v23, v1 from semiUp6789840157452208560 where (v23) in (select v23 from semiUp5994054933035107269);
create or replace view semiUp8312427403623388655 as select v23, v24, v8 from semiUp4558521823481696038 where (v23) in (select v23 from semiUp1259474532591212387);
create or replace view semiUp1043953038334573051 as select v23, v5 from semiUp5554560695703090877 where (v23) in (select v23 from semiUp8312427403623388655);
create or replace view semiDown3613135916992752612 as select id as v5 from keyword AS k where (id) in (select v5 from semiUp1043953038334573051) and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view semiDown2120959966945777245 as select v23, v24, v8 from semiUp8312427403623388655 where (v23) in (select v23 from semiUp1043953038334573051);
create or replace view semiDown3716037274969223646 as select id as v8 from kind_type AS kt where (id) in (select v8 from semiDown2120959966945777245) and kind IN ('movie','episode');
create or replace view semiDown5102197304071149876 as select v23, v1 from semiUp1259474532591212387 where (v23) in (select v23 from semiDown2120959966945777245);
create or replace view semiDown3459054515749835870 as select id as v1 from info_type AS it1 where (id) in (select v1 from semiDown5102197304071149876) and info= 'countries';
create or replace view semiDown4448737225197551034 as select v23, v3, v18 from semiUp5994054933035107269 where (v23) in (select v23 from semiDown5102197304071149876);
create or replace view semiDown327674750935939938 as select id as v3 from info_type AS it2 where (id) in (select v3 from semiDown4448737225197551034) and info= 'rating';
create or replace view aggView1405858957793921171 as select v3 from semiDown327674750935939938;
create or replace view aggJoin1236497065361604930 as select v23, v18 from semiDown4448737225197551034 join aggView1405858957793921171 using(v3);
create or replace view aggView7560950770678427694 as select v23, MIN(v18) as v35 from aggJoin1236497065361604930 group by v23;
create or replace view aggJoin9194508272303252447 as select v23, v1, v35 from semiDown5102197304071149876 join aggView7560950770678427694 using(v23);
create or replace view aggView5104949808309806700 as select v1 from semiDown3459054515749835870;
create or replace view aggJoin7245520422176373269 as select v23, v35 from aggJoin9194508272303252447 join aggView5104949808309806700 using(v1);
create or replace view aggView2543963662968859494 as select v23, MIN(v35) as v35 from aggJoin7245520422176373269 group by v23,v35;
create or replace view aggJoin9034877380863202952 as select v23, v24, v8, v35 from semiDown2120959966945777245 join aggView2543963662968859494 using(v23);
create or replace view aggView2589285544961736197 as select v8 from semiDown3716037274969223646;
create or replace view aggJoin6403390707284781559 as select v23, v24, v35 from aggJoin9034877380863202952 join aggView2589285544961736197 using(v8);
create or replace view aggView7829359173224555443 as select v5 from semiDown3613135916992752612;
create or replace view aggJoin7195870533471200123 as select v23 from semiUp1043953038334573051 join aggView7829359173224555443 using(v5);
create or replace view aggView1869494283949790730 as select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin6403390707284781559 group by v23,v35;
create or replace view aggJoin3634646279115210556 as select v35, v36 from aggJoin7195870533471200123 join aggView1869494283949790730 using(v23);
select MIN(v35) as v35, MIN(v36) as v36 from aggJoin3634646279115210556;

