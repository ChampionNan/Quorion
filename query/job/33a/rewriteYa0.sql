create or replace view semiUp2541191366345805112 as select movie_id as v49, linked_movie_id as v61, link_type_id as v23 from movie_link AS ml where (link_type_id) in (select id from link_type AS lt where link IN ('sequel','follows','followed by'));
create or replace view semiUp975717836155622931 as select movie_id as v61, info_type_id as v17, info as v43 from movie_info_idx AS mi_idx2 where (info_type_id) in (select id from info_type AS it2 where info= 'rating') and info<'3.0';
create or replace view semiUp6812016253758251792 as select v49, v61, v23 from semiUp2541191366345805112 where (v61) in (select v61 from semiUp975717836155622931);
create or replace view semiUp3435354855194663844 as select id as v61, title as v62, kind_id as v21 from title AS t2 where (id) in (select v61 from semiUp6812016253758251792) and production_year<=2008 and production_year>=2005;
create or replace view semiUp9098369689296630993 as select id as v21 from kind_type AS kt2 where (id) in (select v21 from semiUp3435354855194663844) and kind= 'tv series';
create or replace view semiUp8719245526252502122 as select movie_id as v49, info_type_id as v15, info as v38 from movie_info_idx AS mi_idx1;
create or replace view semiUp832504788521610657 as select id as v15 from info_type AS it1 where (id) in (select v15 from semiUp8719245526252502122) and info= 'rating';
create or replace view semiUp9041357964651434441 as select id as v49, title as v50, kind_id as v19 from title AS t1;
create or replace view semiUp3173719265179608908 as select id as v19 from kind_type AS kt1 where (id) in (select v19 from semiUp9041357964651434441) and kind= 'tv series';
create or replace view semiUp4796183645399754187 as select movie_id as v49, company_id as v1 from movie_companies AS mc1;
create or replace view semiUp3106211768870277711 as select id as v1, name as v2 from company_name AS cn1 where (id) in (select v1 from semiUp4796183645399754187) and country_code= '[us]';
create or replace view semiUp5358242587067384459 as select movie_id as v61, company_id as v8 from movie_companies AS mc2;
create or replace view semiUp2512233088226167692 as select id as v8, name as v9 from company_name AS cn2 where (id) in (select v8 from semiUp5358242587067384459);
create or replace view semiDown8172542845926475080 as select v61, v8 from semiUp5358242587067384459 where (v8) in (select v8 from semiUp2512233088226167692);
create or replace view semiDown324509007448868828 as select v1, v2 from semiUp3106211768870277711;
create or replace view semiDown3362275677738580171 as select v49, v1 from semiUp4796183645399754187 where (v1) in (select v1 from semiDown324509007448868828);
create or replace view semiDown1561604531575639157 as select v19 from semiUp3173719265179608908;
create or replace view semiDown4900463168031103276 as select v49, v50, v19 from semiUp9041357964651434441 where (v19) in (select v19 from semiDown1561604531575639157);
create or replace view semiDown6313568609508027341 as select v15 from semiUp832504788521610657;
create or replace view semiDown1093093517178405168 as select v49, v15, v38 from semiUp8719245526252502122 where (v15) in (select v15 from semiDown6313568609508027341);
create or replace view semiDown2457959167124080498 as select v21 from semiUp9098369689296630993;
create or replace view semiDown1029322445950051170 as select v61, v62, v21 from semiUp3435354855194663844 where (v21) in (select v21 from semiDown2457959167124080498);
create or replace view semiDown8992381945020859986 as select v49, v61, v23 from semiUp6812016253758251792 where (v61) in (select v61 from semiDown1029322445950051170);
create or replace view semiDown7950602859105782651 as select id as v23 from link_type AS lt where (id) in (select v23 from semiDown8992381945020859986) and link IN ('sequel','follows','followed by');
create or replace view semiDown660243137210358947 as select v61, v17, v43 from semiUp975717836155622931 where (v61) in (select v61 from semiDown8992381945020859986);
create or replace view semiDown5999573379431975269 as select id as v17 from info_type AS it2 where (id) in (select v17 from semiDown660243137210358947) and info= 'rating';
create or replace view aggView8120308286536607629 as select v17 from semiDown5999573379431975269;
create or replace view aggJoin8815019973906967172 as select v61, v43 from semiDown660243137210358947 join aggView8120308286536607629 using(v17);
create or replace view aggView498835243026871590 as select v61, MIN(v43) as v76 from aggJoin8815019973906967172 group by v61;
create or replace view aggJoin8767891493979258432 as select v49, v61, v23, v76 from semiDown8992381945020859986 join aggView498835243026871590 using(v61);
create or replace view aggView2016799033631473995 as select v23 from semiDown7950602859105782651;
create or replace view aggJoin4633059501544647986 as select v49, v61, v76 from aggJoin8767891493979258432 join aggView2016799033631473995 using(v23);
create or replace view aggView9175805612236543355 as select v61, v49, MIN(v76) as v76 from aggJoin4633059501544647986 group by v61,v49,v76;
create or replace view aggJoin8438807738831906056 as select v61, v62, v21, v49, v76 from semiDown1029322445950051170 join aggView9175805612236543355 using(v61);
create or replace view aggView7284299616205771991 as select v21, v49, v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin8438807738831906056 group by v21,v49,v61,v76;
create or replace view aggJoin2704883054389032333 as select v49, v61, v76, v78 from semiDown2457959167124080498 join aggView7284299616205771991 using(v21);
create or replace view aggView6195116584939883814 as select v49, v61, MIN(v76) as v76, MIN(v78) as v78 from aggJoin2704883054389032333 group by v49,v61,v76,v78;
create or replace view aggJoin4292952517505041040 as select v49, v15, v38, v61, v76, v78 from semiDown1093093517178405168 join aggView6195116584939883814 using(v49);
create or replace view aggView7583983759847883060 as select v15, v49, v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin4292952517505041040 group by v15,v49,v61,v76,v78;
create or replace view aggJoin4706026241919790151 as select v49, v61, v76, v78, v75 from semiDown6313568609508027341 join aggView7583983759847883060 using(v15);
create or replace view aggView3146489554649757484 as select v49, v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75 from aggJoin4706026241919790151 group by v49,v61,v76,v78,v75;
create or replace view aggJoin7855834322912747996 as select v49, v50, v19, v61, v76, v78, v75 from semiDown4900463168031103276 join aggView3146489554649757484 using(v49);
create or replace view aggView4674562633110611552 as select v19, v49, v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v50) as v77 from aggJoin7855834322912747996 group by v19,v49,v61,v76,v78,v75;
create or replace view aggJoin5348931991700485312 as select v49, v61, v76, v78, v75, v77 from semiDown1561604531575639157 join aggView4674562633110611552 using(v19);
create or replace view aggView5757125274261488775 as select v49, v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v77) as v77 from aggJoin5348931991700485312 group by v49,v61,v76,v78,v75,v77;
create or replace view aggJoin700234550018084866 as select v49, v1, v61, v76, v78, v75, v77 from semiDown3362275677738580171 join aggView5757125274261488775 using(v49);
create or replace view aggView1407102370633137179 as select v1, v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v77) as v77 from aggJoin700234550018084866 group by v1,v61,v76,v78,v75,v77;
create or replace view aggJoin1712180160769679766 as select v2, v61, v76, v78, v75, v77 from semiDown324509007448868828 join aggView1407102370633137179 using(v1);
create or replace view aggView642439894583183543 as select v61, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v77) as v77, MIN(v2) as v73 from aggJoin1712180160769679766 group by v61,v76,v78,v75,v77;
create or replace view aggJoin6276942170080095469 as select v61, v8, v76, v78, v75, v77, v73 from semiDown8172542845926475080 join aggView642439894583183543 using(v61);
create or replace view aggView5054465683666059972 as select v8, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75, MIN(v77) as v77, MIN(v73) as v73 from aggJoin6276942170080095469 group by v8,v77,v78,v73,v75,v76;
create or replace view aggJoin913524766605442620 as select v9, v76, v78, v75, v77, v73 from semiUp2512233088226167692 join aggView5054465683666059972 using(v8);
select MIN(v73) as v73, MIN(v9) as v74, MIN(v75) as v75, MIN(v76) as v76, MIN(v77) as v77, MIN(v78) as v78 from aggJoin913524766605442620;

