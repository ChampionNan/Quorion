create or replace view semiUp7065231293588959822 as select MessageId as v1 from Person_likes_Message AS Person_likes_Message where (MessageId) in (select MessageId from Message_hasTag_Tag AS Message_hasTag_Tag);
create or replace view semiUp7636919262004269186 as select ParentMessageId as v1 from Comment_replyOf_Message AS Comment_replyOf_Message where (ParentMessageId) in (select v1 from semiUp7065231293588959822);
create or replace view semiUp6390525958783873544 as select MessageId as v1 from Message_hasCreator_Person AS Message_hasCreator_Person where (MessageId) in (select v1 from semiUp7636919262004269186);
create or replace view semiDown7541338614031552620 as select v1 from semiUp7636919262004269186 where (v1) in (select v1 from semiUp6390525958783873544);
create or replace view semiDown4865749533756853899 as select v1 from semiUp7065231293588959822 where (v1) in (select v1 from semiDown7541338614031552620);
create or replace view semiDown3897107037354309853 as select MessageId as v1 from Message_hasTag_Tag AS Message_hasTag_Tag where (MessageId) in (select v1 from semiDown4865749533756853899);
create or replace view aggView5075009595067870223 as select v1, COUNT(*) as annot from semiDown3897107037354309853 group by v1;
create or replace view aggJoin3690846825354809916 as select v1, annot from semiDown4865749533756853899 join aggView5075009595067870223 using(v1);
create or replace view aggView5984926471834275649 as select v1, SUM(annot) as annot from aggJoin3690846825354809916 group by v1;
create or replace view aggJoin9021985769126818429 as select v1, annot from semiDown7541338614031552620 join aggView5984926471834275649 using(v1);
create or replace view aggView3250327901598235747 as select v1, SUM(annot) as annot from aggJoin9021985769126818429 group by v1;
create or replace view aggJoin3068258058902613101 as select annot from semiUp6390525958783873544 join aggView3250327901598235747 using(v1);
select SUM(annot) as v9 from aggJoin3068258058902613101;
