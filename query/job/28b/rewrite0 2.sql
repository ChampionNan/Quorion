create or replace view aggView112836247266433279 as select id as v20 from info_type as it2 where info= 'rating';
create or replace view aggJoin7505033369006833983 as select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView112836247266433279 where mi_idx.info_type_id=aggView112836247266433279.v20 and info>'6.5';
create or replace view aggView7451139692337523159 as select v45, MIN(v40) as v58 from aggJoin7505033369006833983 group by v45;
create or replace view aggJoin4990285261788730124 as select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView7451139692337523159 where t.id=aggView7451139692337523159.v45 and production_year>2005;
create or replace view aggView179591905940125271 as select id as v25 from kind_type as kt where kind IN ('movie','episode');
create or replace view aggJoin6838512475413422310 as select v45, v46, v49, v58 from aggJoin4990285261788730124 join aggView179591905940125271 using(v25);
create or replace view aggView932565109267957284 as select id as v5 from comp_cast_type as cct1 where kind= 'crew';
create or replace view aggJoin1733434567252167874 as select movie_id as v45, status_id as v7 from complete_cast as cc, aggView932565109267957284 where cc.subject_id=aggView932565109267957284.v5;
create or replace view aggView1995641815449316149 as select id as v16 from company_type as ct;
create or replace view aggJoin3742578707175314279 as select movie_id as v45, company_id as v9, note as v31 from movie_companies as mc, aggView1995641815449316149 where mc.company_type_id=aggView1995641815449316149.v16 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%';
create or replace view aggView351755957113513742 as select movie_id as v45, info_type_id as v18 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id,info_type_id;
create or replace view aggJoin3961404706592690317 as select v45, v46, v49, v58 as v58, v18 from aggJoin6838512475413422310 join aggView351755957113513742 using(v45);
create or replace view aggView5054220517678529469 as select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified';
create or replace view aggJoin1643034018562206850 as select v45 from aggJoin1733434567252167874 join aggView5054220517678529469 using(v7);
create or replace view aggView1618221163771955245 as select id as v9, name as v57 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8216162662025038240 as select v45, v31, v57 from aggJoin3742578707175314279 join aggView1618221163771955245 using(v9);
create or replace view aggView7600904964112367629 as select movie_id as v45, keyword_id as v22 from movie_keyword as mk group by movie_id,keyword_id;
create or replace view aggJoin4473704478691629488 as select v45, v46, v49, v58 as v58, v18, v22 from aggJoin3961404706592690317 join aggView7600904964112367629 using(v45);
create or replace view aggView2422397828708785089 as select v45, v18, v22, MIN(v58) as v58, MIN(v46) as v59 from aggJoin4473704478691629488 group by v45,v18,v22;
create or replace view aggJoin7732217521836239698 as select v45, v18, v22, v58, v59 from aggJoin1643034018562206850 join aggView2422397828708785089 using(v45);
create or replace view aggView7035982406095934427 as select v45, v18, v22, MIN(v58) as v58, MIN(v59) as v59 from aggJoin7732217521836239698 group by v45,v18,v22;
create or replace view aggJoin405041870783007599 as select v31, v57 as v57, v18, v22, v58, v59 from aggJoin8216162662025038240 join aggView7035982406095934427 using(v45);
create or replace view aggView3379053820422802777 as select v22, v18, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin405041870783007599 group by v22,v18;
create or replace view aggJoin7360234478483586850 as select id as v22, keyword as v23, v18, v57, v58, v59 from keyword as k, aggView3379053820422802777 where k.id=aggView3379053820422802777.v22 and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view aggView7294419106543754139 as select v18, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin7360234478483586850 group by v18;
create or replace view aggJoin3282152928367732452 as select id as v18, info as v19, v57, v58, v59 from info_type as it1, aggView7294419106543754139 where it1.id=aggView7294419106543754139.v18 and info= 'countries';
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3282152928367732452;
