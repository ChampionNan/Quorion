create or replace view semiUp8092208007415094732 as select movie_id as v15, info_type_id as v3 from movie_info AS mi where (info_type_id) in (select id from info_type AS it) and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view semiUp652819751862500364 as select movie_id as v15, company_type_id as v1 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct where kind= 'production companies') and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view semiUp4458581764855515765 as select v15, v1 from semiUp652819751862500364 where (v15) in (select v15 from semiUp8092208007415094732);
create or replace view semiUp2831875158430011 as select id as v15, title as v16 from title AS t where (id) in (select v15 from semiUp4458581764855515765) and production_year>2005;
create or replace view tAux82 as select v16 from semiUp2831875158430011;
create or replace view semiDown3213154449692583764 as select v15, v16 from semiUp2831875158430011 where (v16) in (select v16 from tAux82);
create or replace view semiDown2225530173315211899 as select v15, v1 from semiUp4458581764855515765 where (v15) in (select v15 from semiDown3213154449692583764);
create or replace view semiDown4889004202600746247 as select id as v1 from company_type AS ct where (id) in (select v1 from semiDown2225530173315211899) and kind= 'production companies';
create or replace view semiDown8350891242708453521 as select v15, v3 from semiUp8092208007415094732 where (v15) in (select v15 from semiDown2225530173315211899);
create or replace view semiDown1640933096883352640 as select id as v3 from info_type AS it where (id) in (select v3 from semiDown8350891242708453521);
create or replace view aggView1615919466447758546 as select v3 from semiDown1640933096883352640;
create or replace view aggJoin7194068977705631115 as select v15 from semiDown8350891242708453521 join aggView1615919466447758546 using(v3);
create or replace view aggView8734723294698712008 as select v1 from semiDown4889004202600746247;
create or replace view aggJoin6501617522060388591 as select v15 from semiDown2225530173315211899 join aggView8734723294698712008 using(v1);
create or replace view aggView7580922082157090609 as select v15 from aggJoin7194068977705631115 group by v15;
create or replace view aggJoin115839726723917520 as select v15 from aggJoin6501617522060388591 join aggView7580922082157090609 using(v15);
create or replace view aggView7600719097962904802 as select v15 from aggJoin115839726723917520 group by v15;
create or replace view aggJoin6327069797452323562 as select v16 from semiDown3213154449692583764 join aggView7600719097962904802 using(v15);
create or replace view aggView5041595387568701060 as select v16, MIN(v16) as v27 from aggJoin6327069797452323562 group by v16;
select MIN(v27) as v27 from aggView5041595387568701060;
