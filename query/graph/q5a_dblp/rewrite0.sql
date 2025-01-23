create or replace view g5 as select dblp.src as v4, dblp.dst as v10, v18 from dblp, (SELECT dst, COUNT(*) AS v18 FROM dblp GROUP BY dst) AS c4 where dblp.dst = c4.dst;
create or replace view g5_proj as select v4 from g5 GROUP BY v4;
create or replace view semiJoinView6213114770400706162 as select src as v2, dst as v4 from dblp AS g2, g5_proj where g2.dst = v4;
create or replace view g1 as select dblp.src as v1, dblp.dst as v2, v12 from dblp, (SELECT src, COUNT(*) AS v12 FROM dblp GROUP BY src) AS c1 where dblp.src = c1.src and v12<3;
create or replace view g1_proj as select v2 from g1 GROUP BY v2;
create or replace view semiJoinView2050253192448598669 as select v2, v4 from semiJoinView6213114770400706162 join g1_proj using (v2);
create or replace view g4 as select dblp.src as v7, dblp.dst as v2, v16 from dblp, (SELECT dst, COUNT(*) AS v16 FROM dblp GROUP BY dst) AS c3 where dblp.src = c3.dst and v16<3;
create or replace view g4_proj as select v2 from g4 GROUP BY v2;
create or replace view semiJoinView8500852560655297705 as select v2, v4 from semiJoinView2050253192448598669 join g4_proj using (v2);
create or replace view g3 as select dblp.src as v4, dblp.dst as v6, v14 from dblp, (SELECT src, COUNT(*) AS v14 FROM dblp GROUP BY src) AS c2 where dblp.dst = c2.src;
create or replace view g3_proj as select v4 from g3 GROUP BY v4;
select distinct v2, v4 from semiJoinView8500852560655297705 join g3_proj using (v4);