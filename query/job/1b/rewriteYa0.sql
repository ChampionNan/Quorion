create or replace view semiUp3880995282231286972 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it where info= 'bottom 10 rank');
create or replace view semiUp8918859993917101879 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select id from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiUp7534723601691421590 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select v15 from semiUp3880995282231286972) and production_year<=2010 and production_year>=2005;
create or replace view semiUp7695808278954761857 as select v15, v1, v9 from semiUp8918859993917101879 where (v15) in (select v15 from semiUp7534723601691421590);
create or replace view semiDown4234021867710802717 as select id as v1 from company_type AS ct where (id) in (select v1 from semiUp7695808278954761857) and kind= 'production companies';
create or replace view semiDown7605404247111791987 as select v15, v16, v19 from semiUp7534723601691421590 where (v15) in (select v15 from semiUp7695808278954761857);
create or replace view semiDown4309623591312448255 as select v15, v3 from semiUp3880995282231286972 where (v15) in (select v15 from semiDown7605404247111791987);
create or replace view semiDown2282590988283847922 as select id as v3 from info_type AS it where (id) in (select v3 from semiDown4309623591312448255) and info= 'bottom 10 rank';
create or replace view aggView6868890665574060844 as select v3 from semiDown2282590988283847922;
create or replace view aggJoin7073056766833410348 as select v15 from semiDown4309623591312448255 join aggView6868890665574060844 using(v3);
create or replace view aggView1832212322232252646 as select v15 from aggJoin7073056766833410348 group by v15;
create or replace view aggJoin5598517833224767762 as select v15, v16, v19 from semiDown7605404247111791987 join aggView1832212322232252646 using(v15);
create or replace view aggView4576336896882125101 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5598517833224767762 group by v15;
create or replace view aggJoin7081751736165285190 as select v1, v9, v28, v29 from semiUp7695808278954761857 join aggView4576336896882125101 using(v15);
create or replace view aggView1428465916911426807 as select v1 from semiDown4234021867710802717;
create or replace view aggJoin2903352766625601987 as select v9, v28, v29 from aggJoin7081751736165285190 join aggView1428465916911426807 using(v1);
select MIN(v9) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2903352766625601987;
