create temp table bag221 as select g2.src as v2, g3.src as v5, g2.weight as v6, g3.dst as v8, g3.weight as v9 from bitcoin as g3, bitcoin as g2 where g3.src=g2.dst;
create temp table semiUp1762870925544274437 as select src as v8, dst as v2, weight as v3 from bitcoin AS g1 where (src, dst) in (select v8, v2 from bag221) and weight<2;
create temp table semiUp3218119032427856022 as select src as v2, dst as v17, weight as v21 from bitcoin AS g7 where (src) in (select v2 from semiUp1762870925544274437);
create temp table bag222 as select g5.src as v11, g6.src as v14, g5.weight as v15, g6.dst as v17, g6.weight as v18 from bitcoin as g6, bitcoin as g5 where g6.src=g5.dst;
create temp table semiUp5176247958459282301 as select src as v17, dst as v11, weight as v12 from bitcoin AS g4 where (dst, src) in (select v11, v17 from bag222);
create temp table semiUp7429034845110202074 as select v2, v17, v21 from semiUp3218119032427856022 where (v17) in (select v17 from semiUp5176247958459282301);
create temp table semiDown680587771835674936 as select v8, v2, v3 from semiUp1762870925544274437 where (v2) in (select v2 from semiUp7429034845110202074);
create temp table semiDown4045937511550956423 as select v17, v11, v12 from semiUp5176247958459282301 where (v17) in (select v17 from semiUp7429034845110202074);
create temp table semiDown2348840039798840786 as select v2, v5, v6, v8, v9 from bag221 where (v8, v2) in (select v8, v2 from semiDown680587771835674936);
create temp table semiDown6557097720508535487 as select v11, v14, v15, v17, v18 from bag222 where (v11, v17) in (select v11, v17 from semiDown4045937511550956423);
create temp table joinView7956896695904330091 as select v8, v2, v3, v5, v6, v9 from semiDown680587771835674936 join semiDown2348840039798840786 using(v8, v2);
create temp table joinView2195485334105553038 as select v17, v11, v12, v14, v15, v18 from semiDown4045937511550956423 join semiDown6557097720508535487 using(v11, v17);
create temp table joinView1612784847426138871 as select v2, v17, v21, v8, v3, v5, v6, v9 from semiUp7429034845110202074 join joinView7956896695904330091 using(v2);
create temp table joinView3665293527015761140 as select v2, v17, v21, v8, v3, v5, v6, v9, v11, v12, v14, v15, v18 from joinView1612784847426138871 join joinView2195485334105553038 using(v17);
select v8, v2, v3, v2, v5, v6, v5, v8, v9, v17, v11, v12, v11, v14, v15, v14, v17, v18, v2, v17, v21 from joinView3665293527015761140;
