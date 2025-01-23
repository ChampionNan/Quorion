create or replace view semiUp8490118574589797962 as select movie_id as v11, keyword_id as v33 from movie_keyword AS mk where (movie_id) in (select id from title AS t where episode_nr>=5 and episode_nr<100);
create or replace view semiUp2626468398341248013 as select v11, v33 from semiUp8490118574589797962 where (v33) in (select id from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiUp135985138955661448 as select id as v2 from name AS n where (id) in (select person_id from aka_name AS an);
create or replace view semiUp6597341116434976742 as select movie_id as v11, company_id as v28 from movie_companies AS mc where (company_id) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp200142932843350728 as select person_id as v2, movie_id as v11 from cast_info AS ci where (person_id) in (select v2 from semiUp135985138955661448);
create or replace view semiUp8036943148984753963 as select v11, v28 from semiUp6597341116434976742 where (v11) in (select v11 from semiUp2626468398341248013);
create or replace view semiUp4224274644814730585 as select v2, v11 from semiUp200142932843350728 where (v11) in (select v11 from semiUp8036943148984753963);
create or replace view semiDown8473709625289059804 as select v11, v28 from semiUp8036943148984753963 where (v11) in (select v11 from semiUp4224274644814730585);
create or replace view semiDown3832579435469203923 as select v2 from semiUp135985138955661448 where (v2) in (select v2 from semiUp4224274644814730585);
create or replace view semiDown5541764192421353924 as select id as v28 from company_name AS cn where (id) in (select v28 from semiDown8473709625289059804) and country_code= '[us]';
create or replace view semiDown4460892126539784398 as select v11, v33 from semiUp2626468398341248013 where (v11) in (select v11 from semiDown8473709625289059804);
create or replace view semiDown8876296950418408731 as select person_id as v2, name as v3 from aka_name AS an where (person_id) in (select v2 from semiDown3832579435469203923);
create or replace view semiDown4322865807396806542 as select id as v33 from keyword AS k where (id) in (select v33 from semiDown4460892126539784398) and keyword= 'character-name-in-title';
create or replace view semiDown3900049472852425606 as select id as v11, title as v44 from title AS t where (id) in (select v11 from semiDown4460892126539784398) and episode_nr>=5 and episode_nr<100;
create or replace view aggView5001653934270048496 as select v11, v44 as v56 from semiDown3900049472852425606;
create or replace view aggJoin3235980033027012811 as select v11, v33, v56 from semiDown4460892126539784398 join aggView5001653934270048496 using(v11);
create or replace view aggView8349948102581444026 as select v33 from semiDown4322865807396806542;
create or replace view aggJoin2007389034268855632 as select v11, v56 from aggJoin3235980033027012811 join aggView8349948102581444026 using(v33);
create or replace view aggView4650661404961436430 as select v11, MIN(v56) as v56 from aggJoin2007389034268855632 group by v11,v56;
create or replace view aggJoin7723830796804614040 as select v11, v28, v56 from semiDown8473709625289059804 join aggView4650661404961436430 using(v11);
create or replace view aggView3391750776124344518 as select v2, MIN(v3) as v55 from semiDown8876296950418408731 group by v2;
create or replace view aggJoin2395998068647892590 as select v2, v55 from semiDown3832579435469203923 join aggView3391750776124344518 using(v2);
create or replace view aggView4839150859440491401 as select v28 from semiDown5541764192421353924;
create or replace view aggJoin9042057004866712787 as select v11, v56 from aggJoin7723830796804614040 join aggView4839150859440491401 using(v28);
create or replace view aggView2973429793098894028 as select v11, MIN(v56) as v56 from aggJoin9042057004866712787 group by v11,v56;
create or replace view aggJoin6236251659289923777 as select v2, v56 from semiUp4224274644814730585 join aggView2973429793098894028 using(v11);
create or replace view aggView2717029099172887625 as select v2, MIN(v55) as v55 from aggJoin2395998068647892590 group by v2,v55;
create or replace view aggJoin137170808491310490 as select v56 as v56, v55 from aggJoin6236251659289923777 join aggView2717029099172887625 using(v2);
select MIN(v55) as v55, MIN(v56) as v56 from aggJoin137170808491310490;

