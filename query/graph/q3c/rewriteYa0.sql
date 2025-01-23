create temp table g3 as select Graph.src as v4, Graph.dst as v9, v10, v14 from Graph, (SELECT src, COUNT(*) AS v10 FROM Graph GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM Graph GROUP BY dst) AS c4 where Graph.dst = c2.src and Graph.dst = c4.dst;
create temp table g2 as select Graph.src as v2, Graph.dst as v4, v12 from Graph, (SELECT src, COUNT(*) AS v12 FROM Graph GROUP BY src) AS c3 where Graph.src = c3.src;
create temp table semiUp243571451812702986 as select v2, v4 from g2 where (v4) in (select v4 from g3);
create temp table g2Aux75 as select v2 from semiUp243571451812702986;
create temp table g1 as select Graph.src as v7, Graph.dst as v2, v8 from Graph, (SELECT src, COUNT(*) AS v8 FROM Graph GROUP BY src) AS c1 where Graph.src = c1.src;
create temp table semiUp7775671644062282806 as select v2 from g2Aux75 where (v2) in (select v2 from g1);
create temp table semiDown8362357641256018361 as select v2, v4 from semiUp243571451812702986 where (v2) in (select v2 from semiUp7775671644062282806);
create temp table semiDown5412575498819288467 as select v2 from g1 where (v2) in (select v2 from semiUp7775671644062282806);
create temp table semiDown1305455418111682906 as select v4 from g3 where (v4) in (select v4 from semiDown8362357641256018361);
create temp table joinView2103641007354220256 as select v2 from semiDown8362357641256018361 join semiDown1305455418111682906 using(v4) GROUP BY v2;
create temp table joinView7079723810853076075 as select v2 from semiUp7775671644062282806 join joinView2103641007354220256 using(v2) GROUP BY v2;
select distinct v2 from joinView7079723810853076075 join semiDown5412575498819288467 using(v2);