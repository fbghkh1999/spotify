import mysql.connector
import pymysql
import flask
from flask import request,jsonify,session
from apscheduler.schedulers.background import BackgroundScheduler
import atexit
import hashlib, binascii, os
app = flask.Flask(__name__)
app.config["DEBUG"] = True

config = {
  'user': 'root',
  'password': '',
  'host': '127.0.0.1',
  'database': 'spotify',
  'raise_on_warnings': True
}

cnx = mysql.connector.connect(**config)
if cnx.is_connected():
    print ('sql connected')



#search music
def searchmusic(searchName):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""select title,artistname FROM song  WHERE title like %s"""
    cur.execute(sql,(('%'+searchName+'%',)))
    rv = cur.fetchall()
    return rv
#search album_release
def searchAlbum(searchName1):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""select title,userartist
          FROM album_release 
          WHERE title like %s"""
    cur.execute(sql,(('%'+searchName1+'%',)))
    rv = cur.fetchall()
    return rv

#search playlist
def searchplay_list(searchName2):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""select title
           FROM playlist 
           WHERE title like %s;"""
    cur.execute(sql,(('%'+searchName2+'%',)))
    rv = cur.fetchall()
    return rv
#give folowers
def give_folowers(searchName3):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""SELECT username_followed 
           from follow_user 
            WHERE username_follower=%s"""
    cur.execute(sql,(searchName3,))
    rv = cur.fetchall()
    return rv
#give persons that karbar follow them
def give_folowedbyuser(searchName3):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""SELECT username_followed 
          from follow_user 
         WHERE   username_follower=%s"""

    cur.execute(sql,(searchName3,))
    rv = cur.fetchall()
    return rv   

#give name and userName and familyname
def give_userName(username):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""SELECT username,fname,lname
            FROM uuser
            WHERE username like %s OR fname like %s OR
            lname like %s;"""


    cur.execute(sql,(username,username,username,))
    rv = cur.fetchall()
    return rv 

#session
#album honarmandani ke ba karbar melliat yeksani darand ra be karbar pishnhad midhd
def give_album(name):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""SELECT title,userartist   
           from album_release as a,uuser as s   
           WHERE a.userartist=s.username AND 
           country= ( select  country  from user  WHERE username=%s);"""



    cur.execute(sql,(name,))
    rv = cur.fetchall()
    return rv 

#give best 5 musics on week
def give_musicsweek():
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""SELECT title,artistname 
        FROM song as s ,likedsongbyuser as l 
        WHERE  week(CURRENT_DATE)=week(likedate)
        and s.id =l.idsong
        order by  likedate DESC
        limit 5 ;"""


    cur.execute(sql)
    rv = cur.fetchall()
    return rv 

# karbaran qader  b didn 5 ahang jadid montasher shode tavasot honarmand follow  shode eshn hastand
def give_musicnew(username):
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""select title,userartist  
           from album_release,follow_user
           WHERE username_follower=%s AND userartist=username_followed
           ORDER BY yearrelease DESC
           limit 5; """


    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv 

# delete karbari ke primium expire shode
#onvar naneveshtam
def delete_expire_account():
    cur = cnx.cursor()
    #get musicname from karbar
    sql="""
    DELETE FROM buypermium 
    WHERE  expired=CURRENT_DATE ;  """
scheduler = BackgroundScheduler()
scheduler.add_job(func=delete_expire_account, trigger="interval", seconds=60)
scheduler.start()
atexit.register(lambda: scheduler.shutdown())

# Shut down the scheduler when exiting the app
#show profile karbar
def give_profile(username):
    cur = cnx.cursor()
    
    sql="""SELECT uuser.USERNAME ,uuser.Fname,uuser.Lname,playlist.Title,playlist.lastediddate,COUNT(song.ID)
        from createplaylist_user,playlisthassong,playlist,uuser,song
      WHERE uuser.USERNAME=createplaylist_user.uname AND playlisthassong.Idplaylist=createplaylist_user.Idplaylist AND playlisthassong.Idsong=song.ID
      AND playlisthassong.Idplaylist=playlist.ID AND
      uuser.USERNAME=%s 
      GROUP BY playlist.ID"""
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv 
#tedad follower haie karbar
def give_tedadfollowers(username):
    cur = cnx.cursor()
    
    sql="""SELECT COUNT(follow_user.username_follower)
     FROM follow_user
    WHERE follow_user.username_followed=%s
    GROUP BY follow_user.username_followed
    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv 

#tedad following haie karbar
def give_tedadfollowing(username):
    cur = cnx.cursor()
    
    sql="""SELECT COUNT(follow_user.username_followed)
           FROM follow_user
           WHERE follow_user.username_follower=%s
           GROUP BY follow_user.username_follower
    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv 

#zhanr qaleb honarmnd
def give_zhanrgaleb(username):
    cur = cnx.cursor()
    
    sql="""SELECT album_release.genre     
           FROM album_release
           WHERE  album_release.userArtist=%s
           GROUP BY album_release.genre
           HAVING COUNT (album_release.ID) >= ALL ( SELECT COUNT (album_release.ID)
					FROM album_release
					WHERE  album_release.userArtist=%s
				        GROUP BY album_release.genre)
"""

   
    cur.execute(sql,(username,username,))
    rv = cur.fetchall()
    return rv 
#onvan va sal enteshar album haie honarmand
def give_onvan_andYearofRelease(username):
    cur = cnx.cursor()
    
    sql="""SELECT album_release.title,album_release.yearrelease
           FROM album_release
           WHERE album_release.userArtist=%s

    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv  

#ahang haie mahboob honarmand
def ahang_favor_artist (username):
    cur = cnx.cursor()
    
    sql="""
     SELECT DISTINCT(song.title)
     FROM song 
     INNER JOIN songplaybyuser ON songplaybyuser.Idsong=song.ID
     INNER JOIN likedsongbyuser ON likedsongbyuser.Idsong=song.ID
     WHERE song.Artistname=%s
     LIMIT 10;

    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv
# realize honarmand
def isArtist (username):
    cur = cnx.cursor()
    
    sql="""
     SELECT artist.username
     FROM artist 
     WHERE artist.Accepted=1 AND artist.username=%s;

    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv
#show playlist and musics in
def showPlsylistAndMusics (username):
    cur = cnx.cursor()
    
    sql="""
    SELECT song.title,song.duration,playlisthassong.adddate
    from playlist,song,playlisthassong
    where  playlisthassong.Idplaylist=playlist.ID AND
    song.ID=playlisthassong.Idsong
    and playlist.Title=%s

    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv
#show  Album and musics init
def showAlbumAndMusics (username):
    cur = cnx.cursor()
    
    sql="""
    select song.title as songname , song.duration,album_release.yearrelease,album_release.title as albumname
    FROM  song ,album_release 
    WHERE song.IDALBUM=album_release.ID
    AND album_release.title=%s

    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv

#show  last musics that follower listen
def givelastmusicOf_Follower (username):
    cur = cnx.cursor()
    
    sql="""
    SELECT follow_user.username_followed as yourfollowig,max(songplaybyuser.dateplay)as lastplay,song.title as namemusic
    FROM songplaybyuser,follow_user,song
    WHERE songplaybyuser.uname=follow_user.username_followed and follow_user.username_follower=%s AND songplaybyuser.Idsong=song.ID
    GROUP BY follow_user.username_followed
    """
    cur.execute(sql,(username,))
    rv = cur.fetchall()
    return rv
#session
#give zhanr ghaleb honarmand favor artist
def give_favorArtist ():
    cur = cnx.cursor(name)
    
    sql="""
    SELECT   song.Artistname 
    FROM playlisthassong,song,createplaylist_user
    WHERE playlisthassong.Idsong=song.ID and createplaylist_user.Idplaylist=playlisthassong.Idplaylist
    and createplaylist_user.uname=%s 
    GROUP by song.Artistname
    HAVING  COUNT(song.ID) >= ALL (SELECT  COUNT(song.ID) as c
                  FROM playlisthassong,song,createplaylist_user
                    WHERE playlisthassong.Idsong=song.ID and createplaylist_user.Idplaylist=playlisthassong.Idplaylist
                     and createplaylist_user.uname=%s 
                      GROUP by song.Artistname)
    """
    cur.execute(sql,(name,name,))
    rv = cur.fetchall()
    return rv
#edame query baray pishnahad karbar digar ba tavajo be zhanr honarmand mahboob
def giveartist1 (natije):
    cur = cnx.cursor()
    
    sql="""
    SELECT album_release.genre  
   FROM album_release 
   WHERE album_release.userArtist=%s
   GROUP by album_release.genre
   HAVING COUNT(album_release.genre) >= ALL (SELECT COUNT(album_release.genre)
   FROM album_release 
   WHERE album_release.userArtist=%s
   GROUP by album_release.genre)
    """
    cur.execute(sql,(natije,natije,))
    rv = cur.fetchall()
    return rv

#edame query baray pishnahad karbar digar ba tavajo be zhanr honarmand mahboob
def giveartistnahaii (natije1,natije2):
    cur = cnx.cursor()
    
    sql="""
    SELECT album_release.userArtist
    FROM album_release 
    where album_release.userArtist <> %s and album_release.genre=%s
   ORDER by album_release.userArtist
   limit 1;
    """
    cur.execute(sql,(natije1,natije2,))
    rv = cur.fetchall()
    return rv
#session
#peyda kardan zhanrmahboob karbar suggest 5 music
def give_user_zhanr (name):
    cur = cnx.cursor()
    
    sql="""
     SELECT   song.genre 
     FROM songplaybyuser,song
     WHERE songplaybyuser.Idsong=song.id and songplaybyuser.uname=%s 
     GROUP by song.genre
     HAVING  COUNT(song.ID) >= ALL (SELECT  COUNT(song.ID)
                               FROM songplaybyuser,song
                               WHERE songplaybyuser.Idsong=song.ID and songplaybyuser.uname=%s 
                               GROUP by song.genre)

    """
    cur.execute(sql,(name,name,))
    rv = cur.fetchall()
    return rv
#session
#peyda kardan zhanrmahboob karbar suggest 5 music part2
def suggest_music1 (natije1,name):
    cur = cnx.cursor()
    
    sql="""
    SELECT song.title,COUNT(song.ID) as numberoflike  
    FROM song,likedsongbyuser
    WHERE  song.genre=%s 
    AND song.ID=likedsongbyuser.Idsong 
                     and song.title not in( select song.title from song,songplaybyuser
                                                WHERE songplaybyuser.Idsong=song.ID  
                                                and songplaybyuser.uname=%s
                                                and  song.genre=%s)

    GROUP BY song.title                                                         
    ORDER BY  numberoflike DESC  
    limit 5;

    """
    cur.execute(sql,(natije1,name,natije1,))
    rv = cur.fetchall()
    return rv
#session
#peyda kardan zhanrmahboob karbar suggest 5 music part2
def suggest_music2 (natije1,name):
    cur = cnx.cursor()
    
    sql="""
    SELECT song.title         
     FROM album_release,song
     where  album_release.Id=song.IDalbum  AND song.genre=%s
     AND (week(album_release.yearrelease)=week(CURRENT_DATE)-1 
     or week(album_release.yearrelease)=week(CURRENT_DATE))    
     and song.title not in( select song.title from song,songplaybyuser WHERE songplaybyuser.Idsong=song.ID  
             and songplaybyuser.uname=%s and  song.genre=%s) 
     LIMIT 5;

    """
    cur.execute(sql,(natije1,name,natije1,))
    rv = cur.fetchall()
    return rv


#session
#genre qaleb artist  & peyda kardan fan  haie  artist 
def zhanr_artist (name):
    cur = cnx.cursor()
    
    sql="""
    SELECT album_release.genre    
     FROM album_release
     WHERE  album_release.userArtist=%s
     GROUP BY album_release.genre
    HAVING COUNT(album_release.ID) >= ALL ( SELECT COUNT(album_release.ID)
					FROM album_release
					WHERE  album_release.userArtist=%s
				        GROUP BY album_release.genre)



    """
    cur.execute(sql,(name,name,))
    rv = cur.fetchall()
    return rv
#session
#genre qaleb artist  & peyda kardan fan  haie  artist 2
def fan_artist (name,natije):
    cur = cnx.cursor()
    
    sql="""
   SELECT songplaybyuser.uname as u
FROM songplaybyuser,song
WHERE song.ID=songplaybyuser.Idsong AND  song.Artistname=%s
GROUP by songplaybyuser.uname 
HAVING  COUNT(song.ID) >10 AND  %s=(SELECT   song.genre
										FROM songplaybyuser,song
										WHERE song.ID=songplaybyuser.Idsong and songplaybyuser.uname=u
										GROUP by song.genre
										HAVING  COUNT(song.ID) >= ALL (SELECT  COUNT(song.ID)
                  													   FROM songplaybyuser,song WHERE songplaybyuser.Idsong=song.ID 
                                                                       and songplaybyuser.uname=u
                     													GROUP by song.genre))


    """
    cur.execute(sql,(name,natije,))
    rv = cur.fetchall()
    return rv

#session
#admin artist hara bar asas mizan faaliat an ha moshahede konad
def showArtist_admin ():
    cur = cnx.cursor()
    username='admin'
    if username=='admin':
          sql="""
  
            SELECT album_release.userArtist,COUNT(song.ID) as c
            FROM album_release,song
            WHERE album_release.ID=song.IDALBUM
            GROUP BY album_release.userArtist
            ORDER BY c DESC

    """
    cur.execute(sql)
    rv = cur.fetchall()
    return rv

#admin kam faaliat tarin artist hara moshahede mikonad
def show_lessActivityAdmin ():
    cur = cnx.cursor()
    username='admin'
    if username=='admin':
          sql="""
  
            SELECT album_release.userArtist
            FROM album_release,song
            WHERE album_release.ID=song.IDALBUM
            GROUP by  album_release.userArtist
            HAVING    COUNT(song.ID)/ COUNT(album_release.yearrelease)<= 0.03


    """
    cur.execute(sql)
    rv = cur.fetchall()
    return rv


#admin karbaran mashkook ra moshahede mikonad
def mashkok_admin ():
    cur = cnx.cursor()
    username='admin'
    if username=='admin':
          sql="""
  
    SELECT songplaybyuser.uname       
    FROM songplaybyuser,song
    WHERE songplaybyuser.Idsong=song.ID AND songplaybyuser.dateplay=CURRENT_DATE  
    GROUP BY  songplaybyuser.uname
     HAVING  sum(song.duration)>17


    """
    cur.execute(sql)
    rv = cur.fetchall()
    return rv

#session
#az zaman faalitaeshan ha roz hadaqal yek ahang montasher karde and

def enteshar_EveryDay ():
    cur = cnx.cursor()
    username='admin'
    if username=='admin':
          sql="""
  
  SELECT DISTINCT(follow_user.username_follower)
FROM songplaybyuser,follow_user,uuser
WHERE songplaybyuser.uname=follow_user.username_followed
AND  follow_user.username_followed=uuser.USERNAME 
AND follow_user.username_followed IN(SELECT songplaybyuser.uname
                            FROM songplaybyuser,uuser
                            WHERE uuser.USERNAME=songplaybyuser.uname
                            GROUP BY uuser.USERNAME
                            HAVING COUNT(songplaybyuser.Idsong)>= (DATEDIFF(CURRENT_DATE(),uuser.joindate)))

    """
    cur.execute(sql)
    rv = cur.fetchall()
    return rv



# vaqti kasi mikhad yki dgro follow kone 
def doing_follow (name,me):
    cur = cnx.cursor()
   
    sql="""
  
    INSERT INTO follow_user (follow_user.username_followed, follow_user.username_follower, follow_user.Fdate)
    VALUES (%s, %s, CURRENT_DATE);

    """
    cur.execute(sql,(name,me))
    cnx.commit()

#session
# vqti mikhad unfollow kone
def doing_unfollow (name,me):
    cur = cnx.cursor()
   
    sql="""
  DELETE FROM follow_user WHERE follow_user.username_followed=%s AND follow_user.username_follower=%s;


    """
    cur.execute(sql,(name,me))
    cnx.commit()

#session #test nashod
#  vaqti mikhad ahang goosh bede
def listen_music(name,name1,name2):
    cur = cnx.cursor()
   
    sql="""
   INSERT INTO songplaybyuser (songplaybyuser.uname,songplaybyuser.Idsong,songplaybyuser.dateplay)
VALUES (%s,(SELECT song.ID FROM song WHERE song.title=%s AND song.Artistname=%s),CURRENT_DATE);



    """
    cur.execute(sql,(name,name1,name2))
    cnx.commit()

#  sign in check kardan uiniqe bodan maghadir
def signin_check_username(name1):
    cur = cnx.cursor()
   
    sql="""
     SELECT uuser.USERNAME FROM uuser WHERE uuser.USERNAME=%s 
    """
    cur.execute(sql,(name1,))
    rv = cur.fetchall()
    return rv

  

 #  sign in check kardan uiniqe bodan maghadir
def signin_check_email(name2):
    cur = cnx.cursor()
    sql="""
    SELECT uuser.USERNAME FROM uuser WHERE uuser.email=%s
    """
    cur.execute(sql,(name2,))
    rv = cur.fetchall()
    return rv
 
    
#hash
def hash_password(password):
    """Hash a password for storing."""
    salt = hashlib.sha256(os.urandom(60)).hexdigest().encode('ascii')
    pwdhash = hashlib.pbkdf2_hmac('sha512', password.encode('utf-8'),
                                salt, 100000)
    pwdhash = binascii.hexlify(pwdhash)
    return (salt + pwdhash).decode('ascii')

#  store etelat karbar
def signin_saving(username,email,password,country,fname,lname):
    cur = cnx.cursor()
   
    sql="""
   INSERT INTO uuser (uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
   VALUES (%s,%s,%s,%s,%s,%s,CURRENT_DATE);
    """
    cur.execute(sql,(username,email,password,country,fname,lname,))
    cnx.commit() 

# add to listener table
def addto_listener(username,birthdate):
    cur = cnx.cursor()
   
    sql="""
  INSERT INTO listener (listener.USERNAME,listener.birth_date)
  VALUES (%s,%s); 
    """
    cur.execute(sql,(username,birthdate,))
    cnx.commit() 

# add to artist table
def addto_artist(username,yearbegin):
    cur = cnx.cursor()
   
    sql="""
    INSERT INTO artist (artist.USERNAME,artist.year_begin,artist.Accepted)  
    VALUES (%s,%s,3);
    """
    cur.execute(sql,(username,yearbegin,))
    cnx.commit() 

#  show questions
def show_questions():
    cur = cnx.cursor()
   
    sql="""
    SELECT question.Q,question.id
    FROM question
    """
    cur.execute(sql)
    rv = cur.fetchall()
    return rv

# save reply
def saveto_reply(username,idreply,reply):
    cur = cnx.cursor()
   
    sql="""
    INSERT INTO reply (reply.uname, reply.Id, reply.reply)
    VALUES (%s,%s,%s);
    """
    cur.execute(sql,(username,idreply,reply,))
    cnx.commit() 

# show qustion karbar baray taghir passs
def changepass_showquestions(name):
    cur = cnx.cursor()
   
    sql="""
    SELECT question.Q
    FROM question,reply
    WHERE reply.Id=question.ID
    AND reply.uname=%s  

    """
    cur.execute(sql,(name,))
    rv = cur.fetchall()
    return rv
#check reply of user
def checkuser_answer(name):
    cur = cnx.cursor()
   
    sql="""
    SELECT reply.reply
    FROM reply
    WHERE reply.uname=%s

    """
    cur.execute(sql,(name,))
    rv = cur.fetchall()
    return rv

 #update pass
def passwordnew(password,username):
    cur = cnx.cursor()
   
    sql="""
    update uuser
    set uuser.password=%s
    where uuser.username=%s
    """
    cur.execute(sql,(password,username,))
    cnx.commit() 
    
#login check pass
def checkpass_login(name):
    cur = cnx.cursor()
   
    sql="""
    SELECT uuser.password
    FROM uuser
    WHERE uuser.USERNAME=%s

    """
    cur.execute(sql,(name,))
    rv = cur.fetchall()
    return rv

#shart follow
def checkfollow(name,name2):
    cur = cnx.cursor()
   
    sql="""
    SELECT IF(NOT EXISTS (SELECT follow_user.username_followed
                      FROM follow_user
                      WHERE follow_user.username_follower=%s
                     AND follow_user.username_followed=%s),"Yes","No");

    """
    cur.execute(sql,(name,name2))
    rv = cur.fetchall()
    return rv


#shart unfollow
def checkunfollow(name,name2):
    cur = cnx.cursor()
   
    sql="""
     SELECT IF( EXISTS (SELECT follow_user.username_followed
                      FROM follow_user
                      WHERE follow_user.username_follower=%s
                     AND follow_user.username_followed=%s),"Yes","No");
    """
    cur.execute(sql,(name,name2))
    rv = cur.fetchall()
    return rv

#check ahang
def checkmusic(name):
    cur = cnx.cursor()
   
    sql="""
     SELECT if(NOT EXISTS(SELECT songplaybyuser.uname
               FROM songplaybyuser
              WHERE songplaybyuser.dateplay=CURRENT_DATE
               AND songplaybyuser.uname=%s
              AND songplaybyuser.uname NOT IN(SELECT buypermium.uname
                                              FROM buypermium)
              GROUP BY songplaybyuser.uname
              HAVING COUNT(songplaybyuser.Idsong)=5),"Yes","No");
    """
    cur.execute(sql,(name,))
    rv = cur.fetchall()
    return rv


#check make playlist
def checkplaylist(name):
    cur = cnx.cursor()
   
    sql="""
     SELECT if(NOT EXISTS(SELECT createplaylist_user.uname
               FROM createplaylist_user
              WHERE createplaylist_user.Createdate=CURRENT_DATE
               AND createplaylist_user.uname=%s
              AND createplaylist_user.uname NOT IN(SELECT buypermium.uname
                                              FROM buypermium)
              GROUP BY createplaylist_user.uname
              HAVING COUNT(createplaylist_user.Idplaylist)=5),"Yes","No");
    """
    cur.execute(sql,(name,))
    rv = cur.fetchall()
    return rv

#make playlist
def makeplaylist(title,name):
    cur = cnx.cursor()
   
    sql="""INSERT INTO playlist (playlist.Title,playlist.lastediddate) VALUES (%s,CURRENT_DATE);"""
 
    sql2="""SET @lastid= LAST_INSERT_ID(); """
    sql3="""INSERT INTO createplaylist_user (createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
 VALUES (@lastid,%s,CURRENT_DATE);
"""

    cur.execute(sql,(title,))
    cur.execute(sql2)
    cur.execute(sql3,(name,))
    cnx.commit() 

#add music to playlist
def addmusic_playlist(musicname,artistname,username,playlistname):
    cur = cnx.cursor()
   
    sql="""
     INSERT into playlisthassong (playlisthassong.Idsong,playlisthassong.Idplaylist,playlisthassong.Adddate)
    VALUES((SELECT song.ID FROM song WHERE song.title=%s AND song.Artistname=%s),
    (SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname=%s
     AND  playlist.Title=%s),CURRENT_DATE);
    """
    cur.execute(sql,(musicname,artistname,username,playlistname))
    cnx.commit() 


#hazf music from playlist
def deletemusic_playlist(musicname,artistname,username,playlistname):
    cur = cnx.cursor()
   
    sql="""
     DELETE FROM playlisthassong WHERE playlisthassong.Idsong=(SELECT song.ID FROM song WHERE song.title=%s AND song.Artistname=%s)
     AND playlisthassong.Idplaylist= (SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname=%s
     AND  playlist.Title=%s);
    """
    cur.execute(sql,(musicname,artistname,username,playlistname))
    cnx.commit() 

#like music
def likemusic(username,nameofmusic,artistname):
    cur = cnx.cursor()
   
    sql="""
       INSERT INTO likedsongbyuser(likedsongbyuser.uname,likedsongbyuser.Idsong,likedsongbyuser.likedate)
       VALUES (%s,(SELECT song.ID FROM song WHERE song.title=%s AND song.Artistname=%s),CURRENT_DATE);

    """
    cur.execute(sql,(username,nameofmusic,artistname))
    cnx.commit() 

#unlike music
def unlikemusic(username,nameofmusic,artistname):
    cur = cnx.cursor()
   
    sql="""
       DELETE FROM likedsongbyuser 
      WHERE likedsongbyuser.uname=%s 
     AND likedsongbyuser.Idsong=(SELECT song.ID FROM song WHERE song.title=%s AND song.Artistname=%s);


    """
    cur.execute(sql,(username,nameofmusic,artistname))
    cnx.commit() 

#gozaresh mohtavay namonaseb
def badmohtavaReport(username,nameofmusic,artistname,text):
    cur = cnx.cursor()
   
    sql="""
      INSERT INTO userreports (userreports.uname,userreports.Idsong,userreports.rtype)
     VALUES (%s, (SELECT song.ID FROM song WHERE song.title=%s AND song.Artistname=%s),%s);


    """
    cur.execute(sql,(username,nameofmusic,artistname,text,))
    cnx.commit() 


#like playlist
def likeplylist(username,usernamebuilderPlayList,nameofplayList):
    cur = cnx.cursor()
   
    sql="""
      INSERT INTO likedplaylistbyuser(likedplaylistbyuser.uname,likedplaylistbyuser.Idplaylist,likedplaylistbyuser.likedate)
      VALUES (%s,(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname=%s
      AND  playlist.Title=%s),CURRENT_DATE);



    """
    cur.execute(sql,(username,usernamebuilderPlayList,nameofplayList,))
    cnx.commit() 

#unlike playlist
def unlikeplylist(username,usernamebuilderPlayList,nameofplayList):
    cur = cnx.cursor()
   
    sql="""
      DELETE FROM likedplaylistbyuser 
     WHERE likedplaylistbyuser.uname=%s
    AND likedplaylistbyuser.Idplaylist=(SELECT playlist.ID  FROM playlist,createplaylist_user WHERE playlist.ID=createplaylist_user.Idplaylist AND createplaylist_user.uname=%s
     AND  playlist.Title=%s);


    """
    cur.execute(sql,(username,usernamebuilderPlayList,nameofplayList,))
    cnx.commit() 

# playlist eshteraki
def makeplaylisteshteraki(username,nameofplayList,username2):
    cur = cnx.cursor()
    result=' '
    sql="""
     SELECT playlist.ID FROM playlist,createplaylist_user WHERE createplaylist_user.Idplaylist=playlist.ID AND createplaylist_user.uname=%s
        AND playlist.Title=%s
    """
    cur.execute(sql,(username,nameofplayList,))
    rv=cur.fetchall()
    for roe in rv:
        result=roe[0]
    sql2="""
     INSERT INTO createplaylist_user(createplaylist_user.Idplaylist,createplaylist_user.uname,createplaylist_user.Createdate)
     VALUES(%s,%s,CURRENT_DATE);
    """
   
    cur.execute(sql2,(result,username2,))
    cnx.commit() 

# release Album
def albumrelease(albumname,date,genre,username,titlesong,songduration,songgenre):
    cur = cnx.cursor()
    result=' '
    sql="""
     INSERT INTO album_release(album_release.title,album_release.yearrelease,album_release.genre,album_release.userArtist)
    VALUES(%s,%s,%s,%s);
    """

    sql2="""
     SET @lastid= LAST_INSERT_ID();
    """
    sql3=""" INSERT INTO song (song.title,song.duration,song.Artistname,song.IDALBUM,song.genre)  
          VALUES(%s,%s,%s,@lastid,%s);"""
    cur.execute(sql,(albumname,date,genre,username,))
    cur.execute(sql2)
    cur.execute(sql3,(titlesong,songduration,username,songgenre,))
     
    cnx.commit() 

#darkhast delete album
def deletealbum(username,nameofalbum):
    cur = cnx.cursor()
    result=' '
    sql="""
    DELETE FROM album_release   WHERE album_release.title=%s AND album_release.userArtist=%s;
    """
    
   
    cur.execute(sql,(nameofalbum,username,))
    cnx.commit() 

#darkhast delete ahang az album
def deletemusicfromalbum1(nameofalbum1,nameofmusic1,username1):
    cur = cnx.cursor()
    result=' '
    sql="""
    DELETE FROM song WHERE song.title=%s AND 
    song.IDALBUM = (select album_release.ID from album_release 
                  WHERE album_release.title=%s
                  and album_release.userArtist=%s);

    """
    
   
    cur.execute(sql,(nameofmusic1,nameofalbum1,username1,))
    cnx.commit() 

#show artist to taiid
def show_artistnotconfirm():
    cur = cnx.cursor()
    result=' '
    sql="""
    SELECT artist.username   
    FROM artist 
    WHERE artist.Accepted=3;
    """
   
    cur.execute(sql)
    rv=cur.fetchall()
    return rv 

#taiid artist
def confirmartist(name):
    cur = cnx.cursor()
    result=' '
    sql="""
    UPDATE artist
    SET artist.Accepted = 1
   WHERE  artist.USERNAME=%s;


    """
    
   
    cur.execute(sql,(name,))
    cnx.commit()


#adam taiid
def notconfirmartist(name):
    cur = cnx.cursor()
    result=' '
    sql="""
    DELETE FROM artist WHERE artist.USERNAME=%s  ;

    """
    
   
    cur.execute(sql,(name,))
    cnx.commit()

#delete user from ststem
def deletuser(name):
    cur = cnx.cursor()
    result=' '
    sql="""
   DELETE FROM uuser WHERE uuser.USERNAME=%s;

    """
    
   
    cur.execute(sql,(name,))
    cnx.commit()
#delete playlist
def deletplaylist_admin(nameofsazande,nameplaylist):
    cur = cnx.cursor()
    result=' '
    sql="""
      DELETE FROM playlist WHERE playlist.ID=(SELECT playlist.ID FROM playlist,createplaylist_user WHERE createplaylist_user.Idplaylist=playlist.ID AND createplaylist_user.uname=%s
        AND playlist.Title=%s);


    """
    
   
    cur.execute(sql,(nameofsazande,nameplaylist))
    cnx.commit()
                        
#delete album
def deletealbum_admin(nameofartistalbum,nameofalbum):
    cur = cnx.cursor()
    result=' '
    sql="""
     DELETE FROM album_release WHERE album_release.userArtist=%s AND album_release.title=%s;

    """
    
   
    cur.execute(sql,(nameofartistalbum,nameofalbum))
    cnx.commit()

#show reports
def shoereportsAdmin():
    cur = cnx.cursor()
    result=' '
    sql="""
     SELECT song.title
FROM userreports,song
WHERE userreports.Idsong=song.ID
    """
    
   
    cur.execute(sql)
    rv=cur.fetchall()
    return rv

#delsong byadmin
def delsongadmin(namemusic,nameartist):
    cur = cnx.cursor()
    result=' '
    sql="""
     DELETE FROM song WHERE song.title=%s And song.Artistname=%s ;

    """
    
   
    cur.execute(sql,(namemusic,nameartist,))
    cnx.commit()

#show eshterakha
def eshterakha():
    cur = cnx.cursor()
    result=' '
    sql="""
     SELECT eshterak.cost,eshterak.periodd,eshterak.ID
     FROM eshterak;

    """
    
   
    cur.execute(sql)
    rv=cur.fetchall()
    return rv

#kharideshterak
def buyeshterak(id1,username):
    cur = cnx.cursor()
    result=' '
    sql="""
     INSERT INTO buypermium(buypermium.uname,buypermium.id,buypermium.datebuy,buypermium.Expired)
    VALUES(%s,%s,CURRENT_DATE,DATE_ADD(CURRENT_DATE, INTERVAL (SELECT periodd FROM eshterak WHERE id=%s) day));


    """
    
   
    cur.execute(sql,(username,id1,id1,))
    cnx.commit()

#suggest music to everyplaylist
def suggestmusic_playlist(shomarande):
    cur = cnx.cursor()
    result=' '
    sql="""
      SELECT IF( EXISTS(SELECT  playlist.ID
           FROM playlist
           WHERE playlist.ID=%s),( SELECT song.genre FROM song,playlisthassong,playlist
                                       WHERE song.ID=playlisthassong.Idsong  AND playlisthassong.Idplaylist=playlist.ID
                                        AND playlist.ID=%s
                                        GROUP BY song.genre
                                           HAVING COUNT(song.ID) >= ALL ( SELECT COUNT(song.ID)
                                                                        FROM song,playlisthassong,playlist
                                                                        WHERE song.ID=playlisthassong.Idsong  AND playlisthassong.Idplaylist=playlist.ID
                                                                             AND playlist.ID=%s
                                                                              GROUP BY song.genre )),'No');


    """
    
   
    cur.execute(sql,(shomarande,shomarande,shomarande,))
    rv=cur.fetchall()
    return rv

def giveid(genre):
    cur = cnx.cursor()
    result=' '
    sql="""
      SELECT song.ID
FROM song
WHERE song.genre=%s
LIMIT 2;
    """
    
   
    cur.execute(sql,(shomarande,shomarande,shomarande,))
    rv=cur.fetchall()
    return rv