create or replace view aggView6948746400826253844 as select id as v23, kind_id as v8, title as v36 from title as t where production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%'));
create or replace view aggJoin2993367326093380801 as select movie_id as v23, info_type_id as v1, info as v13, v8, v36 from movie_info as mi, aggView6948746400826253844 where mi.movie_id=aggView6948746400826253844.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7119053403863634531 as select id as v1 from info_type as it1 where info= 'countries';
create or replace view aggJoin6423345898436080871 as select v23, v13, v8, v36 from aggJoin2993367326093380801 join aggView7119053403863634531 using(v1);
create or replace view aggView7014512534488728249 as select v8, v23, MIN(v36) as v36 from aggJoin6423345898436080871 group by v8,v23;
create or replace view aggJoin6820930618937337847 as select id as v8, kind as v9, v23, v36 from kind_type as kt, aggView7014512534488728249 where kt.id=aggView7014512534488728249.v8 and kind= 'movie';
create or replace view aggView5257303388249356713 as select v23, MIN(v36) as v36 from aggJoin6820930618937337847 group by v23;
create or replace view aggJoin3913033282641902194 as select movie_id as v23, keyword_id as v5, v36 from movie_keyword as mk, aggView5257303388249356713 where mk.movie_id=aggView5257303388249356713.v23;
create or replace view aggView8599151895910887159 as select id as v5 from keyword as k where keyword IN ('murder','murder-in-title');
create or replace view aggJoin4037485875000241528 as select v23, v36 from aggJoin3913033282641902194 join aggView8599151895910887159 using(v5);
create or replace view aggView740318835299374659 as select v23, MIN(v36) as v36 from aggJoin4037485875000241528 group by v23;
create or replace view aggJoin7207903001463886944 as select movie_id as v23, info_type_id as v3, info as v18, v36 from movie_info_idx as mi_idx, aggView740318835299374659 where mi_idx.movie_id=aggView740318835299374659.v23 and info>'6.0';
create or replace view aggView3024815748669603727 as select id as v3 from info_type as it2 where info= 'rating';
create or replace view aggJoin7121084168303316508 as select v23, v18, v36 from aggJoin7207903001463886944 join aggView3024815748669603727 using(v3);
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin7121084168303316508;
