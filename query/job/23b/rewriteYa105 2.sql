create or replace view semiUp5044976634012831614 as select movie_id as v36, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('nerd','loner','alienation','dignity'));
create or replace view semiUp1293132818676712856 as select movie_id as v36, info_type_id as v16 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'release dates') and info LIKE 'USA:% 200%' and note LIKE '%internet%';
create or replace view semiUp6087598229356393200 as select movie_id as v36, company_id as v7, company_type_id as v14 from movie_companies AS mc where (movie_id) in (select v36 from semiUp1293132818676712856);
create or replace view semiUp6076729148507893948 as select v36, v7, v14 from semiUp6087598229356393200 where (v14) in (select id from company_type AS ct);
create or replace view semiUp4815965246797115168 as select v36, v7, v14 from semiUp6076729148507893948 where (v7) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp7300112506207296547 as select v36, v18 from semiUp5044976634012831614 where (v36) in (select v36 from semiUp4815965246797115168);
create or replace view semiUp8599239790170659822 as select movie_id as v36, status_id as v5 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct1 where kind= 'complete+verified');
create or replace view semiUp7891151237079633427 as select id as v36, title as v37, kind_id as v21 from title AS t where (id) in (select v36 from semiUp8599239790170659822) and production_year>2000;
create or replace view semiUp4326479700425719972 as select v36, v37, v21 from semiUp7891151237079633427 where (v36) in (select v36 from semiUp7300112506207296547);
create or replace view tAux86 as select v37, v21 from semiUp4326479700425719972;
create or replace view semiUp5408881765374672322 as select id as v21, kind as v22 from kind_type AS kt where (id) in (select v21 from tAux86) and kind= 'movie';
create or replace view semiDown1698762366513481622 as select v37, v21 from tAux86 where (v21) in (select v21 from semiUp5408881765374672322);
create or replace view semiDown6871206632840355254 as select v36, v37, v21 from semiUp4326479700425719972 where (v21, v37) in (select v21, v37 from semiDown1698762366513481622);
create or replace view semiDown2949476128427752481 as select v36, v5 from semiUp8599239790170659822 where (v36) in (select v36 from semiDown6871206632840355254);
create or replace view semiDown5237148129858452768 as select v36, v18 from semiUp7300112506207296547 where (v36) in (select v36 from semiDown6871206632840355254);
create or replace view semiDown3064902514749503260 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown2949476128427752481) and kind= 'complete+verified';
create or replace view semiDown6643160259180210530 as select id as v18 from keyword AS k where (id) in (select v18 from semiDown5237148129858452768) and keyword IN ('nerd','loner','alienation','dignity');
create or replace view semiDown4213629444794298940 as select v36, v7, v14 from semiUp4815965246797115168 where (v36) in (select v36 from semiDown5237148129858452768);
create or replace view semiDown6281156824894902143 as select id as v14 from company_type AS ct where (id) in (select v14 from semiDown4213629444794298940);
create or replace view semiDown6119076859505270191 as select v36, v16 from semiUp1293132818676712856 where (v36) in (select v36 from semiDown4213629444794298940);
create or replace view semiDown6990745355460443771 as select id as v7 from company_name AS cn where (id) in (select v7 from semiDown4213629444794298940) and country_code= '[us]';
create or replace view semiDown6279083687388454380 as select id as v16 from info_type AS it1 where (id) in (select v16 from semiDown6119076859505270191) and info= 'release dates';
create or replace view aggView9069080141174233447 as select v16 from semiDown6279083687388454380;
create or replace view aggJoin2637458213873795152 as select v36 from semiDown6119076859505270191 join aggView9069080141174233447 using(v16);
create or replace view aggView5010647955872694855 as select v7 from semiDown6990745355460443771;
create or replace view aggJoin3086807322883609098 as select v36, v14 from semiDown4213629444794298940 join aggView5010647955872694855 using(v7);
create or replace view aggView8698712885091362074 as select v36 from aggJoin2637458213873795152 group by v36;
create or replace view aggJoin5776203694700125175 as select v36, v14 from aggJoin3086807322883609098 join aggView8698712885091362074 using(v36);
create or replace view aggView554460576247499582 as select v14 from semiDown6281156824894902143;
create or replace view aggJoin1114722489284696654 as select v36 from aggJoin5776203694700125175 join aggView554460576247499582 using(v14);
create or replace view aggView4710303570992768800 as select v5 from semiDown3064902514749503260;
create or replace view aggJoin3884885322505376378 as select v36 from semiDown2949476128427752481 join aggView4710303570992768800 using(v5);
create or replace view aggView8639712462526344570 as select v36 from aggJoin1114722489284696654 group by v36;
create or replace view aggJoin1563656928930106625 as select v36, v18 from semiDown5237148129858452768 join aggView8639712462526344570 using(v36);
create or replace view aggView8165294078583579074 as select v18 from semiDown6643160259180210530;
create or replace view aggJoin804896519144829663 as select v36 from aggJoin1563656928930106625 join aggView8165294078583579074 using(v18);
create or replace view aggView6691321413192803708 as select v36 from aggJoin3884885322505376378 group by v36;
create or replace view aggJoin996541694469020980 as select v36, v37, v21 from semiDown6871206632840355254 join aggView6691321413192803708 using(v36);
create or replace view aggView8379570197843134932 as select v36 from aggJoin804896519144829663 group by v36;
create or replace view aggJoin3676128419638670661 as select v37, v21 from aggJoin996541694469020980 join aggView8379570197843134932 using(v36);
create or replace view aggView7258467118061102179 as select v21, v37, MIN(v37) as v49 from aggJoin3676128419638670661 group by v21,v37;
create or replace view aggView1091126506611135088 as select v21, MIN(v49) as v49 from aggView7258467118061102179 group by v21,v49;
create or replace view aggJoin5029543784626647156 as select v22, v49 from semiUp5408881765374672322 join aggView1091126506611135088 using(v21);
select MIN(v22) as v48, MIN(v49) as v49 from aggJoin5029543784626647156;

