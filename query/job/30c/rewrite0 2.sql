create or replace view aggView6993857343622719179 as select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital');
create or replace view aggJoin4385999860335623149 as select movie_id as v45 from movie_keyword as mk, aggView6993857343622719179 where mk.keyword_id=aggView6993857343622719179.v20;
create or replace view aggView8665620962646438747 as select v45 from aggJoin4385999860335623149 group by v45;
create or replace view aggJoin2601279877253416638 as select id as v45, title as v46 from title as t, aggView8665620962646438747 where t.id=aggView8665620962646438747.v45;
create or replace view aggView4178775328502155775 as select v45, MIN(v46) as v60 from aggJoin2601279877253416638 group by v45;
create or replace view aggJoin8439406076808615528 as select movie_id as v45, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView4178775328502155775 where cc.movie_id=aggView4178775328502155775.v45;
create or replace view aggView288827130926030597 as select id as v5 from comp_cast_type as cct1 where kind= 'cast';
create or replace view aggJoin6305719911150890903 as select v45, v7, v60 from aggJoin8439406076808615528 join aggView288827130926030597 using(v5);
create or replace view aggView3281832337870362551 as select v45, v7, MIN(v60) as v60 from aggJoin6305719911150890903 group by v45,v7;
create or replace view aggJoin3465484442286080145 as select movie_id as v45, info_type_id as v16, info as v26, v7, v60 from movie_info as mi, aggView3281832337870362551 where mi.movie_id=aggView3281832337870362551.v45 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War');
create or replace view aggView6721764234491352772 as select v16, v7, v45, MIN(v60) as v60, MIN(v26) as v57 from aggJoin3465484442286080145 group by v16,v7,v45;
create or replace view aggJoin2206726432583890301 as select info as v17, v7, v45, v60, v57 from info_type as it1, aggView6721764234491352772 where it1.id=aggView6721764234491352772.v16 and info= 'genres';
create or replace view aggView99461867092094730 as select v7, v45, MIN(v60) as v60, MIN(v57) as v57 from aggJoin2206726432583890301 group by v7,v45;
create or replace view aggJoin7674964433286680004 as select id as v7, kind as v8, v45, v60, v57 from comp_cast_type as cct2, aggView99461867092094730 where cct2.id=aggView99461867092094730.v7 and kind= 'complete+verified';
create or replace view aggView7776284219927548531 as select v45, MIN(v60) as v60, MIN(v57) as v57 from aggJoin7674964433286680004 group by v45;
create or replace view aggJoin854649482774419294 as select movie_id as v45, info_type_id as v18, info as v31, v60, v57 from movie_info_idx as mi_idx, aggView7776284219927548531 where mi_idx.movie_id=aggView7776284219927548531.v45;
create or replace view aggView2789665700587119265 as select v45, v18, MIN(v60) as v60, MIN(v57) as v57, MIN(v31) as v58 from aggJoin854649482774419294 group by v45,v18;
create or replace view aggJoin4907308011613058406 as select person_id as v36, movie_id as v45, note as v13, v18, v60, v57, v58 from cast_info as ci, aggView2789665700587119265 where ci.movie_id=aggView2789665700587119265.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)');
create or replace view aggView2641339644059171358 as select v36, v18, MIN(v60) as v60, MIN(v57) as v57, MIN(v58) as v58 from aggJoin4907308011613058406 group by v36,v18;
create or replace view aggJoin707111466105195491 as select name as v37, gender as v40, v18, v60, v57, v58 from name as n, aggView2641339644059171358 where n.id=aggView2641339644059171358.v36 and gender= 'm';
create or replace view aggView3617384127333544438 as select v18, MIN(v60) as v60, MIN(v57) as v57, MIN(v58) as v58, MIN(v37) as v59 from aggJoin707111466105195491 group by v18;
create or replace view aggJoin2420536955631674406 as select id as v18, info as v19, v60, v57, v58, v59 from info_type as it2, aggView3617384127333544438 where it2.id=aggView3617384127333544438.v18 and info= 'votes';
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin2420536955631674406;
