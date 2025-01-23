create or replace view aggView7694736281080057698 as select id as v16 from info_type as it where info= 'mini biography';
create or replace view aggJoin8657342738401004158 as select person_id as v24, note as v37 from person_info as pi, aggView7694736281080057698 where pi.info_type_id=aggView7694736281080057698.v16 and note= 'Volker Boehm';
create or replace view aggView1260552594604982095 as select v24 from aggJoin8657342738401004158 group by v24;
create or replace view aggJoin5914019505803933769 as select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView1260552594604982095 where n.id=aggView1260552594604982095.v24 and gender= 'm' and name_pcode_cf LIKE 'D%';
create or replace view aggView3232773494244181876 as select v24, MIN(v25) as v50 from aggJoin5914019505803933769 group by v24;
create or replace view aggJoin8896637871296734859 as select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView3232773494244181876 where ci.person_id=aggView3232773494244181876.v24;
create or replace view aggView3008339591316114336 as select id as v18 from link_type as lt where link= 'features';
create or replace view aggJoin5330943922932591672 as select linked_movie_id as v38 from movie_link as ml, aggView3008339591316114336 where ml.link_type_id=aggView3008339591316114336.v18;
create or replace view aggView5355148595805687147 as select v38, v24, MIN(v50) as v50 from aggJoin8896637871296734859 group by v38,v24;
create or replace view aggJoin5559431317202309267 as select id as v38, title as v39, production_year as v42, v24, v50 from title as t, aggView5355148595805687147 where t.id=aggView5355148595805687147.v38 and production_year<=1984 and production_year>=1980;
create or replace view aggView6728206100948495358 as select v38 from aggJoin5330943922932591672 group by v38;
create or replace view aggJoin8537159552233437904 as select v39, v42, v24, v50 as v50 from aggJoin5559431317202309267 join aggView6728206100948495358 using(v38);
create or replace view aggView397598536599399961 as select v24, MIN(v50) as v50, MIN(v39) as v51 from aggJoin8537159552233437904 group by v24;
create or replace view aggJoin8175573815522041401 as select person_id as v24, name as v3, v50, v51 from aka_name as an, aggView397598536599399961 where an.person_id=aggView397598536599399961.v24 and name LIKE '%a%';
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin8175573815522041401;
