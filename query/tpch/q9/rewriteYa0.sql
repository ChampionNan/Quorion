create or replace view orderswithyearAux78 as select o_orderkey as v38, o_year as v39 from orderswithyear;
create or replace view nationAux1 as select n_nationkey as v13, n_name as v49 from nation;
create or replace view semiUp2756423775358099428 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp AS partsupp where (ps_partkey) in (select p_partkey from part AS part where p_name LIKE '%green%');
create or replace view semiUp7892173641984749292 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23 from lineitem AS lineitem where (l_suppkey, l_partkey) in (select v10, v33 from semiUp2756423775358099428);
create or replace view semiUp5505582083118758953 as select v38, v33, v10, v21, v22, v23 from semiUp7892173641984749292 where (v38) in (select v38 from orderswithyearAux78);
create or replace view semiUp6004623033031216467 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_suppkey) in (select v10 from semiUp5505582083118758953);
create or replace view semiUp8511750556987151228 as select v13, v49 from nationAux1 where (v13) in (select v13 from semiUp6004623033031216467);
create or replace view semiDown8960498820082724862 as select n_nationkey as v13, n_name as v49 from nation AS nation where (n_name, n_nationkey) in (select v49, v13 from semiUp8511750556987151228);
create or replace view semiDown5677159745192781492 as select v10, v13 from semiUp6004623033031216467 where (v13) in (select v13 from semiUp8511750556987151228);
create or replace view semiDown6867170809283532111 as select v38, v33, v10, v21, v22, v23 from semiUp5505582083118758953 where (v10) in (select v10 from semiDown5677159745192781492);
create or replace view semiDown5897215924516961915 as select v33, v10, v36 from semiUp2756423775358099428 where (v10, v33) in (select v10, v33 from semiDown6867170809283532111);
create or replace view semiDown168447418891436713 as select v38, v39 from orderswithyearAux78 where (v38) in (select v38 from semiDown6867170809283532111);
create or replace view semiDown3803844965522641758 as select p_partkey as v33 from part AS part where (p_partkey) in (select v33 from semiDown5897215924516961915) and p_name LIKE '%green%';
create or replace view semiDown3166207804239961864 as select o_orderkey as v38, o_year as v39 from orderswithyear AS orderswithyear where (o_orderkey, o_year) in (select v38, v39 from semiDown168447418891436713);
create or replace view aggView1355652982341190170 as select v38, v39 from semiDown3166207804239961864;
create or replace view aggView1158433186072850317 as select v49, v13 from semiDown8960498820082724862;
create or replace view aggView5481818373104388059 as select v33 from semiDown3803844965522641758;
create or replace view aggJoin3094811542991851037 as select v33, v10, v36 from semiDown5897215924516961915 join aggView5481818373104388059 using(v33);
create or replace view aggView8314276807608514389 as select v38, v39, COUNT(*) as annot from aggView1355652982341190170 group by v38,v39;
create or replace view aggJoin2415911217148044819 as select v33, v10, v21, v22, v23, v39, annot from semiDown6867170809283532111 join aggView8314276807608514389 using(v38);
create or replace view aggView291327217654170830 as select v10, v33, SUM(v36)/COUNT(*) as v36, COUNT(*) as annot from aggJoin3094811542991851037 group by v10,v33;
create or replace view aggJoin383521505739183862 as select v10, v21, v22, v23, v39, aggJoin2415911217148044819.annot * aggView291327217654170830.annot as annot, v36 from aggJoin2415911217148044819 join aggView291327217654170830 using(v10,v33);
create or replace view aggView5674068329829344945 as select v10, SUM((v22 * (1 - v23)) * annot) as v54, SUM((v36 * v21) * annot) as v55, v39, SUM(annot) as annot from aggJoin383521505739183862 group by v10,v39;
create or replace view aggJoin1260427234711919842 as select v13, v54, v55, v39, annot from semiDown5677159745192781492 join aggView5674068329829344945 using(v10);
create or replace view aggView7872126749620622927 as select v13, SUM(v54) as v54, SUM(v55) as v55, v39, SUM(annot) as annot from aggJoin1260427234711919842 group by v13,v54,v39,v55;
create or replace view aggJoin5331044573766729126 as select v49, v54, v55, v39 from aggView1158433186072850317 join aggView7872126749620622927 using(v13);
select v49, v39, SUM(v54) as v54, SUM(v55) as v55 from aggJoin5331044573766729126 group by v49, v39;

