create or replace view semiUp1808664514988597181 as select movie_id as v12, company_id as v1 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[nl]');
create or replace view semiUp7312390030520184108 as select movie_id as v12, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiUp3915574383489413247 as select v12, v1 from semiUp1808664514988597181 where (v12) in (select v12 from semiUp7312390030520184108);
create or replace view semiUp2406184556805971206 as select id as v12, title as v20 from title AS t where (id) in (select v12 from semiUp3915574383489413247);
create or replace view tAux57 as select v20 from semiUp2406184556805971206;
create or replace view semiDown5874758935135991463 as select v12, v20 from semiUp2406184556805971206 where (v20) in (select v20 from tAux57);
create or replace view semiDown327320913870857946 as select v12, v1 from semiUp3915574383489413247 where (v12) in (select v12 from semiDown5874758935135991463);
create or replace view semiDown9000015284227857000 as select id as v1 from company_name AS cn where (id) in (select v1 from semiDown327320913870857946) and country_code= '[nl]';
create or replace view semiDown4612422821090426843 as select v12, v18 from semiUp7312390030520184108 where (v12) in (select v12 from semiDown327320913870857946);
create or replace view semiDown2116588283381640076 as select id as v18 from keyword AS k where (id) in (select v18 from semiDown4612422821090426843) and keyword= 'character-name-in-title';
create or replace view aggView7028936095183587593 as select v18 from semiDown2116588283381640076;
create or replace view aggJoin7263143754049362846 as select v12 from semiDown4612422821090426843 join aggView7028936095183587593 using(v18);
create or replace view aggView320713891395715925 as select v12 from aggJoin7263143754049362846 group by v12;
create or replace view aggJoin995598631190877357 as select v12, v1 from semiDown327320913870857946 join aggView320713891395715925 using(v12);
create or replace view aggView4894525576745643323 as select v1 from semiDown9000015284227857000;
create or replace view aggJoin7563491505696033139 as select v12 from aggJoin995598631190877357 join aggView4894525576745643323 using(v1);
create or replace view aggView3993515500204085372 as select v12 from aggJoin7563491505696033139 group by v12;
create or replace view aggJoin6573782298669303918 as select v20 from semiDown5874758935135991463 join aggView3993515500204085372 using(v12);
create or replace view aggView4266475311202610849 as select v20, MIN(v20) as v31 from aggJoin6573782298669303918 group by v20;
select MIN(v31) as v31 from aggView4266475311202610849;
