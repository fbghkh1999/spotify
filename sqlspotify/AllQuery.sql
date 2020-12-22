/* yek reshte az karbar daryaft mishavad ke  bayad dar tamam table ha search shavad ta natije  ra neshan dahad :1 */

SELECT username,fname,lname
FROM uuser
WHERE username like'% reshte karbar %' OR fname like'% reshte karbar %' OR
lname like'% reshte karbar %';


select title,artistname
FROM song 
WHERE title like '% reshte karbar %' ;

select title,userartist
FROM album_realese 
WHERE title like'% reshte karbar %';

select title
FROM playlist 
WHERE title like'% reshte karbar %';




/************************************************************************************************profile karbar :2*/


SELECT uuser.USERNAME ,uuser.Fname,uuser.Lname,playlist.Title,playlist.lastediddate,COUNT(song.ID)
from createplaylist_user,playlisthassong,playlist,uuser,song
WHERE uuser.USERNAME=createplaylist_user.uname AND playlisthassong.Idplaylist=createplaylist_user.Idplaylist AND playlisthassong.Idsong=song.ID
AND playlisthassong.Idplaylist=playlist.ID AND
uuser.USERNAME='az karbar migirim' 
GROUP BY playlist.ID

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  :tedad follower haie karbar */

SELECT COUNT(follow_user.username_follower)
FROM follow_user
WHERE follow_user.username_followed=' az karbar migirim'
GROUP BY follow_user.username_followed

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  : tedad followig */

SELECT COUNT(follow_user.username_followed)
FROM follow_user
WHERE follow_user.username_follower='az karbar migirim'
GROUP BY follow_user.username_follower


/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& : zhanr qaleb honarmnd */


SELECT album_release.genre     
FROM album_release
WHERE  album_release.userArtist='az karbar migirim'
GROUP BY album_release.genre
HAVING COUNT (album_release.ID) >= ALL ( SELECT COUNT (album_release.ID)
					FROM album_release
					WHERE  album_release.userArtist='az karbar migirim'
				        GROUP BY album_release.genre)




/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& : onvan va sal enteshar album haie honarmand */

SELECT album_release.title,album_release.yearrelease
FROM album_release
WHERE album_release.userArtist='az karbar migirim'


/* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&: ahang haie mahboob honarmand  : taqir yafte*/

SELECT DISTINCT(song.title)
FROM song 
INNER JOIN songplaybyuser ON songplaybyuser.Idsong=song.ID
INNER JOIN likedsongbyuser ON likedsongbyuser.Idsong=song.ID
WHERE song.Artistname='username artist'
LIMIT 10;

/*               **************     ****************************************************         :3*/

 /* kasani ke karbar ra follow kardeand */
SELECT username_follower 
from follow_user 
WHERE  username_followed =' username karbar ';
 
  SELECT username_followed  /* kasani ke karbar an haro  follow karde ast */
from follow_user 
WHERE   username_follower=' username karbar ';


/***********************************************************           taqir yafte :4*/
SELECT song.title,song.duration,playlisthassong.adddate
from playlist,song,playlisthassong
where  playlisthassong.Idplaylist=playlist.ID AND
song.ID=playlisthassong.Idsong
and playlist.Title='reshte karbar '  

/* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&**/

select song.title as songname , song.duration,album_release.yearrelease,album_release.title as albumname
FROM  song ,album_release 
WHERE song.IDALBUM=album_release.ID
AND album_release.title='az karbar'
/************************************************************************************************* : 5*/
DELETE FROM buypermium WHERE  expired=CURRENT_DATE ; /*  pak kardan karbarani k tarikh eshterak anha expire shode ast */
/*  farz ma bar in ast ke  kasani dar table buypermium hastand ke eshterak darand */


/* ***********************************************************************************  taqir yafte :6*/
SELECT follow_user.username_followed as yourfollowig,max(songplaybyuser.dateplay)as lastplay,song.title as namemusic
FROM songplaybyuser,follow_user,song
WHERE songplaybyuser.uname=follow_user.username_followed and follow_user.username_follower='user name karbar' AND songplaybyuser.Idsong=song.ID
GROUP BY follow_user.username_followed


/*  /* karbaran qader  b didn 5 ahang jadid montasher shode tavasot honarmand follow  shode eshn hastand */  /*    :7 */
select title,userartist  
from album_release,follow_user
WHERE username_follower='az karbar migirim' AND userartist=username_followed
ORDER BY yearrealese DESC
limit 5; 


/**************  ژانر غالب هنرمند محبوب کاربر را پيدا کند و هنرمند ديگري در ان ژانر پيشنهاد دهد .:8*/ /* :8*/


SELECT   song.Artistname 
FROM playlisthassong,song,createplaylist_user
WHERE playlisthassong.Idsong=song.ID and createplaylist_user.Idplaylist=playlisthassong.Idplaylist
and createplaylist_user.uname='username karabr' 
GROUP by song.Artistname
HAVING  COUNT(song.ID) >= ALL (SELECT  COUNT(song.ID) as c
                  FROM playlisthassong,song,createplaylist_user
                    WHERE playlisthassong.Idsong=song.ID and createplaylist_user.Idplaylist=playlisthassong.Idplaylist
                     and createplaylist_user.uname='username karbar' 
                      GROUP by song.Artistname)




 /* query 2*/
SELECT album_release.genre  
FROM album_release 
WHERE album_release.userArtist='natije query 1'
GROUP by album_release.genre
HAVING COUNT(album_release.genre) >= ALL (SELECT album_release.genre
FROM album_release 
WHERE album_release.userArtist='natije query 1'
GROUP by album_release.genre)





SELECT album_release.userArtist
FROM album_release 
where album_release.userArtist <> 'natije query 1' and album_release.genre='natije query 2'
ORDER by album_release.userArtist
limit 1;
  /*        ************************   5 ahang mahboob hafte ********************************************************* :9    */

  SELECT title,artistname 
FROM song as s ,likesongbyuser as l 
WHERE  week(CURRENT_DATE)=week(likedate)
and s.idsong =l.idsong
order by  likedate DESC
limit 5 ;
 

 /* ***********************************************************  : 10  *******************************************  : taqir yafte */
 SELECT   song.genre  /* query 1*/
FROM songplaybyuser,song
WHERE songplaybyuser.Idsong=song.id and songplaybyuser.uname='username karbar' 
GROUP by song.genre
HAVING  COUNT(song.ID) >= ALL (SELECT  COUNT(song.ID)
                               FROM songplaybyuser,song
                               WHERE songplaybyuser.Idsong=song.ID and songplaybyuser.uname='username karbar' 
                               GROUP by song.genre)

/* query 2 */ /* 5 ahang mahboob dar genre mahboob karbar */
SELECT song.title,COUNT(song.ID) as numberoflike  
FROM song,likedsongbyuser
WHERE  song.genre='natije query 1' 
AND song.ID=likedsongbyuser.Idsong not in( select song.title from song,songplaybyuser
                                                WHERE songplaybyuser.Idsong=song.ID  
                                                and songplaybyuser.uname='username karbar' 
                                                and  song.genre='natije query 1')

GROUP BY song.title                                                         
ORDER BY  numberoflike DESC  
limit 5;

/* query 3*/ /* 5 ahang montasher shode dar hafte gozashte, dar zhanr mahboob karbar */ 
SELECT song.title         
FROM album_release,song
where  album_release.Id=song.IDalbum  AND song.genre='natije query 1'
AND (week(album_release.yearrelease)=week(CURRENT_DATE)-1 
or week(album_release.yearrelease)=week(CURRENT_DATE))    
and  not in( select song.title from song,songplaybyuse WHERE songplaybyuser.Idsong=song.ID  
             and songplaybyuser.uname='username karbar' and  song.genre='natije query 1') 
LIMIT 5;                                                          




 
 /****** : 11 ********/


 /****** genre qaleb artist  & peyda kardan fan  haie  artist       * taqir yafte  * :   12*******/ 

 /*query 1*/
SELECT album_release.genre    
FROM album_release
WHERE  album_release.userArtist='username artist'
GROUP BY album_release.genre
HAVING COUNT (album_release.ID) >= ALL ( SELECT COUNT (album_release.ID)
					FROM album_release
					WHERE  album_release.userArtist='username artist'
				        GROUP BY album_release.genre)






SELECT songplaybyuser.uname as u
FROM songplaybyuser,song
WHERE song.ID=songplaybyuser.Idsong AND  song.Artistname='username artist'
GROUP by songplaybyuser.uname 
HAVING  COUNT(song.ID) >10 AND  'natije query 1'=(SELECT   song.genre
										FROM songplaybyuser,song
										WHERE song.ID=songplaybyuser.Idsong and songplaybyuser.uname=u
										GROUP by song.genre
										HAVING  COUNT(song.ID) >= ALL (SELECT  COUNT(song.ID)
                  													   FROM songplaybyuser,song WHERE songplaybyuser.Idsong=song.ID 
                                                                       and songplaybyuser.uname=u
                     													GROUP by song.genre))


/************************  /*   album honarmandani ke ba karbar melliat yeksani darand ra be karbar pishnhad midhd   :13 */
SELECT title,userartist  
from album_realese as a,uuser as s   
WHERE a.userartist=s.username AND 
country= ( select  country  from uuser  WHERE username=' username karbar');

/********************** admin artist hara bar asas mizan faaliat an ha moshahede konad  ***********: 14  */

SELECT album_release.userArtist,COUNT(song.ID) as c
FROM album_release,song
WHERE album_release.ID=song.IDALBUM
GROUP BY album_release.userArtist
ORDER BY c DESC

/*********************************** admin kam faaliat tarin artist hara moshahede mikonad  : 15 */
SELECT album_release.userArtist
FROM album_release,song
WHERE album_release.ID=song.IDALBUM
GROUP by  album_release.userArtist
HAVING    COUNT(song.ID)/ COUNT(album_release.yearrelease)<= 0.03

/************************* admin karbaran mashkook ra moshahede mikonad **********  ziad kamel nist tarjihan aval baqie ***** :16 ss*/
SELECT songplaybyuser.uname       
FROM songplaybyuser,song
WHERE songplaybyuser.Idsong=song.ID AND songplaybyuser.dateplay=CURRENT_DATE  
GROUP BY  songplaybyuser.uname
HAVING  sum(song.duration)>17

/******  az zaman faalitaeshan ha roz hadaqal yek ahang montasher karde and ******* : 17***/

SELECT follow_user.username_follower
FROM songplaybyuser,follow_user,uuser
WHERE songplaybyuser.uname=follow_user.username_followed
AND  follow_user.username_followed=uuser.USERNAME 
GROUP BY songplaybyuser.uname
HAVING COUNT(songplaybyuser.Idsong)>= (DATEDIFF(CURRENT_DATE(), uuser.joindate))
