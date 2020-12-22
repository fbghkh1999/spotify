
/*          **********************             INSERT USER          *******************************                   */

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('nzi.mhdvi','nzi.mhdavi77@gmail.com','fghjuimkd90','iran','nazanin','Mahdavi',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('fateme_a_a','ftmeahmadi77@gmail.com','fghuhmkd90','iran','fatemeh','ahmad abadi',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('mhmmd_rt','mhmmdtvkoli74@gmail.com','fghjukjhkd90','iran','mohammad reza','tavakoli',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('SalarAqili','salar.aqili@gmail.com','fgjuhuimkd90','iran','salar','aqili',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('alizandvakili','ali.zand73@gmail.com','fg89875mkd90','iran','ali','zand vakili',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('Mohsen.namjoo','mohsen.nmj71@gmail.com','fgikjhguimkd90','iran','Mohsen','Namjoo',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('zayn','zaynmalik74@gmail.com','mjknkmkd90','uk','zayn javad','malik',CURRENT_DATE);

INSERT INTO uuser(uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES('sahar.mzfri','shr74@gmail.com','90oinhnkmkd90','iran','sahar','mozaffri',CURRENT_DATE);


/******* insert  listener ****************************/

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('nzi.mhdvi','1998-6-5');

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('fateme_a_a','1998-5-5');

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('mhmmd_rt','1998-2-5');

INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('sahar.mzfri','1998-9-5');

/*********    insert  artist ******************************************/

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)
VALUES ('zayn','1986','1');

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)
VALUES ('Mohsen.namjoo','1994','1');

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted) 
VALUES ('alizandvakili','1993','1');

INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)
VALUES ('SalarAqili','2011','1');

/**************** insert   album_release   & song  **********************************************/

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('siah moo','2016-00-00','Pop','alizandvakili');
SET @lastidalbum=LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('siah moo','00:03:30','alizandvakili',@lastidalbum,'pop');

/* */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('Dusk till down','2012-00-00','R&B','zayn');
SET @lastidalbum=LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('Dusk till down','00:03:30','zayn',@lastidalbum,'R&B');
/* */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('Delbaste shodam','2013-00-00','R&B','SalarAqili');
SET @lastidalbum=LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('Delbaste shodam','00:03:35','SalarAqili',@lastidalbum,'R&B');

/* */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES ('jabr','2013-00-00','R&B','Mohsen.namjoo');
SET @lastidalbum=LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('jabr','00:06:35','Mohsen.namjoo',@lastidalbum,'R&B');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('shirin','00:03:35','Mohsen.namjoo',@lastidalbum,'R&B');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('biaban','00:03:35','Mohsen.namjoo',@lastidalbum,'R&B');
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)
VALUES('morghe sheyda','00:07:35','Mohsen.namjoo',@lastidalbum,'R&B');

/***** insert playlist   & createplaylist *************/

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('street',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'nzi.mhdvi',CURRENT_DATE);

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('sky',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
VALUES (@lastid,'mhmmd_rt',CURRENT_DATE);

INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('sun',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'fateme_a_a',CURRENT_DATE);

 INSERT INTO playlist(playlist.Title,playlist.lastediddate)
VALUES('shr',CURRENT_DATE);
SET  @lastid=LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'sahar.mzfri',CURRENT_DATE);

 /****** insert to play list has song dar vaqe: ***/  /***  add kardan ahang be play list****/

 INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='the sweet escape' AND song.Artistname='gwenStefani'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='nzi.mhdvi'
     AND  playlist.Title='street'),CURRENT_DATE);

INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='jabr' AND song.Artistname='Mohsen.namjoo'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='nzi.mhdvi'
     AND  playlist.Title='street'),CURRENT_DATE);


INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='shirin' AND song.Artistname='Mohsen.namjoo'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='nzi.mhdvi'
     AND  playlist.Title='street'),CURRENT_DATE);

     /*  */



INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='jabr' AND song.Artistname='Mohsen.namjoo'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='sahar.mzfri'
     AND  playlist.Title='shr'),CURRENT_DATE);

     INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='siah moo' AND song.Artistname='alizandvakili'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='sahar.mzfri'
     AND  playlist.Title='shr'),CURRENT_DATE);

INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='Dusk till down' AND song.Artistname='zayn'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='sahar.mzfri'
     AND  playlist.Title='shr'),CURRENT_DATE);



/*    */  
 

 INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='Dusk till down' AND song.Artistname='zayn'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd_rt'
     AND  playlist.Title='sky'),CURRENT_DATE);



 INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='siah moo' AND song.Artistname='alizandvakili'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='mhmmd_rt'
     AND  playlist.Title='sky'),CURRENT_DATE);


     /*       */


 INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='fateme_a_a'
     AND  playlist.Title='sun'),CURRENT_DATE);








     /******************************* insert likesongbyuser************************************/

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('nzi.mhdvi',(SELECT song.ID FROM song WHERE song.title='jabr' AND song.Artistname='Mohsen.namjoo'),CURRENT_DATE);


INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('mhmmd_rt',(SELECT song.ID FROM song WHERE song.title='jabr' AND song.Artistname='Mohsen.namjoo'),CURRENT_DATE);

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('fateme_a_a',(SELECT song.ID FROM song WHERE song.title='Dusk till down' AND song.Artistname='zayn'),CURRENT_DATE);

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('sahar.mzfri',(SELECT song.ID FROM song WHERE song.title='siah moo' AND song.Artistname='alizandvakili'),CURRENT_DATE);

/******* insert to likedplaylist by user  ***/

INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('mhmmd_rt',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='low'),CURRENT_DATE);


/*******  insert to follow user*******/

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('mhmmd_rt', 'f.bghkh', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('mhmmd_rt', 'fateme_a_a', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('mhmmd_rt', 'nzi.mhdvi', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('Mohsen.namjoo', 'nzi.mhdvi', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('Mohsen.namjoo', 'mhmmd.mhdvi', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('zayn', 'nzi.mhdvi', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('alizandvakili', 'fateme_a_a', CURRENT_DATE);

INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES ('sahar.mzfri', 'fateme_a_a', CURRENT_DATE);

/********* insert to song play by user*******************/

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('nzi.mhdvi',(SELECT song.ID FROM song WHERE song.title='alive' AND song.Artistname='sia'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('fateme_a_a',(SELECT song.ID FROM song WHERE song.title='siah moo' AND song.Artistname='alizandvakili'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('sahar.mzfri',(SELECT song.ID FROM song WHERE song.title='jabr' AND song.Artistname='Mohsen.namjoo'),CURRENT_DATE);

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('mhmmd_rt',(SELECT song.ID FROM song WHERE song.title='Delbaste shodam' AND song.Artistname='salaraqili'),CURRENT_DATE); 

/******* insert to reply*****************************************************/

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('nzi.mhdvi',1,'friends');


INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('mhmmd_rt',2,'water');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('sahar.mzfri',3,'apple');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('fateme_a_a',4,'The Little Prince');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('salaraqili',5,'blake shelton');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('Mohsen.namjoo',6,'alive');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('zayn',7,'spring');

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('alizandvakili',9,'swim');






























