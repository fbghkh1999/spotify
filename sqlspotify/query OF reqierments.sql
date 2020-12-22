


/* vaqti kasi mikhad yki dgro follow kone 
*/
SELECT IF(NOT EXISTS (SELECT follow_user.username_followed
                      FROM follow_user
                      WHERE follow_user.username_follower='username karbar ke darkhast dde'
                     AND follow_user.username_followed='oni ke mikhad followsh kone'),"Yes","No");/* age khoroji in "Yes" bood follow kone
                      "No" bood follow krde qbln*/


INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
VALUES (' user name karbari ke mikhad foollowsh kone ', 'username khodesh', CURRENT_DATE);

/* vqti mikhad unfollow kone */

SELECT IF( EXISTS (SELECT follow_user.username_followed
                      FROM follow_user
                      WHERE follow_user.username_follower='username karbar ke darkhast dde'
                     AND follow_user.username_followed='oni ke mikhad unfollowsh kone'),"Yes","No");/* age khoroji in "Yes" bood unfollow kone
                      "No" bood yani qablnunfollow krde*/


DELETE FROM follow_user WHERE follow_user.username_followed='oni ke mikhad unfollow kone ' AND follow_user.username_follower='username khodesh';



/* vaqti mikhad ahang goosh bede */

SELECT if(NOT EXISTS(SELECT songplaybyuser.uname
               FROM songplaybyuser
              WHERE songplaybyuser.dateplay=CURRENT_DATE
               AND songplaybyuser.uname='useri ke darkhast dde'
              AND songplaybyuser.uname NOT IN(SELECT buypermium.uname
                                              FROM buypermium)
              GROUP BY songplaybyuser.uname
              HAVING COUNT(songplaybyuser.Idsong)=5),"Yes","No");/* age khoroji yes bood goosh bde (yni insert anjam beshe)
                       age khoroji No bashe insert nashavad(goosh nadahd)*/          
            
          

INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES ('username fard',(SELECT song.ID FROM song WHERE song.title='name of music' AND song.Artistname='name of artist an ahang'),CURRENT_DATE);


/*ijad playlist */

SELECT if(NOT EXISTS(SELECT createplaylist_user.uname
               FROM createplaylist_user
              WHERE createplaylist_user.Createdate=CURRENT_DATE
               AND createplaylist_user.uname='useri ke darkhast dde'
              AND createplaylist_user.uname NOT IN(SELECT buypermium.uname
                                              FROM buypermium)
              GROUP BY createplaylist_user.uname
              HAVING COUNT(createplaylist_user.Idplaylist)=5),"Yes","No");  /* age yes: ijad konad (insert shavad)
              age no:ijad nashavad(insert nashavad)*/

          
            
          
INSERT INTO playlist (playlist.Title,playlist.lastediddate) VALUES (' az karbar migirim',CURRENT_DATE);
SET @lastid= LAST_INSERT_ID();
INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,'username karabar',CURRENT_DATE);

 /* add kardan ahabng b playlist */

 INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
VALUES((SELECT song.ID FROM song WHERE song.title='name of music' AND song.Artistname='name of artist an ahang'),
(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='username karbar'
     AND  playlist.Title='name of playlist'),CURRENT_DATE);


/* hazf kardan az playlist */

DELETE FROM playlisthassong WHERE playlisthassong.Idsong=(SELECT song.ID FROM song WHERE song.title='name of music' AND song.Artistname='name of artist an ahang')
AND playlisthassong.Idplaylist= (SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname='username karbar'
     AND  playlist.Title='name of playlist');


/* karbar mikhahad mosiqi like konad */

INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
VALUES ('user name karbar ',(SELECT song.ID FROM song WHERE song.title='name of music' AND song.Artistname='name of artist(username artist)'),CURRENT_DATE);


/* karbar mikhahad yek ahag ra unlike konad  */
DELETE FROM likedsongbyuser 
WHERE likedsongbyuser.uname='user name ' 
AND likedsongbyuser.Idsong=(SELECT song.ID FROM song WHERE song.title='name of music' AND song.Artistname='name of artist');



/*  karbar mikhahad playlist like konad 
farz bar in ast ke title tekrari baray playlist ndrim , agar dashte bashim bayad user sazande plylist ra dashte bashim ta id yekta begirim */
INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
VALUES ('user name karbar ',(SELECT playlist.ID  FROM playlist WHERE    playlist.Title='name of playlist'),CURRENT_DATE);

/* vaqti play list ra unlike konad */
DELETE FROM likedplaylistbyuser 
WHERE likedplaylistbyuser.uname='user name karbar' 
AND likedplaylistbyuser.Idplaylist=(SELECT playlist.ID  FROM playlist WHERE   playlist.Title='name of playlist');

/* gozaresh mohtavaye namonaseb  */
INSERT INTO userreports (userreports.uname,userreports.Idsong,userreports.rtype)
VALUES ('user name', (SELECT song.ID FROM song WHERE song.title='name of music' AND song.Artistname='name of artist'),' rtype');

/*  ijad play list eshteraki */

INSERT INTO createplaylist_user(createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
VALUES((SELECT playlist.ID FROM playlist,createplaylist_user WHERE createplaylist_user.Idplaylist=playlist.ID AND createplaylist_user.uname='user name jari ke darkhast dde'
        AND playlist.Title='name of play list mored nzr '),'username ke mikhahad add konad : az karbar migirm',CURRENT_DATE);




/* artist action */
  /* check */
SELECT artist.username   /* agar khali bood bege shoma b onvan artist taeed nashode id */
FROM artist 
WHERE artist.Accepted=1 AND artist.username='user name k darkhast dde';
/* darkhast release album ,farz : artist taeed shode    @_@   b inja residi bgoo sohbat konim */

INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
VALUES('name of album','0000/00/00','genre','username  artisti ke darkhast dde bayad uniqe bashad');
SET @lastid= LAST_INSERT_ID();
INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)  /* in insert dovom bayad b tedad ahang ha tekrar shavad  ya darkhast haie artist*/
VALUES('title','00:00:00','haman user name uniqe (artisti k dre darkhast mide)',@lastid,'genre');

/* darkhast del yek album */
DELETE FROM album_release   WHERE album_release.title='name of album ' AND album_release.userArtist='username artist ';

/* darkhast del yek ahang az album */
 DELETE FROM song WHERE song.title='name of music' AND 
 song.IDALBUM = (select album_release.ID from album_release 
                  WHERE album_release.title='name of album' 
                  and album_release.userArtist='username artist ');

/* Admin action */
/* taeed yek artist */
/* aval nataieje query zir neshan dde mishavad bad yki ra entekhab jahat taeed */

SELECT artist.username   
FROM artist 
WHERE artist.Accepted=3;


UPDATE artist
SET artist.Accepted = 1
WHERE  artist.USERNAME='username artisti ke mikhad taeed kone';

  /* adam taeed */
 START TRANSACTION;
UPDATE artist
SET artist.Accepted= 0
WHERE artist.USERNAME='username artisti ke mikhad taeed nkone ';
 DELETE FROM artist WHERE artist.USERNAME='username artisti ke mikhad taeed nkone'  ;
COMMIT;

/* del user az system */
DELETE FROM uuser WHERE uuser.USERNAME=' user mikhad delet kone';

/* del playlist */
DELETE FROM playlist WHERE playlist.Title='tilte';

/* del album */
DELETE FROM album_release WHERE album_release.userArtist=' name artist album' AND album_release.title='name of album';

/* moshahede ahang haie report shode */

SELECT song.title
FROM userreports,song
WHERE userreports.Idsong=song.ID

/* del song */
DELETE FROM song WHERE song.title='name of music ';

/* listener action: */

/* vaqti mikhad eshterak bekhare   aval hameye eshterak ha b uo neshan dde mishavad bad  yek ra entekhab mikonad*/

SELECT eshterak.cost,eshterak.periodd,eshterak.ID
FROM eshterak;

/* yk id bayad bedhad b ma  az query qbli  */

INSERT INTO buypermium(buypermium.uname,buypermium.id,buypermium.datebuy,buypermium.Expired)
VALUES('useer name karbar','id ke b ma mide',
CURRENT_DATE,DATE_ADD(CURRENT_DATE, INTERVAL (SELECT periodd FROM eshterak WHERE id='id ke b ma mide (int)') day));






