create or replace view aggView2937287487892127357 as select id as v25 from company_name as cn where country_code= '[jp]';
create or replace view aggJoin5658616226030593225 as select movie_id as v11, note as v27 from movie_companies as mc, aggView2937287487892127357 where mc.company_id=aggView2937287487892127357.v25 and note NOT LIKE '%(USA)%' and note LIKE '%(Japan)%';
create or replace view aggView3631156278500441693 as select v11 from aggJoin5658616226030593225 group by v11;
create or replace view aggJoin6597934920485127913 as select person_id as v2, movie_id as v11, note as v13, role_id as v15 from cast_info as ci, aggView3631156278500441693 where ci.movie_id=aggView3631156278500441693.v11 and note= '(voice: English version)';
create or replace view aggView7883027264836678573 as select id as v15 from role_type as rt where role= 'actress';
create or replace view aggJoin926956864396794422 as select v2, v11, v13 from aggJoin6597934920485127913 join aggView7883027264836678573 using(v15);
create or replace view aggView7660009558939242848 as select v2, v11 from aggJoin926956864396794422 group by v2,v11;
create or replace view aggJoin5633578967371784999 as select id as v2, name as v29, v11 from name as n1, aggView7660009558939242848 where n1.id=aggView7660009558939242848.v2 and name LIKE '%Yo%' and name NOT LIKE '%Yu%';
create or replace view aggView3572823728311242989 as select v2, v11 from aggJoin5633578967371784999 group by v2,v11;
create or replace view aggJoin78940055142503526 as select name as v3, v11 from aka_name as an1, aggView3572823728311242989 where an1.person_id=aggView3572823728311242989.v2;
create or replace view aggView4900472282398346539 as select v11, MIN(v3) as v51 from aggJoin78940055142503526 group by v11;
create or replace view aggJoin4841114374523367920 as select id as v11, title as v40, v51 from title as t, aggView4900472282398346539 where t.id=aggView4900472282398346539.v11;
select MIN(v51) as v51,MIN(v40) as v52 from aggJoin4841114374523367920;
