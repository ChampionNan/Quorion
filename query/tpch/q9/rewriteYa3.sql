create or replace view nationAux5 as select n_nationkey as v13, n_name as v49 from nation;
create or replace view orderswithyearAux39 as select o_orderkey as v38, o_year as v39 from orderswithyear;
create or replace view semiUp8824977335077185637 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23 from lineitem AS lineitem where (l_suppkey, l_partkey) in (select ps_suppkey, ps_partkey from partsupp AS partsupp);
create or replace view semiUp5831114635965426311 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select v13 from nationAux5);
create or replace view semiUp7100781167402295340 as select v38, v33, v10, v21, v22, v23 from semiUp8824977335077185637 where (v33) in (select p_partkey from part AS part where p_name LIKE '%green%');
create or replace view semiUp6025154737907734036 as select v38, v33, v10, v21, v22, v23 from semiUp7100781167402295340 where (v10) in (select v10 from semiUp5831114635965426311);
create or replace view semiUp1496103191968508912 as select v38, v39 from orderswithyearAux39 where (v38) in (select v38 from semiUp6025154737907734036);
create or replace view semiDown1920134973515125174 as select o_orderkey as v38, o_year as v39 from orderswithyear AS orderswithyear where (o_orderkey, o_year) in (select v38, v39 from semiUp1496103191968508912);
create or replace view semiDown8553079585969985184 as select v38, v33, v10, v21, v22, v23 from semiUp6025154737907734036 where (v38) in (select v38 from semiUp1496103191968508912);
create or replace view semiDown8265227391025456878 as select v10, v13 from semiUp5831114635965426311 where (v10) in (select v10 from semiDown8553079585969985184);
create or replace view semiDown1623738541125993617 as select p_partkey as v33 from part AS part where (p_partkey) in (select v33 from semiDown8553079585969985184) and p_name LIKE '%green%';
create or replace view semiDown3723836300598323059 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp AS partsupp where (ps_suppkey, ps_partkey) in (select v10, v33 from semiDown8553079585969985184);
create or replace view semiDown1836578219437832144 as select v13, v49 from nationAux5 where (v13) in (select v13 from semiDown8265227391025456878);
create or replace view semiDown3629767600519018673 as select n_nationkey as v13, n_name as v49 from nation AS nation where (n_name, n_nationkey) in (select v49, v13 from semiDown1836578219437832144);
create or replace view aggView6881138366798507618 as select v49, v13 from semiDown3629767600519018673;
create or replace view aggView4301901032983466692 as select v38, v39 from semiDown1920134973515125174;
create or replace view aggView2544192500574034636 as select v13, v49, COUNT(*) as annot from aggView6881138366798507618 group by v13,v49;
create or replace view aggJoin4796476467601707387 as select v10, v49, annot from semiDown8265227391025456878 join aggView2544192500574034636 using(v13);
create or replace view aggView9156165855845983778 as select v10, v49, SUM(annot) as annot from aggJoin4796476467601707387 group by v10,v49;
create or replace view aggJoin5106884933497867281 as select v38, v33, v10, v21, v22, v23, v49, annot from semiDown8553079585969985184 join aggView9156165855845983778 using(v10);
create or replace view aggView5307119601441824579 as select v33 from semiDown1623738541125993617;
create or replace view aggJoin157887215054211798 as select v38, v33, v10, v21, v22, v23, v49, annot from aggJoin5106884933497867281 join aggView5307119601441824579 using(v33);
create or replace view aggView3034511677250135999 as select v10, v33, v36 from semiDown3723836300598323059;
create or replace view aggJoin8020265826255879511 as select v38, v21, v22, v23, v49, annot, v36 from aggJoin157887215054211798 join aggView3034511677250135999 using(v10,v33);
create or replace view aggView8620376287372876664 as select v38, SUM((v22 * (1 - v23)) * annot) as v54, SUM((v36 * v21) * annot) as v55, v49, SUM(annot) as annot from aggJoin8020265826255879511 group by v38,v49;
create or replace view aggJoin9131407866044248935 as select v39, v54, v55, v49 from aggView4301901032983466692 join aggView8620376287372876664 using(v38);
select v49, v39, SUM(v54) as v54, SUM(v55) as v55 from aggJoin9131407866044248935 group by v49, v39;

