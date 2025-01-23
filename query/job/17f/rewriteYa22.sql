create or replace view semiUp487290509817476381 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select id from company_name AS cn);
create or replace view semiUp6088130918608223187 as select v3, v20 from semiUp487290509817476381 where (v3) in (select id from title AS t);
create or replace view semiUp6241103850340746288 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiUp2365427704630765439 as select v3, v20 from semiUp6088130918608223187 where (v3) in (select v3 from semiUp6241103850340746288);
create or replace view semiUp6614780090240716945 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select v3 from semiUp2365427704630765439);
create or replace view semiUp1020831618245715925 as select id as v26, name as v27 from name AS n where (id) in (select v26 from semiUp6614780090240716945);
create or replace view nAux95 as select v27 from semiUp1020831618245715925;
create or replace view semiDown569583875044607003 as select v26, v27 from semiUp1020831618245715925 where (v27) in (select v27 from nAux95);
create or replace view semiDown6357257132612545782 as select v26, v3 from semiUp6614780090240716945 where (v26) in (select v26 from semiDown569583875044607003);
create or replace view semiDown7299996027694213379 as select v3, v20 from semiUp2365427704630765439 where (v3) in (select v3 from semiDown6357257132612545782);
create or replace view semiDown1211088163700630808 as select id as v20 from company_name AS cn where (id) in (select v20 from semiDown7299996027694213379);
create or replace view semiDown7060573329329167125 as select id as v3 from title AS t where (id) in (select v3 from semiDown7299996027694213379);
create or replace view semiDown1867727813366145133 as select v3, v25 from semiUp6241103850340746288 where (v3) in (select v3 from semiDown7299996027694213379);
create or replace view semiDown1796412065578227335 as select id as v25 from keyword AS k where (id) in (select v25 from semiDown1867727813366145133) and keyword= 'character-name-in-title';
create or replace view aggView5153512293132635118 as select v25 from semiDown1796412065578227335;
create or replace view aggJoin5094528519412401876 as select v3 from semiDown1867727813366145133 join aggView5153512293132635118 using(v25);
create or replace view aggView6839099762194092033 as select v3 from semiDown7060573329329167125;
create or replace view aggJoin8178910781224580369 as select v3, v20 from semiDown7299996027694213379 join aggView6839099762194092033 using(v3);
create or replace view aggView6848072453701748765 as select v20 from semiDown1211088163700630808;
create or replace view aggJoin7182403915358540649 as select v3 from aggJoin8178910781224580369 join aggView6848072453701748765 using(v20);
create or replace view aggView1359936432426711255 as select v3 from aggJoin5094528519412401876 group by v3;
create or replace view aggJoin216251945373023648 as select v3 from aggJoin7182403915358540649 join aggView1359936432426711255 using(v3);
create or replace view aggView4649865493947431144 as select v3 from aggJoin216251945373023648 group by v3;
create or replace view aggJoin2356043491128888015 as select v26 from semiDown6357257132612545782 join aggView4649865493947431144 using(v3);
create or replace view aggView4311300487247789271 as select v26 from aggJoin2356043491128888015 group by v26;
create or replace view aggJoin549459357888905972 as select v27 from semiDown569583875044607003 join aggView4311300487247789271 using(v26);
create or replace view aggView3800830101171169118 as select v27, MIN(v27) as v47 from aggJoin549459357888905972 group by v27;
select MIN(v47) as v47 from aggView3800830101171169118;

