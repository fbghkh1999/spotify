
/****** insert user******************************/


INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('mhmmd.mhdvi','mhmd.mhdavi74@gmail.com','fghjuimkd90','iran','mohammad','Mahdavi',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('elnaz.abdl','eli.abd74@gmail.com','fghjuiopkd90','iran','elnaz','abdollahi',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('zahra.jafri','zhra.jafari74@gmail.com','fghtgfrddpkd90','iran','zahra','jafar nezhad',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('gwenStefani','gwen@gmail.com','fgkmnbvdd90','usa','gwen renee','stefani',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('AdamLevine','Adam@gmail.com','fgnhjsdd90','usa','Adam noah','levine',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('f.bghkh','fatemeh@gmail.com','ghdeshjsdd90','iran','fatemeh','baghkhani',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('billie','billie eilish@gmail.com','ghdeshjsdd90','usa','billie eilish','pirate baird',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('sia','sia@gmail.com','ghdeshjsdd90','ausralia','sia','kate isabelle furler',CURRENT_DATE);

/******* insert  listener ****************************/

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('mhmmd.mhdvi','1996-6-5');

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('zahra.jafri','1998-4-3');

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('f.bghkh','1999-2-4');

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('elnaz.abdl','1997-3-6');

/******* insert artist  **********************************/

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)
VALUES ('gwenStefani','1986','1');

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)
VALUES ('AdamLevine','1994','1');

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted) 
VALUES ('sia','1993','1');

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)
VALUES ('billie','2016','1');

/******* insert album    & song        *********************************/

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('when We All Fall Asleep, Where Do We Go?','2019-00-00','Pop music','billie');
SET @lastidalbum=LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('listen before i go','00:03:45','billie',@lastidalbum,'R&b');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre) 
VALUES('i love you ','00:04:20','billie',@lastidalbum,'pop');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)  
VALUES('all the good girls go to the hell','00:03:26','billie',@lastidalbum,'electro pop');

/* */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('this is acting','2016-00-00','Pop music','sia');
SET @lastidalbum=LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)  
VALUES('alive','00:03:16','sia',@lastidalbum,'pop');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('unstopple','00:00:00','sia',@lastidalbum,'pop');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre) 
VALUES('never give up','00:00:00','sia',@lastidalbum,'pop');

/*   */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('the sweet escape','2016-05-06','Pop music','gwenStefani');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)  
VALUES('the sweet escape','00:04:20','gwenStefani',LAST_INSERT_ID(),'pop');


/*    */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES('Lost stars','2015-4-5','pop','AdamLevine');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)  
VALUES('Lost stars','00:03:45','AdamLevine',LAST_INSERT_ID(),'pop');






/***** insert playlist   & createplaylist *************/

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('good',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'mhmmd.mhdvi',CURRENT_DATE);


INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('lake',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES ( @lastid,'f.bghkh',CURRENT_DATE);

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('my harmooni',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'zahra.jafri',CURRENT_DATE);

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('nice',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'elnaz.abdl',CURRENT_DATE);

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('low',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'mhmmd.mhdvi',CURRENT_DATE);



 /****** insert to play list has song dar vaqe: ***/  /***  add kardan ahang be play list****/

 INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='the sweet escape' AND song.Artistname='gwenStefani'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd.mhdvi'
     AND  playlist.Title='low'),CURRENT_DATE);


     INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='Lost stars' AND song.Artistname='AdamLevine'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd.mhdvi'
     AND  playlist.Title='low'),CURRENT_DATE);

         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd.mhdvi'
     AND  playlist.Title='low'),CURRENT_DATE);

/*  */

         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='Lost stars' AND song.Artistname='AdamLevine'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='elnaz.abdl'
     AND  playlist.Title='nice'),CURRENT_DATE);


     INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='never give up' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='elnaz.abdl'
     AND  playlist.Title='nice'),CURRENT_DATE);

       INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='elnaz.abdl'
     AND  playlist.Title='nice'),CURRENT_DATE);

     /*  ****************************  */

      INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='zahra.jafri'
     AND  playlist.Title='my harmooni'),CURRENT_DATE);

        /* INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='i love you' AND song.Artistname='billie'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='zahra.jafri'
     AND  playlist.Title='my harmooni'),CURRENT_DATE);*/

         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='listen before i go' AND song.Artistname='billie'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='zahra.jafri'
     AND  playlist.Title='my harmooni'),CURRENT_DATE);

     /*       ********    */

         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='f.bghkh'
     AND  playlist.Title='lake'),CURRENT_DATE);


     
         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='lost stars' AND song.Artistname='AdamLevine'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='f.bghkh'
     AND  playlist.Title='lake'),CURRENT_DATE);

     
         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='never give up' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='f.bghkh'
     AND  playlist.Title='lake'),CURRENT_DATE);

     /*                  */

     
         INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='never give up' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd.mhdvi'
     AND  playlist.Title='good'),CURRENT_DATE);

  /*   INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='i love you' AND song.Artistname='billie'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd.mhdvi'
     AND  playlist.Title='good'),CURRENT_DATE);*/


     /* ***************  insert to question                     ************* */ 

     INSERT INTO question (question.Q,question.ID)
VALUES (' what is your favorite series? ',1);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is your favorite drink? ',2);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is your favorite fruit? ',3);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is the name of your favorite book? ',4);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is the name of your favorite artist? ',5);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is your favorite music name? ',6);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is the name of your favorite season of the year? ',7);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is your favorite color name? ',8);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is your favorite sports name? ',9);

INSERT INTO question (question.Q,question.ID)
VALUES (' what is the name of your favorite artist? ',10);


/********************  inser eshterak***********************************/
INSERT INTO eshterak(eshterak.cost,eshterak.periodd,eshterak.id)
VALUES(20000,100,1);
INSERT INTO eshterak(eshterak.cost,eshterak.periodd,eshterak.id)
VALUES(25000,130,2);

INSERT INTO eshterak(eshterak.cost,eshterak.periodd,eshterak.id)
VALUES(30000,150,3);

INSERT INTO eshterak(eshterak.cost,eshterak.periodd,eshterak.id)
VALUES(40000,200,4);

INSERT INTO eshterak(eshterak.cost,eshterak.periodd,eshterak.id)
VALUES(1000,10,5);


/***************************** insert likedsongby user***********/


INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('f.bghkh',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('f.bghkh',(SELECT song.ID FROM song WHERE song.title='never give up' AND song.Artistname='sia'),CURRENT_DATE);
/*
INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('f.bghkh',(SELECT song.ID FROM song WHERE song.title='i love you' AND song.Artistname='billie'),CURRENT_DATE);

/*  */

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('mhmmd.mhdvi',(SELECT song.ID FROM song WHERE song.title='never give up' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('mhmmd.mhdvi',(SELECT song.ID FROM song WHERE song.title='listen before i go' AND song.Artistname='billie'),CURRENT_DATE);

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('mhmmd.mhdvi',(SELECT song.ID FROM song WHERE song.title='all the good girls go to ' AND song.Artistname='billie'),CURRENT_DATE);

/*    */

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('zahra.jafri',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);

/*  */

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('elnaz.abdl',(SELECT song.ID FROM song WHERE song.title='the sweet escape' AND song.Artistname='gwenStefani'),CURRENT_DATE);

/******* insert to likedlaylist by user  ***/

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('f.bghkh',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='low'),CURRENT_DATE);

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('mhmmd.mhdvi',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='lake'),CURRENT_DATE);

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('zahra.jafri',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='nice'),CURRENT_DATE);

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('elnaz.abdl',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='my harmooni'),CURRENT_DATE);

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('mhmmd.mhdvi',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='my harmooni'),CURRENT_DATE);

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('f.bghkh',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='nice'),CURRENT_DATE);


/*******  insert to follow user*******/

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('sia', 'f.bghkh', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('sia', 'elnaz.abdl', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('billie', 'elnaz.abdl', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('gwenStefani', 'elnaz.abdl', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('mhmmd.mhdvi', 'elnaz.abdl', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('AdamLevine', 'elnaz.abdl', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('sia', 'zahra.jafri', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('f.bghkh', 'zahra.jafri', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('billie', 'zahra.jafri', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('elnaz.abdl', 'zahra.jafri', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('sia', 'mhmmd.mhdvi', CURRENT_DATE);
INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('AdamLevine', 'mhmmd.mhdvi', CURRENT_DATE);

/********* insert to song play by user*******************/
INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('mhmmd.mhdvi',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('mhmmd.mhdvi',(SELECT song.ID FROM song WHERE song.title='never give up' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('f.bghkh',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);
/*
INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('f.bghkh',(SELECT song.ID FROM song WHERE song.title='i love you' AND song.Artistname='billie'),CURRENT_DATE); */

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('zahra.jafri',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('zahra.jafri',(SELECT song.ID FROM song WHERE song.title='the sweet escape' AND song.Artistname='gwenStefani'),CURRENT_DATE);


INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('elnaz.abdl',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('elnaz.abdl',(SELECT song.ID FROM song WHERE song.title='all the good girls go to ' AND song.Artistname='billie'),CURRENT_DATE);



/***   *****  insert to buyperimium********/


INSERT INTO buypermium(buypermium.uname,buypermium.id,buypermium.datebuy,buypermium.Expired)
VALUES('sia',3,CURRENT_DATE,DATE_ADD(CURRENT_DATE, INTERVAL (SELECT periodd FROM eshterak WHERE id=3) day));

INSERT INTO buypermium(buypermium.uname,buypermium.id,buypermium.datebuy,buypermium.Expired)
VALUES('f.bghkh',4,CURRENT_DATE,DATE_ADD(CURRENT_DATE, INTERVAL (SELECT periodd FROM eshterak WHERE id=4) day));


/********* insert to user reports*******/

INSERT INTO userreports (userreports.uname,userreports.Idsong,userreports.rtype)
VALUES ('mhmmd.mhdvi', (SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),'chera enqadr khube? :))');

/******* insert to reply*****************************************************/

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('mhmmd.mhdvi',1,'friends');


INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('f.bghkh',2,'water');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('sia',3,'apple');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('elnaz.abdl',4,'The Little Prince');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('gwenStefani',5,'blake shelton');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('zahra.jafri',6,'alive');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('billie',7,'spring');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('AdamLevine',9,'swim');








































     

     

     