create or replace view semiUp6352523796711007044 as select o_orderkey as v18, o_custkey as v1 from orders AS orders where (o_custkey) in (select c_custkey from customer AS customer) and o_orderdate>=DATE '1994-01-01' and o_orderdate<DATE '1995-01-01';
create or replace view semiUp2736952367115686734 as select l_orderkey as v18, l_suppkey as v20, l_extendedprice as v23, l_discount as v24 from lineitem AS lineitem where (l_orderkey) in (select v18 from semiUp6352523796711007044);
create or replace view semiUp7085348239820296286 as select n_nationkey as v4, n_name as v42, n_regionkey as v43 from nation AS nation where (n_regionkey) in (select r_regionkey from region AS region where r_name= 'ASIA');
create or replace view semiUp5883279980286286153 as select s_suppkey as v20, s_nationkey as v4 from supplier AS supplier where (s_suppkey) in (select v20 from semiUp2736952367115686734);
create or replace view semiUp5944336907126506923 as select v4, v42, v43 from semiUp7085348239820296286 where (v4) in (select v4 from semiUp5883279980286286153);
create or replace view nationAux26 as select v42 from semiUp5944336907126506923;
create or replace view semiDown2646717581607679880 as select v4, v42, v43 from semiUp5944336907126506923 where (v42) in (select v42 from nationAux26);
create or replace view semiDown6755798375419740443 as select r_regionkey as v43 from region AS region where (r_regionkey) in (select v43 from semiDown2646717581607679880) and r_name= 'ASIA';
create or replace view semiDown4329540719691803529 as select v20, v4 from semiUp5883279980286286153 where (v4) in (select v4 from semiDown2646717581607679880);
create or replace view semiDown7942702884285583096 as select v18, v20, v23, v24 from semiUp2736952367115686734 where (v20) in (select v20 from semiDown4329540719691803529);
create or replace view semiDown237193042064101699 as select v18, v1 from semiUp6352523796711007044 where (v18) in (select v18 from semiDown7942702884285583096);
create or replace view semiDown202933250405843161 as select c_custkey as v1, c_nationkey as v51 from customer AS customer where (c_custkey) in (select v1 from semiDown237193042064101699);
create or replace view aggView1923574949985484805 as select v1, v51 from semiDown202933250405843161;
create or replace view aggJoin4043664883119299276 as select v18, v51 from semiDown237193042064101699 join aggView1923574949985484805 using(v1);
create or replace view aggView8505796379944171854 as select v18, v51, COUNT(*) as annot from aggJoin4043664883119299276 group by v18,v51;
create or replace view aggJoin8549516321285121052 as select v20, v23, v24, v51, annot from semiDown7942702884285583096 join aggView8505796379944171854 using(v18);
create or replace view aggView2272485513338507302 as select v20, SUM((v23 * (1 - v24)) * annot) as v49, v51, SUM(annot) as annot from aggJoin8549516321285121052 group by v20,v51;
create or replace view aggJoin3952473741417277853 as select v4, v49, v51, annot from semiDown4329540719691803529 join aggView2272485513338507302 using(v20);
create or replace view aggView8737696748261082695 as select v43 from semiDown6755798375419740443;
create or replace view aggJoin7492932717441823074 as select v4, v42 from semiDown2646717581607679880 join aggView8737696748261082695 using(v43);
create or replace view aggView2762430342355696678 as select v4, SUM(v49) as v49, v51, SUM(annot) as annot from aggJoin3952473741417277853 group by v4,v51,v49;
create or replace view aggJoin2834893410120897739 as select v4, v42, v49, v51, annot from aggJoin7492932717441823074 join aggView2762430342355696678 using(v4);
create or replace view aggView3073379489580314981 as select v42, SUM(v49) as v49, v51, v4, SUM(annot) as annot from aggJoin2834893410120897739 group by v42,v51,v4,v49;
create or replace view aggJoin3792860192234548407 as select v42 from aggView3073379489580314981 where v4 = v51;
select v42, v49 from aggJoin3792860192234548407;

