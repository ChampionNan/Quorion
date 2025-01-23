create or replace view semiUp5741060857250998332 as select ps_partkey as v33, ps_suppkey as v10, ps_supplycost as v36 from partsupp AS partsupp where (ps_partkey) in (select p_partkey from part AS part where p_name LIKE '%green%');
create or replace view semiUp5997670217411687634 as select s_suppkey as v10, s_nationkey as v13 from supplier AS supplier where (s_nationkey) in (select n_nationkey from nation AS nation);
create or replace view semiUp8916160455592631244 as select v33, v10, v36 from semiUp5741060857250998332 where (v10) in (select v10 from semiUp5997670217411687634);
create or replace view semiUp3111543507464604775 as select l_orderkey as v38, l_partkey as v33, l_suppkey as v10, l_quantity as v21, l_extendedprice as v22, l_discount as v23 from lineitem AS lineitem where (l_orderkey) in (select o_orderkey from orderswithyear AS orderswithyear);
create or replace view semiUp6638655455948574876 as select v38, v33, v10, v21, v22, v23 from semiUp3111543507464604775 where (v10, v33) in (select v10, v33 from semiUp8916160455592631244);
create or replace view semiDown8608257345939893341 as select v33, v10, v36 from semiUp8916160455592631244 where (v10, v33) in (select v10, v33 from semiUp6638655455948574876);
create or replace view semiDown1930215696858001569 as select o_orderkey as v38, o_year as v39 from orderswithyear AS orderswithyear where (o_orderkey) in (select v38 from semiUp6638655455948574876);
create or replace view semiDown2893378940119554499 as select v10, v13 from semiUp5997670217411687634 where (v10) in (select v10 from semiDown8608257345939893341);
create or replace view semiDown4180717183694196017 as select p_partkey as v33 from part AS part where (p_partkey) in (select v33 from semiDown8608257345939893341) and p_name LIKE '%green%';
create or replace view semiDown1023640971420089081 as select n_nationkey as v13, n_name as v49 from nation AS nation where (n_nationkey) in (select v13 from semiDown2893378940119554499);
create or replace view aggView5450515032532610866 as select v13, v49 from semiDown1023640971420089081;
create or replace view aggJoin7621322179112335143 as select v10, v49 from semiDown2893378940119554499 join aggView5450515032532610866 using(v13);
create or replace view aggView527992605347660464 as select v33 from semiDown4180717183694196017;
create or replace view aggJoin2097515474053167972 as select v33, v10, v36 from semiDown8608257345939893341 join aggView527992605347660464 using(v33);
create or replace view aggView7903529085669534872 as select v10, v49, COUNT(*) as annot from aggJoin7621322179112335143 group by v10,v49;
create or replace view aggJoin8053420548866157843 as select v33, v10, v36, v49, annot from aggJoin2097515474053167972 join aggView7903529085669534872 using(v10);
create or replace view aggView7256801967806303997 as select v38, v39 from semiDown1930215696858001569;
create or replace view aggJoin538789899676991579 as select v33, v10, v21, v22, v23, v39 from semiUp6638655455948574876 join aggView7256801967806303997 using(v38);
create or replace view aggView2616102916276057990 as select v10, v33, SUM(v36)/COUNT(*) as v36, v49, SUM(annot) as annot from aggJoin8053420548866157843 group by v10,v33,v49;
create or replace view aggJoin1257577299225633595 as select v21, v22, v23, v39, v36, v49, annot from aggJoin538789899676991579 join aggView2616102916276057990 using(v10,v33);
select v49, v39, SUM((v22 * (1 - v23))*annot) as v54, SUM((v36 * v21)*annot) as v55 from aggJoin1257577299225633595 group by v49, v39;
