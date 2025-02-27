create or replace view aggView8912447183208614737 as select r_regionkey as v53 from region as region where r_name= 'AMERICA';
create or replace view aggJoin7467822253787403056 as select n_nationkey as v46 from nation as n1, aggView8912447183208614737 where n1.n_regionkey=aggView8912447183208614737.v53;
create or replace view aggView6897101543687826927 as select v46, COUNT(*) as annot from aggJoin7467822253787403056 group by v46;
create or replace view aggJoin5852003262569352003 as select c_custkey as v35, annot from customer as customer, aggView6897101543687826927 where customer.c_nationkey=aggView6897101543687826927.v46;
create or replace view aggView4758205160998701335 as select n_nationkey as v13, CASE WHEN n_name = 'BRAZIL' THEN 1 ELSE 0 END as caseCond from nation as n2;
create or replace view aggJoin5533274877281940124 as select s_suppkey as v10, caseCond from supplier as supplier, aggView4758205160998701335 where supplier.s_nationkey=aggView4758205160998701335.v13;
create or replace view aggView4142171569152799719 as select v35, SUM(annot) as annot from aggJoin5852003262569352003 group by v35;
create or replace view aggJoin6739256466694953779 as select o_orderkey as v17, o_year as v34, o_orderdate as v38, annot from orderswithyear as orderswithyear, aggView4142171569152799719 where orderswithyear.o_custkey=aggView4142171569152799719.v35 and o_orderdate>=DATE '1995-01-01' and o_orderdate<=DATE '1996-12-31';
create or replace view aggView2648422628892271282 as select v10, caseCond, COUNT(*) as annot from aggJoin5533274877281940124 group by v10,caseCond;
create or replace view aggJoin7491697008462446019 as select l_orderkey as v17, l_partkey as v1, l_extendedprice as v22, l_discount as v23, caseCond, annot from lineitem as lineitem, aggView2648422628892271282 where lineitem.l_suppkey=aggView2648422628892271282.v10;
create or replace view aggView847688974884380445 as select p_partkey as v1 from part as part where p_type= 'ECONOMY ANODIZED STEEL';
create or replace view aggJoin2060493424438342409 as select v17, v22, v23, caseCond, annot from aggJoin7491697008462446019 join aggView847688974884380445 using(v1);
create or replace view aggView334167296591672565 as select v17, v34, SUM(annot) as annot from aggJoin6739256466694953779 group by v17,v34;
create or replace view aggJoin4928169839918387974 as select v22, v23, caseCond, aggJoin2060493424438342409.annot * aggView334167296591672565.annot as annot, v34 from aggJoin2060493424438342409 join aggView334167296591672565 using(v17);
select v34, (SUM( CASE WHEN caseCond = 1 THEN v22 * (1 - v23)* annot ELSE 0.0 END) / SUM((v22 * (1 - v23))*annot)) as v66 from aggJoin4928169839918387974 group by v34;
