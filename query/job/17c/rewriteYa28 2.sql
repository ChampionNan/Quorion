create or replace view semiUp760702096451242841 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiUp3879051919613970473 as select person_id as v26, movie_id as v3 from cast_info AS ci where (person_id) in (select id from name AS n where name LIKE 'X%');
create or replace view semiUp2729279054113158437 as select v26, v3 from semiUp3879051919613970473 where (v3) in (select id from title AS t);
create or replace view semiUp7251284930909504947 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select id from company_name AS cn);
create or replace view semiUp3131493859975415172 as select v3, v25 from semiUp760702096451242841 where (v3) in (select v3 from semiUp7251284930909504947);
create or replace view semiUp8570604550765706886 as select v26, v3 from semiUp2729279054113158437 where (v3) in (select v3 from semiUp3131493859975415172);
create or replace view semiDown9014526513309600252 as select id as v26, name as v27 from name AS n where (id) in (select v26 from semiUp8570604550765706886) and name LIKE 'X%';
create or replace view semiDown272761247539478211 as select id as v3 from title AS t where (id) in (select v3 from semiUp8570604550765706886);
create or replace view semiDown4143563824297238056 as select v3, v25 from semiUp3131493859975415172 where (v3) in (select v3 from semiUp8570604550765706886);
create or replace view semiDown3597691070400140801 as select id as v25 from keyword AS k where (id) in (select v25 from semiDown4143563824297238056) and keyword= 'character-name-in-title';
create or replace view semiDown7545718752105685836 as select v3, v20 from semiUp7251284930909504947 where (v3) in (select v3 from semiDown4143563824297238056);
create or replace view semiDown8654511140094973870 as select id as v20 from company_name AS cn where (id) in (select v20 from semiDown7545718752105685836);
create or replace view aggView964517013092668938 as select v20 from semiDown8654511140094973870;
create or replace view aggJoin5718589149890844111 as select v3 from semiDown7545718752105685836 join aggView964517013092668938 using(v20);
create or replace view aggView2778356309485275806 as select v3 from aggJoin5718589149890844111 group by v3;
create or replace view aggJoin8993782141575310406 as select v3, v25 from semiDown4143563824297238056 join aggView2778356309485275806 using(v3);
create or replace view aggView7679379621266434799 as select v25 from semiDown3597691070400140801;
create or replace view aggJoin8344227237960714088 as select v3 from aggJoin8993782141575310406 join aggView7679379621266434799 using(v25);
create or replace view aggView8283059930915976362 as select v26, v27 as v47 from semiDown9014526513309600252;
create or replace view aggJoin1096233994534127806 as select v3, v47 from semiUp8570604550765706886 join aggView8283059930915976362 using(v26);
create or replace view aggView9080610393723325676 as select v3 from semiDown272761247539478211;
create or replace view aggJoin7097473717771791640 as select v3, v47 from aggJoin1096233994534127806 join aggView9080610393723325676 using(v3);
create or replace view aggView668652244483484414 as select v3 from aggJoin8344227237960714088 group by v3;
create or replace view aggJoin5637191499030768039 as select v47 as v47 from aggJoin7097473717771791640 join aggView668652244483484414 using(v3);
select MIN(v47) as v47 from aggJoin5637191499030768039;

