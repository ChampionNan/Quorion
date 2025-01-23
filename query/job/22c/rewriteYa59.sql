create or replace view cnAux21 as select id as v1, name as v2 from company_name where country_code<> '[us]';
create or replace view semiUp8514837678926428901 as select movie_id as v37, keyword_id as v14 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('murder','murder-in-title','blood','violence'));
create or replace view semiUp2726513853748991936 as select movie_id as v37, info_type_id as v12, info as v32 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'rating');
create or replace view semiUp6345408452713310639 as select id as v37, title as v38, kind_id as v17 from title AS t where (id) in (select v37 from semiUp8514837678926428901) and production_year>2005;
create or replace view semiUp3398765996928249661 as select v37, v38, v17 from semiUp6345408452713310639 where (v17) in (select id from kind_type AS kt where kind IN ('movie','episode'));
create or replace view tAux61 as select v37, v38 from semiUp3398765996928249661;
create or replace view semiUp5392973199338581856 as select movie_id as v37, info_type_id as v10 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'countries') and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view semiUp2985007692492836700 as select v37, v12, v32 from semiUp2726513853748991936 where (v37) in (select v37 from semiUp5392973199338581856);
create or replace view mi_idxAux56 as select v37, v32 from semiUp2985007692492836700;
create or replace view semiUp5625519746394985277 as select movie_id as v37, company_id as v1, company_type_id as v8 from movie_companies AS mc where (movie_id) in (select v37 from tAux61) and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%';
create or replace view semiUp8274938399975455997 as select v37, v1, v8 from semiUp5625519746394985277 where (v8) in (select id from company_type AS ct);
create or replace view semiUp8062120749326301596 as select v37, v1, v8 from semiUp8274938399975455997 where (v1) in (select v1 from cnAux21);
create or replace view semiUp683331751725259671 as select v37, v32 from mi_idxAux56 where (v37) in (select v37 from semiUp8062120749326301596);
create or replace view semiDown2157267311452907980 as select v37, v1, v8 from semiUp8062120749326301596 where (v37) in (select v37 from semiUp683331751725259671);
create or replace view semiDown2901389695955893031 as select v37, v12, v32 from semiUp2985007692492836700 where (v37, v32) in (select v37, v32 from semiUp683331751725259671);
create or replace view semiDown5286014713696528762 as select id as v8 from company_type AS ct where (id) in (select v8 from semiDown2157267311452907980);
create or replace view semiDown8339382820633653193 as select v1, v2 from cnAux21 where (v1) in (select v1 from semiDown2157267311452907980);
create or replace view semiDown8482917835698103387 as select v37, v38 from tAux61 where (v37) in (select v37 from semiDown2157267311452907980);
create or replace view semiDown2139809732513971935 as select id as v12 from info_type AS it2 where (id) in (select v12 from semiDown2901389695955893031) and info= 'rating';
create or replace view semiDown1916106737164291230 as select v37, v10 from semiUp5392973199338581856 where (v37) in (select v37 from semiDown2901389695955893031);
create or replace view semiDown5732517492165854229 as select id as v1, name as v2 from company_name AS cn where (id, name) in (select v1, v2 from semiDown8339382820633653193) and country_code<> '[us]';
create or replace view semiDown1209889449079524311 as select v37, v38, v17 from semiUp3398765996928249661 where (v38, v37) in (select v38, v37 from semiDown8482917835698103387);
create or replace view semiDown8106802426164841275 as select id as v10 from info_type AS it1 where (id) in (select v10 from semiDown1916106737164291230) and info= 'countries';
create or replace view semiDown5396377263974812625 as select id as v17 from kind_type AS kt where (id) in (select v17 from semiDown1209889449079524311) and kind IN ('movie','episode');
create or replace view semiDown5103000992740624151 as select v37, v14 from semiUp8514837678926428901 where (v37) in (select v37 from semiDown1209889449079524311);
create or replace view semiDown5964129628543546036 as select id as v14 from keyword AS k where (id) in (select v14 from semiDown5103000992740624151) and keyword IN ('murder','murder-in-title','blood','violence');
create or replace view aggView8085251238237515321 as select v2, v1, v2 as v49 from semiDown5732517492165854229;
create or replace view aggView5954774493621175710 as select v14 from semiDown5964129628543546036;
create or replace view aggJoin1293571645931083092 as select v37 from semiDown5103000992740624151 join aggView5954774493621175710 using(v14);
create or replace view aggView1085201759503080961 as select v17 from semiDown5396377263974812625;
create or replace view aggJoin5466713715431510171 as select v37, v38 from semiDown1209889449079524311 join aggView1085201759503080961 using(v17);
create or replace view aggView820014021594399508 as select v37 from aggJoin1293571645931083092 group by v37;
create or replace view aggJoin2429839966298695159 as select v37, v38 from aggJoin5466713715431510171 join aggView820014021594399508 using(v37);
create or replace view aggView2083646102900708317 as select v38, v37, MIN(v38) as v51 from aggJoin2429839966298695159 group by v38,v37;
create or replace view aggView433155404396117652 as select v10 from semiDown8106802426164841275;
create or replace view aggJoin6786227868770839808 as select v37 from semiDown1916106737164291230 join aggView433155404396117652 using(v10);
create or replace view aggView1523348483351924263 as select v12 from semiDown2139809732513971935;
create or replace view aggJoin5366766995021187152 as select v37, v32 from semiDown2901389695955893031 join aggView1523348483351924263 using(v12);
create or replace view aggView8880202276656673125 as select v37 from aggJoin6786227868770839808 group by v37;
create or replace view aggJoin8688465472214961056 as select v37, v32 from aggJoin5366766995021187152 join aggView8880202276656673125 using(v37);
create or replace view aggView7228928632394277475 as select v37, v32, MIN(v32) as v50 from aggJoin8688465472214961056 group by v37,v32;
create or replace view aggView1368608478511611802 as select v8 from semiDown5286014713696528762;
create or replace view aggJoin9013671484744915801 as select v37, v1 from semiDown2157267311452907980 join aggView1368608478511611802 using(v8);
create or replace view aggView8004916321889168074 as select v37, MIN(v51) as v51 from aggView2083646102900708317 group by v37,v51;
create or replace view aggJoin8066330077024782312 as select v37, v1, v51 from aggJoin9013671484744915801 join aggView8004916321889168074 using(v37);
create or replace view aggView6676668650594407949 as select v1, MIN(v49) as v49 from aggView8085251238237515321 group by v1,v49;
create or replace view aggJoin8077540728562525839 as select v37, v51 as v51, v49 from aggJoin8066330077024782312 join aggView6676668650594407949 using(v1);
create or replace view aggView4642948034700098055 as select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin8077540728562525839 group by v37,v49,v51;
create or replace view aggJoin6440388397518671685 as select v50 as v50, v51, v49 from aggView7228928632394277475 join aggView4642948034700098055 using(v37);
select MIN(v49) as v49, MIN(v50) as v50, MIN(v51) as v51 from aggJoin6440388397518671685;

