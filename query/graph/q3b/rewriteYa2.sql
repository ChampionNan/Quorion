create or replace view g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create or replace view g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create or replace view semiUp6372103013896256733 as select v2, v4 from g2 where (v4) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view semiUp4599473944291397180 as select v2, v4 from semiUp6372103013896256733 where (v2) in (select v2 from g1);
create or replace view semiDown4795482286018239209 as select v2 from g1 where (v2) in (select v2 from semiUp4599473944291397180);
create or replace view semiDown1759259297493711115 as select v4 from g3 where (v4) in (select v4 from semiUp4599473944291397180);
create or replace view aggView2726096840835506348 as select v2, COUNT(*) as annot from semiDown4795482286018239209 group by v2;
create or replace view aggJoin9111439498427063545 as select v4, annot from semiUp4599473944291397180 join aggView2726096840835506348 using(v2);
create or replace view aggView5464139364902662305 as select v4, COUNT(*) as annot from semiDown1759259297493711115 group by v4;
create or replace view aggJoin4961006757413417929 as select aggJoin9111439498427063545.annot * aggView5464139364902662305.annot as annot from aggJoin9111439498427063545 join aggView5464139364902662305 using(v4);
select SUM(annot) as v15 from aggJoin4961006757413417929;
