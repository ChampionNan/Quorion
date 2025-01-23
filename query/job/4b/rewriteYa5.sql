create or replace view semiUp4860322153683992684 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiUp8128463790386750866 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it where info= 'rating') and info>'9.0';
create or replace view semiUp7423020141681848382 as select id as v14, title as v15 from title AS t where (id) in (select v14 from semiUp8128463790386750866) and production_year>2010;
create or replace view semiUp73311918836145359 as select v14, v3 from semiUp4860322153683992684 where (v14) in (select v14 from semiUp7423020141681848382);
create or replace view semiDown5304190791381415447 as select id as v3 from keyword AS k where (id) in (select v3 from semiUp73311918836145359) and keyword LIKE '%sequel%';
create or replace view semiDown3912301735496880993 as select v14, v15 from semiUp7423020141681848382 where (v14) in (select v14 from semiUp73311918836145359);
create or replace view semiDown6820937109119071884 as select v14, v1, v9 from semiUp8128463790386750866 where (v14) in (select v14 from semiDown3912301735496880993);
create or replace view semiDown217417688027318578 as select id as v1 from info_type AS it where (id) in (select v1 from semiDown6820937109119071884) and info= 'rating';
create or replace view aggView5551600790447702974 as select v1 from semiDown217417688027318578;
create or replace view aggJoin8630055680361106186 as select v14, v9 from semiDown6820937109119071884 join aggView5551600790447702974 using(v1);
create or replace view aggView1343508272347322143 as select v14, MIN(v9) as v26 from aggJoin8630055680361106186 group by v14;
create or replace view aggJoin8220948628260301929 as select v14, v15, v26 from semiDown3912301735496880993 join aggView1343508272347322143 using(v14);
create or replace view aggView5343377451853476204 as select v3 from semiDown5304190791381415447;
create or replace view aggJoin3888338145134657236 as select v14 from semiUp73311918836145359 join aggView5343377451853476204 using(v3);
create or replace view aggView1955906870003658195 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8220948628260301929 group by v14,v26;
create or replace view aggJoin6307579987813876796 as select v26, v27 from aggJoin3888338145134657236 join aggView1955906870003658195 using(v14);
select MIN(v26) as v26, MIN(v27) as v27 from aggJoin6307579987813876796;