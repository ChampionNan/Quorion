create or replace view semiUp7639306474842805643 as select movie_id as v15, company_type_id as v1 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view semiUp7857492136778247645 as select movie_id as v15, info_type_id as v3 from movie_info AS mi where (info_type_id) in (select id from info_type AS it) and info IN ('USA','America');
create or replace view semiUp8791473899207818329 as select v15, v3 from semiUp7857492136778247645 where (v15) in (select v15 from semiUp7639306474842805643);
create or replace view semiUp3328911724506571300 as select id as v15, title as v16 from title AS t where (id) in (select v15 from semiUp8791473899207818329) and production_year>2010;
create or replace view tAux57 as select v16 from semiUp3328911724506571300;
create or replace view semiDown6353485372914178495 as select v15, v16 from semiUp3328911724506571300 where (v16) in (select v16 from tAux57);
create or replace view semiDown2619042670016100665 as select v15, v3 from semiUp8791473899207818329 where (v15) in (select v15 from semiDown6353485372914178495);
create or replace view semiDown6114028549702370953 as select id as v3 from info_type AS it where (id) in (select v3 from semiDown2619042670016100665);
create or replace view semiDown457746967784450098 as select v15, v1 from semiUp7639306474842805643 where (v15) in (select v15 from semiDown2619042670016100665);
create or replace view semiDown9128351329107945093 as select id as v1 from company_type AS ct where (id) in (select v1 from semiDown457746967784450098) and kind= 'production companies';
create or replace view aggView4913342042404501917 as select v1 from semiDown9128351329107945093;
create or replace view aggJoin8193510898002208026 as select v15 from semiDown457746967784450098 join aggView4913342042404501917 using(v1);
create or replace view aggView5611725035084149785 as select v3 from semiDown6114028549702370953;
create or replace view aggJoin2565491277887958413 as select v15 from semiDown2619042670016100665 join aggView5611725035084149785 using(v3);
create or replace view aggView2171069368244820007 as select v15 from aggJoin8193510898002208026 group by v15;
create or replace view aggJoin8727382842107602740 as select v15 from aggJoin2565491277887958413 join aggView2171069368244820007 using(v15);
create or replace view aggView4839490745719648299 as select v15 from aggJoin8727382842107602740 group by v15;
create or replace view aggJoin3905382268290250136 as select v16 from semiDown6353485372914178495 join aggView4839490745719648299 using(v15);
create or replace view aggView7300611062253540482 as select v16, MIN(v16) as v27 from aggJoin3905382268290250136 group by v16;
select MIN(v27) as v27 from aggView7300611062253540482;