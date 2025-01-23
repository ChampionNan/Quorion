create or replace view semiUp7085989169522969314 as select movie_id as v36, info_type_id as v16 from movie_info AS mi where (info_type_id) in (select id from info_type AS it1 where info= 'release dates') and info LIKE 'USA:% 200%' and note LIKE '%internet%';
create or replace view semiUp1056558348836881866 as select movie_id as v36, keyword_id as v18 from movie_keyword AS mk where (keyword_id) in (select id from keyword AS k where keyword IN ('nerd','loner','alienation','dignity'));
create or replace view semiUp1697032615176692836 as select movie_id as v36, company_id as v7, company_type_id as v14 from movie_companies AS mc where (movie_id) in (select v36 from semiUp7085989169522969314);
create or replace view semiUp9123258840941459394 as select v36, v7, v14 from semiUp1697032615176692836 where (v14) in (select id from company_type AS ct);
create or replace view semiUp5764638813438518807 as select movie_id as v36, status_id as v5 from complete_cast AS cc where (status_id) in (select id from comp_cast_type AS cct1 where kind= 'complete+verified');
create or replace view semiUp6693439084339939842 as select v36, v7, v14 from semiUp9123258840941459394 where (v7) in (select id from company_name AS cn where country_code= '[us]');
create or replace view semiUp7346348068346921810 as select v36, v18 from semiUp1056558348836881866 where (v36) in (select v36 from semiUp6693439084339939842);
create or replace view semiUp8386006940213362952 as select id as v36, title as v37, kind_id as v21 from title AS t where (id) in (select v36 from semiUp7346348068346921810) and production_year>2000;
create or replace view semiUp6087067200201719275 as select v36, v37, v21 from semiUp8386006940213362952 where (v36) in (select v36 from semiUp5764638813438518807);
create or replace view tAux86 as select v37, v21 from semiUp6087067200201719275;
create or replace view semiUp697841894969775920 as select v37, v21 from tAux86 where (v21) in (select id from kind_type AS kt where kind= 'movie');
create or replace view semiDown6541420640301606045 as select id as v21, kind as v22 from kind_type AS kt where (id) in (select v21 from semiUp697841894969775920) and kind= 'movie';
create or replace view semiDown875611556368508990 as select v36, v37, v21 from semiUp6087067200201719275 where (v21, v37) in (select v21, v37 from semiUp697841894969775920);
create or replace view semiDown1535274480274339155 as select v36, v5 from semiUp5764638813438518807 where (v36) in (select v36 from semiDown875611556368508990);
create or replace view semiDown4056242117316582874 as select v36, v18 from semiUp7346348068346921810 where (v36) in (select v36 from semiDown875611556368508990);
create or replace view semiDown5724580652550987438 as select id as v5 from comp_cast_type AS cct1 where (id) in (select v5 from semiDown1535274480274339155) and kind= 'complete+verified';
create or replace view semiDown5426387480159940117 as select id as v18 from keyword AS k where (id) in (select v18 from semiDown4056242117316582874) and keyword IN ('nerd','loner','alienation','dignity');
create or replace view semiDown4261251313662700660 as select v36, v7, v14 from semiUp6693439084339939842 where (v36) in (select v36 from semiDown4056242117316582874);
create or replace view semiDown980993140540335372 as select id as v14 from company_type AS ct where (id) in (select v14 from semiDown4261251313662700660);
create or replace view semiDown3849625669325460541 as select v36, v16 from semiUp7085989169522969314 where (v36) in (select v36 from semiDown4261251313662700660);
create or replace view semiDown6683418150725505450 as select id as v7 from company_name AS cn where (id) in (select v7 from semiDown4261251313662700660) and country_code= '[us]';
create or replace view semiDown1064072794512334511 as select id as v16 from info_type AS it1 where (id) in (select v16 from semiDown3849625669325460541) and info= 'release dates';
create or replace view aggView653470564002962697 as select v16 from semiDown1064072794512334511;
create or replace view aggJoin8706383710565970341 as select v36 from semiDown3849625669325460541 join aggView653470564002962697 using(v16);
create or replace view aggView3325136770260004617 as select v7 from semiDown6683418150725505450;
create or replace view aggJoin8243423254660200723 as select v36, v14 from semiDown4261251313662700660 join aggView3325136770260004617 using(v7);
create or replace view aggView2914399215512351942 as select v36 from aggJoin8706383710565970341 group by v36;
create or replace view aggJoin6399940976086802528 as select v36, v14 from aggJoin8243423254660200723 join aggView2914399215512351942 using(v36);
create or replace view aggView736700689724950331 as select v14 from semiDown980993140540335372;
create or replace view aggJoin2142088316601803901 as select v36 from aggJoin6399940976086802528 join aggView736700689724950331 using(v14);
create or replace view aggView5362205991743163097 as select v5 from semiDown5724580652550987438;
create or replace view aggJoin8440931981887711660 as select v36 from semiDown1535274480274339155 join aggView5362205991743163097 using(v5);
create or replace view aggView4270149358232950967 as select v36 from aggJoin2142088316601803901 group by v36;
create or replace view aggJoin8477855413283179991 as select v36, v18 from semiDown4056242117316582874 join aggView4270149358232950967 using(v36);
create or replace view aggView1198049528547697729 as select v18 from semiDown5426387480159940117;
create or replace view aggJoin6186257676407030959 as select v36 from aggJoin8477855413283179991 join aggView1198049528547697729 using(v18);
create or replace view aggView6116715135943650235 as select v36 from aggJoin8440931981887711660 group by v36;
create or replace view aggJoin6408531955918779280 as select v36, v37, v21 from semiDown875611556368508990 join aggView6116715135943650235 using(v36);
create or replace view aggView385151747001724270 as select v36 from aggJoin6186257676407030959 group by v36;
create or replace view aggJoin8374650947676756448 as select v37, v21 from aggJoin6408531955918779280 join aggView385151747001724270 using(v36);
create or replace view aggView5668833091315443402 as select v21, v37, MIN(v37) as v49 from aggJoin8374650947676756448 group by v21,v37;
create or replace view aggView8139653686380166000 as select v21, v22 as v48 from semiDown6541420640301606045;
create or replace view aggJoin2407158978622736952 as select v49, v48 from aggView5668833091315443402 join aggView8139653686380166000 using(v21);
select MIN(v48) as v48, MIN(v49) as v49 from aggJoin2407158978622736952;

