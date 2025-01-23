create or replace view g3 as select Graph.src as v4, Graph.dst as v6, v10 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2 where Graph.dst = c2.src;
create or replace view semiUp8374002163201252732 as select src as v2, dst as v4 from Graph AS g2 where (dst) in (select v4 from g3);
create or replace view g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create or replace view semiUp2704451919079927342 as select v2 from g1 where (v2) in (select v2 from semiUp8374002163201252732);
create or replace view semiDown8857969157234450400 as select v2, v4 from semiUp8374002163201252732 where (v2) in (select v2 from semiUp2704451919079927342);
create or replace view semiDown9179493513255238914 as select v4 from g3 where (v4) in (select v4 from semiDown8857969157234450400);
create or replace view aggView6920841023071399601 as select v4, COUNT(*) as annot from semiDown9179493513255238914 group by v4;
create or replace view aggJoin3257804111471303959 as select v2, annot from semiDown8857969157234450400 join aggView6920841023071399601 using(v4);
create or replace view aggView5206864967005147816 as select v2, SUM(annot) as annot from aggJoin3257804111471303959 group by v2;
create or replace view aggJoin8583269268400352995 as select annot from semiUp2704451919079927342 join aggView5206864967005147816 using(v2);
select SUM(annot) as v11 from aggJoin8583269268400352995;
