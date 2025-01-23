create or replace view lineitemwithyearAux62 as select l_orderkey as v25, l_year as v9, l_suppkey as v1 from lineitemwithyear where l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';
create or replace view n1Aux96 as select n_nationkey as v4, n_name as v43 from nation;
create or replace view n2Aux60 as select n_nationkey as v37, n_name as v47 from nation where n_name= 'GERMANY';
create or replace view semiUp7181368762537349970 as select s_suppkey as v1, s_nationkey as v4 from supplier AS supplier where (s_nationkey) in (select v4 from n1Aux96);
create or replace view semiUp4751249485629567895 as select v25, v9, v1 from lineitemwithyearAux62 where (v1) in (select v1 from semiUp7181368762537349970);
create or replace view semiUp1913494094112654675 as select c_custkey as v34, c_nationkey as v37 from customer AS customer where (c_nationkey) in (select v37 from n2Aux60);
create or replace view semiUp4755652959991637685 as select o_orderkey as v25, o_custkey as v34 from orders AS orders where (o_custkey) in (select v34 from semiUp1913494094112654675);
create or replace view semiUp8536075111572775510 as select v25, v9, v1 from semiUp4751249485629567895 where (v25) in (select v25 from semiUp4755652959991637685);
create or replace view semiDown211722181684598603 as select v1, v4 from semiUp7181368762537349970 where (v1) in (select v1 from semiUp8536075111572775510);
create or replace view semiDown9012211656107852762 as select v25, v34 from semiUp4755652959991637685 where (v25) in (select v25 from semiUp8536075111572775510);
create or replace view semiDown3348215934076954731 as select l_orderkey as v25, l_year as v9, l_suppkey as v1, l_extendedprice as v14, l_discount as v15 from lineitemwithyear AS lineitemwithyear where (l_year, l_suppkey, l_orderkey) in (select v9, v1, v25 from semiUp8536075111572775510) and l_shipdate>=DATE '1995-01-01' and l_shipdate<=DATE '1996-12-31';
create or replace view semiDown6471009459627550646 as select v4, v43 from n1Aux96 where (v4) in (select v4 from semiDown211722181684598603);
create or replace view semiDown8499923333675036313 as select v34, v37 from semiUp1913494094112654675 where (v34) in (select v34 from semiDown9012211656107852762);
create or replace view semiDown8549965622238925934 as select n_nationkey as v4, n_name as v43 from nation AS n1 where (n_name, n_nationkey) in (select v43, v4 from semiDown6471009459627550646);
create or replace view semiDown6712055784227978224 as select v37, v47 from n2Aux60 where (v37) in (select v37 from semiDown8499923333675036313);
create or replace view semiDown1044567596551435363 as select n_nationkey as v37, n_name as v47 from nation AS n2 where (n_nationkey, n_name) in (select v37, v47 from semiDown6712055784227978224) and n_name= 'GERMANY';
create or replace view aggView8995569052426487426 as select v37, v47 from semiDown1044567596551435363;
create or replace view aggView5706276214527695840 as select v43, v4 from semiDown8549965622238925934;
create or replace view aggView8862090973361543174 as select v9, v1, v25, SUM(v14 * (1 - v15)) as v51, COUNT(*) as annot from semiDown3348215934076954731 group by v9,v1,v25;
create or replace view aggView3036897822830232481 as select v37, v47, COUNT(*) as annot from aggView8995569052426487426 group by v37,v47;
create or replace view aggJoin2679602748609034993 as select v34, v47, annot from semiDown8499923333675036313 join aggView3036897822830232481 using(v37);
create or replace view aggView5209690778847611454 as select v34, v47, SUM(annot) as annot from aggJoin2679602748609034993 group by v34,v47;
create or replace view aggJoin7379289493025675906 as select v25, v47, annot from semiDown9012211656107852762 join aggView5209690778847611454 using(v34);
create or replace view aggView5794174472615947133 as select v4, v43, COUNT(*) as annot from aggView5706276214527695840 group by v4,v43;
create or replace view aggJoin7638195382653238155 as select v1, v43, annot from semiDown211722181684598603 join aggView5794174472615947133 using(v4);
create or replace view aggView7503411769639990003 as select v25, v47, SUM(annot) as annot from aggJoin7379289493025675906 group by v25,v47;
create or replace view aggJoin6281528284394716469 as select v9, v1, v51*aggView7503411769639990003.annot as v51, aggView8862090973361543174.annot * aggView7503411769639990003.annot as annot, v47 from aggView8862090973361543174 join aggView7503411769639990003 using(v25);
create or replace view aggView2205460116512649298 as select v1, v43, SUM(annot) as annot from aggJoin7638195382653238155 group by v1,v43;
create or replace view aggJoin5211117998084292615 as select v9, v51*aggView2205460116512649298.annot as v51, v47, v43 from aggJoin6281528284394716469 join aggView2205460116512649298 using(v1);
select v43, v47, v9, SUM(v51) as v51 from aggJoin5211117998084292615 group by v43, v47, v9;

