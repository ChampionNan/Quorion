create temp table bag238 as select g5.src as v11, g4.weight as v12, g5.dst as v14, g5.weight as v15, g4.src as v17 from bitcoin as g5, bitcoin as g4 where g5.src=g4.dst;
create temp table semiUp5476073214840506361 as select src as v14, dst as v17, weight as v18 from bitcoin AS g6 where (src, dst) in (select v14, v17 from bag238);
create temp table semiUp1247618577287388697 as select src as v2, dst as v17, weight as v21 from bitcoin AS g7 where (dst) in (select v17 from semiUp5476073214840506361);
create temp table bag237 as select g1.dst as v2, g1.weight as v3, g3.src as v5, g3.dst as v8, g3.weight as v9 from bitcoin as g3, bitcoin as g1 where g3.dst=g1.src and g1.weight<2;
create temp table semiUp3545365626876754433 as select src as v2, dst as v5, weight as v6 from bitcoin AS g2 where (dst, src) in (select v5, v2 from bag237);
create temp table semiUp3795453406440503399 as select v2, v17, v21 from semiUp1247618577287388697 where (v2) in (select v2 from semiUp3545365626876754433);
create temp table semiDown5489751795547218134 as select v2, v5, v6 from semiUp3545365626876754433 where (v2) in (select v2 from semiUp3795453406440503399);
create temp table semiDown8086822900551503203 as select v14, v17, v18 from semiUp5476073214840506361 where (v17) in (select v17 from semiUp3795453406440503399);
create temp table semiDown6459595034929395034 as select v2, v3, v5, v8, v9 from bag237 where (v5, v2) in (select v5, v2 from semiDown5489751795547218134);
create temp table semiDown9198476761252613418 as select v11, v12, v14, v15, v17 from bag238 where (v14, v17) in (select v14, v17 from semiDown8086822900551503203);
create temp table joinView2836005736161799734 as select v2, v5, v6, v3, v8, v9 from semiDown5489751795547218134 join semiDown6459595034929395034 using(v5, v2);
create temp table joinView6232705396452609382 as select v14, v17, v18, v11, v12, v15 from semiDown8086822900551503203 join semiDown9198476761252613418 using(v14, v17);
create temp table joinView4823822624150385774 as select v2, v17, v21, v5, v6, v3, v8, v9 from semiUp3795453406440503399 join joinView2836005736161799734 using(v2);
create temp table joinView3607190777158521157 as select v2, v17, v21, v5, v6, v3, v8, v9, v14, v18, v11, v12, v15 from joinView4823822624150385774 join joinView6232705396452609382 using(v17);
select v8, v2, v3, v2, v5, v6, v5, v8, v9, v17, v11, v12, v11, v14, v15, v14, v17, v18, v2, v17, v21 from joinView3607190777158521157;
