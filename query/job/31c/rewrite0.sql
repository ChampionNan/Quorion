create or replace view aggView1576520048379688123 as select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital');
create or replace view aggJoin8237105313997491254 as select movie_id as v49 from movie_keyword as mk, aggView1576520048379688123 where mk.keyword_id=aggView1576520048379688123.v19;
create or replace view aggView1184711029123724896 as select v49 from aggJoin8237105313997491254 group by v49;
create or replace view aggJoin6281697313589113264 as select movie_id as v49, info_type_id as v17, info as v35 from movie_info_idx as mi_idx, aggView1184711029123724896 where mi_idx.movie_id=aggView1184711029123724896.v49;
create or replace view aggView3129575906000535672 as select id as v17 from info_type as it2 where info= 'votes';
create or replace view aggJoin6629336066873608009 as select v49, v35 from aggJoin6281697313589113264 join aggView3129575906000535672 using(v17);
create or replace view aggView6214277410602439467 as select v49, MIN(v35) as v62 from aggJoin6629336066873608009 group by v49;
create or replace view aggJoin8530855910178012545 as select id as v49, title as v50, v62 from title as t, aggView6214277410602439467 where t.id=aggView6214277410602439467.v49;
create or replace view aggView6208804087525496807 as select v49, MIN(v62) as v62, MIN(v50) as v64 from aggJoin8530855910178012545 group by v49;
create or replace view aggJoin2470105855574861133 as select movie_id as v49, company_id as v8, v62, v64 from movie_companies as mc, aggView6208804087525496807 where mc.movie_id=aggView6208804087525496807.v49;
create or replace view aggView400137482761913988 as select id as v8 from company_name as cn where name LIKE 'Lionsgate%';
create or replace view aggJoin5719491494520081434 as select v49, v62, v64 from aggJoin2470105855574861133 join aggView400137482761913988 using(v8);
create or replace view aggView7609345166225232021 as select v49, MIN(v62) as v62, MIN(v64) as v64 from aggJoin5719491494520081434 group by v49;
create or replace view aggJoin5228722010399600323 as select person_id as v40, movie_id as v49, note as v5, v62, v64 from cast_info as ci, aggView7609345166225232021 where ci.movie_id=aggView7609345166225232021.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)');
create or replace view aggView7853672584611787958 as select v49, v40, MIN(v62) as v62, MIN(v64) as v64 from aggJoin5228722010399600323 group by v49,v40;
create or replace view aggJoin225682600366639417 as select info_type_id as v15, info as v30, v40, v62, v64 from movie_info as mi, aggView7853672584611787958 where mi.movie_id=aggView7853672584611787958.v49 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War');
create or replace view aggView336243090001872946 as select id as v15 from info_type as it1 where info= 'genres';
create or replace view aggJoin8701418727746959299 as select v30, v40, v62, v64 from aggJoin225682600366639417 join aggView336243090001872946 using(v15);
create or replace view aggView6045494906163243885 as select v40, MIN(v62) as v62, MIN(v64) as v64, MIN(v30) as v61 from aggJoin8701418727746959299 group by v40;
create or replace view aggJoin6425602757927418517 as select id as v40, name as v41, v62, v64, v61 from name as n, aggView6045494906163243885 where n.id=aggView6045494906163243885.v40;
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin6425602757927418517;
