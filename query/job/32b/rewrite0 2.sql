create or replace view aggView8066806548438841385 as select id as v8 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2947060844539723133 as select movie_id as v13 from movie_keyword as mk, aggView8066806548438841385 where mk.keyword_id=aggView8066806548438841385.v8;
create or replace view aggView3505609142251936896 as select v13 from aggJoin2947060844539723133 group by v13;
create or replace view aggJoin1815239835890721394 as select id as v13, title as v14 from title as t1, aggView3505609142251936896 where t1.id=aggView3505609142251936896.v13;
create or replace view aggView8737672718720741734 as select v13, MIN(v14) as v38 from aggJoin1815239835890721394 group by v13;
create or replace view aggJoin7808941296698066951 as select linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView8737672718720741734 where ml.movie_id=aggView8737672718720741734.v13;
create or replace view aggView3697706422618931742 as select v11, v4, MIN(v38) as v38 from aggJoin7808941296698066951 group by v11,v4;
create or replace view aggJoin6014081730046722920 as select title as v26, v4, v38 from title as t2, aggView3697706422618931742 where t2.id=aggView3697706422618931742.v11;
create or replace view aggView3662685783107149408 as select v4, MIN(v38) as v38, MIN(v26) as v39 from aggJoin6014081730046722920 group by v4;
create or replace view aggJoin8514611407167771772 as select id as v4, link as v5, v38, v39 from link_type as lt, aggView3662685783107149408 where lt.id=aggView3662685783107149408.v4;
select MIN(v5) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin8514611407167771772;
