create or replace view bag160 as select g5.src as v11, g6.src as v14, g5.weight as v15, g6.dst as v17, g6.weight as v18 from bitcoin as g6, bitcoin as g5 where g6.src=g5.dst;
create or replace view semiJoinView6185501572136432982 as select src as v17, dst as v11, weight as v12 from bitcoin AS g4 where (dst, src) in (select v11, v17 from bag160);
create or replace view bag161 as select g1.dst as v2, g1.weight as v3, g3.src as v5, g3.dst as v8, g3.weight as v9 from bitcoin as g3, bitcoin as g1 where g3.dst=g1.src and g1.weight<2;
create or replace view semiJoinView6187694488517957174 as select src as v2, dst as v5, weight as v6 from bitcoin AS g2 where (src, dst) in (select v2, v5 from bag161);
create or replace view semiJoinView4979689585304852856 as select src as v2, dst as v17, weight as v21 from bitcoin AS g7 where (dst) in (select v17 from semiJoinView6185501572136432982);
create or replace view semiJoinView5126476360739360105 as select v2, v17, v21 from semiJoinView4979689585304852856 where (v2) in (select v2 from semiJoinView6187694488517957174);
create or replace view semiEnum6778309047584163251 as select v6, v21, v2, v17, v5 from semiJoinView5126476360739360105 join semiJoinView6187694488517957174 using(v2);
create or replace view semiEnum701336989506807767 as select v6, v21, v5, v11, v12, v17, v2 from semiEnum6778309047584163251 join semiJoinView6185501572136432982 using(v17);
create or replace view semiEnum3921252799521482609 as select v6, v21, v8, v9, v3, v5, v11, v12, v17, v2 from semiEnum701336989506807767 join bag161 using(v2, v5);
create or replace view semiEnum4940697859984591171 as select v6, v21, v8, v9, v3, v18, v5, v11, v14, v15, v12, v17, v2 from semiEnum3921252799521482609 join bag160 using(v11, v17);
select v8, v2, v3, v2, v5, v6, v5, v8, v9, v17, v11, v12, v11, v14, v15, v14, v17, v18, v2, v17, v21 from semiEnum4940697859984591171;
