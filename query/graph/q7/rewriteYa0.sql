create temp table semiUp4564298652052526018 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select (src) from Graph AS g4);
create temp table semiUp8105496521587106627 as select src as v2, dst as v4 from Graph AS g2 where (src) in (select (dst) from Graph AS g1);
create temp table semiUp4904060637412190459 as select v2, v4 from semiUp8105496521587106627 where (v4) in (select (v4) from semiUp4564298652052526018);
create temp table semiDown418234138208069801 as select dst as v2 from Graph AS g1 where (dst) in (select (v2) from semiUp4904060637412190459);
create temp table semiDown7571520518165141121 as select v4, v6 from semiUp4564298652052526018 where (v4) in (select (v4) from semiUp4904060637412190459);
create temp table semiDown3112978590336153533 as select src as v6, dst as v8 from Graph AS g4 where (src) in (select (v6) from semiDown7571520518165141121);
create temp table aggView3901782608565113684 as select v6, SUM(v8 + v6) as v10 from semiDown3112978590336153533 group by v6;
create temp table aggJoin2284114773209983867 as select v4, v6, v10 from semiDown7571520518165141121 join aggView3901782608565113684 using(v6);
create temp table aggView1163172505283237893 as select v2, COUNT(*) as annot from semiDown418234138208069801 group by v2;
create temp table aggJoin6032898181978070521 as select v2, v4, annot from semiUp4904060637412190459 join aggView1163172505283237893 using(v2);
create temp table aggView6027738833723581910 as select v4, SUM(v10) as v10 from aggJoin2284114773209983867 group by v4;
create temp table aggJoin1496120660622947326 as select v2, v4, v10 * annot as v10 from aggJoin6032898181978070521 join aggView6027738833723581910 using(v4);
select v2,v4,SUM(v10) as v10 from aggJoin1496120660622947326 group by v2,v4;