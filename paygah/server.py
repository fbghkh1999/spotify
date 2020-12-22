import mysql.connector
import pymysql
import flask
from flask import request,jsonify,session
import query as q
from flask import abort
from flask import render_template
from apscheduler.schedulers.background import  BackgroundScheduler
from flask_mail import Mail, Message


app = flask.Flask(__name__,template_folder='templates')
app.config["DEBUG"] = True
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'
cron =  BackgroundScheduler(daemon=True)
mail= Mail(app)
# Explicitly kick off the background thread
cron.start()

'''config = {
  'user': 'root',
  'password': '',
  'host': '127.0.0.1',
  'database': 'spotify',
  'raise_on_warnings': True
}

cnx = mysql.connector.connect(**config)
#conn = pymysql.connect(host='localhost', port=8080, db='spotify')

if cnx.is_connected():
    print ('sql connected')
'''
app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'f.baghkhani1@gmail.com'
app.config['MAIL_PASSWORD'] = '2981085451'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail = Mail(app)

@app.route("/sendmail")
def index():
   
        msg = Message('Hello', sender = 'f.baghkhani1@gmail.com', recipients = ['mahdavi.nazanin77@gmail.com'])
        msg.body = "your accepted!"
        mail.send(msg)

  
        return "Sent"
@app.route('/search', methods=['POST'])
def home():
    '''cur = cnx.cursor()
    cur.execute("SELECT * FROM artist")
    rv = cur.fetchall()'''
    searchName=request.form['searchName']
    rv=q.searchmusic(searchName)
    rv1=q.searchAlbum(searchName)
    rv2=q.searchplay_list(searchName)

    payload = []
    payload1= []
    payload2= []
    content = {}
    content2 = {}
    content3 = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'title': result[0], 'artistName': result[1]}
       payload.append(content)
       content = {}
    for result1 in rv1:
       content2 = {'title': result1[0], 'userArtist': result1[1]}
       payload.append(content2)
       content2 = {}
    for result2 in rv2:
       content3 = {'title': result2[0]}
       payload.append(content3)
       content3 = {}
    return jsonify(payload)


#give folowers
@app.route('/givefolowers', methods=['POST'])
def home1():
    '''cur = cnx.cursor()
    cur.execute("SELECT * FROM artist")
    rv = cur.fetchall()'''
    try:
     id1=request.form['id1']
     rv=q.give_folowers(id1)
     payload = []
     content = {}
     follower=''
     for row in rv:
        print('lll')
        follower=row[0]
     if len(follower)==0:
         abort(404)
        
     else:
       for result in rv:
            content = {'username_followed': result[0]}
            payload.append(content)
            content = {}
       return jsonify(payload)
    except  Exception as e:
        return flask.Response('errrr',404)


       # return jsonify('your data is invalid or doesnt exist')



#give username
@app.route('/users1', methods=['POST'])
def home4():
    '''cur = cnx.cursor()
    cur.execute("SELECT * FROM artist")
    rv = cur.fetchall()'''
    id1=request.form['id1']
    rv=q.give_userName(id1)
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'username': result[0],'fname':result[1],'lname':result[2]}
       payload.append(content)
       content = {}
    return jsonify(payload)



#give album honarmandani ke ba karbar melliat yeksani darand ra be karbar pishnhad midhd
@app.route('/album', methods=['GET'])
def home5():
    '''cur = cnx.cursor()
    cur.execute("SELECT * FROM artist")
    rv = cur.fetchall()'''
    username=session.get('username')
    rv=q.give_album(username)
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'title': result[0],'userartist':result[1]}
       payload.append(content)
       content = {}
    return jsonify(payload)



#give best 5 musics on week
@app.route('/musicsweek', methods=['GET'])
def home6():
    '''cur = cnx.cursor()
    cur.execute("SELECT * FROM artist")
    rv = cur.fetchall()'''
    rv=q.give_musicsweek()
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'title': result[0],'artistname':result[1]}
       payload.append(content)
       content = {}
    return jsonify(payload)   




# karbaran qader  b didn 5 ahang jadid montasher shode tavasot honarmand follow  shode eshn hastand
@app.route('/musicsnew', methods=['POST'])
def home7():
    '''cur = cnx.cursor()
    cur.execute("SELECT * FROM artist")
    rv = cur.fetchall()'''
    id1=request.form['id1']
    rv=q.give_musicnew(id1)
    
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'title': result[0],'user artist':result[1]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#request for see profile karbar
@app.route('/profile', methods=['POST'])
def home8():
    tedadFollowing=0
    tedadFollowers=0
    id1=request.form['id1']
    rv=q.give_profile(id1)
    rv1=q.give_tedadfollowers(id1)
    rv2=q.give_tedadfollowing(id1)
    isartist=q.isArtist(id1)
    
    artist=None
    payload = []
    content = {}
    for row in rv1:
      tedadFollowers=row[0]
    for row in rv2:
      tedadFollowing=row[0]
    for row in isartist:
        artist=row[0]
       
    if artist is not None:
        title1=''
        year_release=''
        titlefavor=''

        
        zhanrghaleb=q.give_zhanrgaleb(id1)
        titleYearofRelease=q.give_onvan_andYearofRelease(id1)
        favormusic=q.ahang_favor_artist(id1)
        for row in zhanrghaleb:
            zhanrghaleb=row[0]
        for row in titleYearofRelease:
            title1=row[0]
            year_release=row[1]
        for row in favormusic:
            titlefavor=row[0]
        for result in rv:
            content = {'username': result[0],'Fname':result[1],'lName':result[2],'title playlist':result[3],'lastediddate of playlist':result[4],'count of song':result[5],'tedadFollowing':tedadFollowing,
           'tedadFollowers':tedadFollowers,'zhanr ghaleb':zhanrghaleb,'title_release':title1,'year_release':year_release,
           'favormusic':titlefavor}
            payload.append(content)
            content = {}
    else:
     for result in rv:
            content = {'username': result[0],'Fname':result[1],'lName':result[2],'title playlist':result[3],'lastediddate of playlist':result[4],'count of song':result[5],'tedadFollowing':tedadFollowing,
           'tedadFollowers':tedadFollowers}
            payload.append(content)
            content = {}
    return jsonify(payload) 


#request for tedad follower haie karbar
@app.route('/tedadFollower', methods=['POST'])
def home9():
    
    id1=request.form['name']
    rv=q.give_tedadfollowers(id1)
    
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'count': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#request for tedad following haie karbar
@app.route('/tedadFollowing', methods=['POST'])
def home10():
    
    id1=request.form['name']
    rv=q.give_tedadfollowing(id1)
    
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'count': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload) 


#zhanr qaleb honarmnd
@app.route('/zhanrghaleb', methods=['POST'])
def home11():
    
    id1=request.form['name']
    rv=q.give_zhanrgaleb(id1)
    
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'zhanr': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#onvan va sal enteshar album haie honarmand
@app.route('/title and year of release', methods=['POST'])
def home12():
    
    id1=request.form['name']
    rv=q.give_onvan_andYearofRelease(id1)
    
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'title_release': result[0],'year_release':result[1]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#ahang haie mahboob honarmand
@app.route('/ahanghay favor artist', methods=['POST'])
def home13():
    
    id1=request.form['name']
    rv=q.ahang_favor_artist(id1)
    
    payload = []
    content = {}
    for row in rv:
        print('lll')
        print(row)
    for result in rv:
       content = {'song_title': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#give persons that followed by user
@app.route('/followed', methods=['POST'])
def home14():
    
    id1=request.form['name']
    rv=q.give_folowedbyuser(id1)
    
    payload = []
    content = {}
    for row in rv:
        
        print(row)
    for result in rv:
       content = {'username_followed': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#show playlist and musics in
@app.route('/ShowPlayListWithMusics', methods=['POST'])
def home15():
    
    id1=request.form['name']
    rv=q.showPlsylistAndMusics(id1)
    
    payload = []
    content = {}
    for row in rv:
        
        print(row)
    for result in rv:
       content = {'song title': result[0],'song duration':str(result[1]),'playlisthassong adddate':result[2]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#show Album and musics in
@app.route('/ShowAlbumWithMusics', methods=['POST'])
def home16():
    
    id1=request.form['name']
    rv=q.showAlbumAndMusics(id1)
    
    payload = []
    content = {}
    for row in rv:
        
        print(row)
    for result in rv:
       content = {'song title': result[0],'song duration':str(result[1]),'album_releaseDate':result[2],'album_title':result[3]}
       payload.append(content)
       content = {}
    return jsonify(payload) 

#show lastmusic of myFollower
@app.route('/lastmusicOfMyFollower', methods=['POST'])
def home17():
    
    id1=request.form['name']
    rv=q.givelastmusicOf_Follower(id1)
    
    payload = []
    content = {}
    for row in rv:
        
        print(row)
    for result in rv:
       content = {'username of follower': result[0],'date of music':result[1],'song_title':result[2]}
       payload.append(content)
       content = {}
    return jsonify(payload)


#suggest favor artist user
@app.route('/suggest artist', methods=['GET'])
def home18():
    natije1=' '
    natije2=' '
    natijeNahaii=' '
    username=session.get('username')
    rv=q.give_favorArtist(username)
    
    payload = []
    content = {}
    for row in rv:
        natije1=row[0]
    rv2=q.giveartist1(natije1)
    for row in rv2:
        natije2=row[0]
    rv3=q.giveartistnahaii(natije1,natije2) 
        
    for result in rv3:
       content = {'username of artist': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)


#suggest 5 music mahbob in zhanr karbar
@app.route('/suggest music New1', methods=['GET'])
def home19():
    natije1=' '
    natije2=' '
    natijeNahaii=' '
    username=session.get('username')
    rv=q.give_user_zhanr(username)
    
    payload = []
    content = {}
    for row in rv:
        natije1=row[0]
    rv2=q.suggest_music1(natije1,username)
  
    for result in rv2:
       content = {'song title': result[0],'song liked count':result[1]}
       payload.append(content)
       content = {}
    return jsonify(payload)


#suggest 5 music in zhanr karbar jadid
@app.route('/suggest music New2', methods=['GET'])
def home20():
    natije1=' '
    natije2=' '
    natijeNahaii=' '
    username=session.get('username')
    rv=q.give_user_zhanr()
    
    payload = []
    content = {}
    for row in rv:
        natije1=row[0]
    rv2=q.suggest_music2(natije1,username)
  
    for result in rv2:
       content = {'song title': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)
#test konimesh
#genre qaleb artist  & peyda kardan fan  haie  artist 2
@app.route('/fan Artist', methods=['GET'])
def home21():
    natije=' '
    isART=''
    username=session.get('username')
    rv=q.zhanr_artist(username)
    for row in rv:
         natije=row[0]   
         print(row)
    rv2=q.fan_artist(username,natije)
    
    payload = []
    content = {}
   
    for result in rv2:
          content = {'username of fan': result[0]}
          payload.append(content)
          content = {}
    return jsonify(payload)

#admin artist hara bar asas mizan faaliat an ha moshahede konad
@app.route('/show artistbyAdmin', methods=['GET'])
def home22():
    rv=q.showArtist_admin()
    
    payload = []
    content = {}
   
    for result in rv:
          content = {'username of artist': result[0],'count of ahang':result[1]}
          payload.append(content)
          content = {}
    return jsonify(payload)

#admin kam faaliat tarin artist hara moshahede mikonad
@app.route('/show less activityArtist', methods=['GET'])
def home23():
    rv=q.show_lessActivityAdmin()
    
    payload = []
    content = {}
   
    for result in rv:
          content = {'username of artist': result[0]}
          payload.append(content)
          content = {}
    return jsonify(payload)


#admin karbaran mashkook ra moshahede mikonad
@app.route('/karbar mashkok', methods=['GET'])
def home24():
    

    rv=q.mashkok_admin()
    
    payload = []
    content = {}
   
  
    for result in rv:
       content = {'uname': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)
#kharab
#az zaman faalitaeshan ha roz hadaqal yek ahang montasher karde and
@app.route('/everyDay music', methods=['GET'])
def home25():
    
   
    rv=q.enteshar_EveryDay()
    
    payload = []
    content = {}
   
  
    for result in rv:
       content = {'userNameFollower': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)


#follow people
@app.route('/follow people', methods=['POST'])
def home26():
    resul=' '
    id1=request.form['name']
    username=session.get('username')
    res=q.checkfollow(username,id1)
    for row in res:
        resul=row[0]
    if resul=='Yes':
       q.doing_follow(id1,username)
       return jsonify('you follow enjoy it')
    elif resul=='No':
        return jsonify('you already follow enjoy it')
 


 #unfollow people
@app.route('/unfollow people', methods=['POST'])
def home27():
    resul=' '
    id1=request.form['name']
    username=session.get('username')
    res=q.checkunfollow(username,id1)
    for row in res:
        resul=row[0]
    if resul=='Yes':
       q.doing_unfollow(id1,username)
       return jsonify('you ufollow him/her')

    elif resul=='No':
         return jsonify('you already ufollow him/her')


   

#vaqti mikhad ahang goosh bede
@app.route('/listen music', methods=['POST'])
def home28():
    
    id1=request.form['title']
    id2=request.form['artist']
    username=session.get('username')
    res=q.checkmusic(username)
    for row in res:
        resul=row[0]
    if resul=='Yes':
         q.listen_music(username,id1,id2)
       
    return jsonify('join your listening')




#show questions
@app.route('/questions', methods=['GET'])
def home30():

   
    rv=q.show_questions()
     
    payload = []
    content = {}
   
  
    for result in rv:
       content = {'question': result[0],'id':result[1]}
       payload.append(content)
       content = {}
    return jsonify(payload)



#save reply
@app.route('/save to questions', methods=['POST'])
def home31():

    username=session.get('username')
    reply=request.form['reply']
    idreply=request.form['idquestion']

    q.saveto_reply(username,idreply,reply)
     
    return jsonify('Done ,welcome')




#sign in stor etelat
@app.route('/sign in', methods=['POST'])
def home29():
    
    username=request.form['username']
    session['username']=username
    email=request.form['email']
    session['email']=email
    password=request.form['password']
    session['password']=password
    country=request.form['country']
    session['country']=country
    fname=request.form['fname']
    session['fname']=fname
    lname=request.form['lname']
    session['lname']=lname
    hashpass=q.hash_password(password)
    session['password']=password
    isArtist=request.form['isartist']
    session['isartist']=isArtist
    birthdate=request.form['birthdate listener']
    artistyearbegin=request.form['artistYearbegin']


    
    uniqusename=q.signin_check_username(username)
    uniqemail=q.signin_check_email(email)
    if len(uniqemail)==0 and len(uniqusename)==0:
        q.signin_saving(username,email,hashpass[:24],country,fname,lname)
        if isArtist=='0':
            q.addto_listener(username,birthdate)
        elif isArtist=='1':
            q.addto_artist(username,artistyearbegin)
        
        

        return jsonify('please request to get your questions to complete your signing')



#show questions to change pass
@app.route('/changepass1', methods=['GET'])
def home32():

    username=session.get('username')
    rv=q.changepass_showquestions(username)
     
    payload = []
    content = {}
   
  
    for result in rv:
       content = {'question': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)



#check reply of karbar
@app.route('/changepass2', methods=['POST'])
def home33():
    result=' '
    username=session.get('username')
    reply=request.form['reply']
    passwordnew=request.form['passwordnew']
    passwordnew1=q.hash_password(passwordnew)
    res=q.checkuser_answer(username)
    for row in res:
        result=row[0]
    if result==reply:
        q.passwordnew(passwordnew1[:24],username)
    elif result!=reply:
        return jsonify('your answer incorrect!')

     
    


#check reply of karbar
@app.route('/login', methods=['POST'])
def home34():
    result=' '
    
    username=request.form['username']
    password=request.form['password']
    passwordhash=q.hash_password(password)
    res=q.checkpass_login(username)
    for row in res:
        result=row[0]
    if result==passwordhash[:24]:
       session['username']=username
       session['password']=passwordhash[:24]
    elif result!=passwordhash[:24] :
        return jsonify('your password incorrect!')

     
    return jsonify('welcommm again')


#make playlist
@app.route('/makeplaylist', methods=['POST'])
def home35():
    result=' '
    
    username=session.get('username')
    title=request.form['title']
    rv=q.checkplaylist(username)
    for row in rv:
        result=row[0]
    if result=='Yes':
        q.makeplaylist(title,username)
        return jsonify('Done')
    elif result=='No':
         return jsonify('outofbounds!!')

        
   




#add music to playlist
@app.route('/addmusicToPlaylist', methods=['POST'])
def home36():
    result=' '
    
    username=session.get('username')
    musicname=request.form['musicname']
    artistname=request.form['artistname']
    playlistname=request.form['playlistname']
    q.addmusic_playlist(musicname,artistname,username,playlistname)
    
    return jsonify('Done')


#hazf music from playlist
@app.route('/deletemusicToPlaylist', methods=['POST'])
def home38():
    result=' '
    
    username=session.get('username')
    musicname=request.form['musicname']
    artistname=request.form['artistname']
    playlistname=request.form['playlistname']
    q.deletemusic_playlist(musicname,artistname,username,playlistname)
    
    return jsonify('Done')


#like music
@app.route('/likemusic', methods=['POST'])
def home37():
    result=' '
    
    username=session.get('username')
    musicname=request.form['musicname']
    artistname=request.form['artistname']
    q.likemusic(username,musicname,artistname)
    
    return jsonify('Done')

#unlike music
@app.route('/unlikemusic', methods=['POST'])
def home39():
    result=' '
    
    username=session.get('username')
    musicname=request.form['musicname']
    artistname=request.form['artistname']
    q.unlikemusic(username,musicname,artistname)
    
    return jsonify('Done')



#report music
@app.route('/reportContexbad', methods=['POST'])
def home40():
    result=' '
    
    username=session.get('username')
    musicname=request.form['musicname']
    artistname=request.form['artistname']
    text=request.form['text']
    q.badmohtavaReport(username,musicname,artistname,text)
    
    return jsonify('Done')


#likeplayList
@app.route('/likePlayList', methods=['POST'])
def home41():
    result=' '
    
    username=session.get('username')
    playlistName=request.form['playlistname']
    makerplylist=request.form['playlistbuilder']
    q.likeplylist(username,makerplylist,playlistName)
    
    return jsonify('Done')

#unlikeplayList
@app.route('/unlikePlayList', methods=['POST'])
def home42():
    result=' '
    
    username=session.get('username')
    playlistName=request.form['playlistname']
    makerplylist=request.form['playlistbuilder']
    q.unlikeplylist(username,makerplylist,playlistName)
    
    return jsonify('Done')

#shareplayelist
@app.route('/shareplaylist', methods=['POST'])
def home43():
    result=' '
    
    username=session.get('username')
    playlistName=request.form['playlistname']
    username2=request.form['username2']
    q.makeplaylisteshteraki(username,playlistName,username2)
    
    return jsonify('Done')


#album_release
@app.route('/albumrelease', methods=['POST'])
def home44():
    result=' '
    
    username=session.get('username')
    albumname=request.form['albumname']
    date=request.form['date']
    genrealbum=request.form['genrealbum']
    titlesong=request.form['titlesong']
    songduration=request.form['songduration']
    songgenre=request.form['songgenre']

    rv=q.isArtist()
    if len(rv)!=0:
        q.albumrelease(albumname,date,genrealbum,username,titlesong,songduration,songgenre)


    
    return jsonify('Done')

#del album
@app.route('/delalbum', methods=['POST'])
def home49():
    result=' '
    
    username=session.get('username')
    albumname=request.form['albumname']

    rv=q.isArtist()
    if len(rv)!=0:
        q.deletealbum(username,albumname)


    
    return jsonify('Done')


#del music fromalbum
@app.route('/delmusicAL', methods=['POST'])
def home56():
    
    nameofmusic=request.form['nameofmusic']
    username=session.get('username')
    albumname=request.form['albumname']


    rv=q.isArtist()
    if len(rv)!=0:
        q.deletemusicfromalbum1(albumname,nameofmusic,username)

    return jsonify('Done')



#confirm artist
@app.route('/shownonacceptable', methods=['GET'])
def home58():
    resul=' '
    rv=q.show_artistnotconfirm()
  

    payload = []
    content = {}
   
  
    for result in rv:
       content = {'name artist': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)


 #taiid artist
@app.route('/artistaccept', methods=['POST'])
def home60():
    resul=' '
    name=request.form['name']
    q.confirmartist(name)
    return jsonify('accept')   
    

#taiid nakardan artist
@app.route('/artistnonaccept', methods=['POST'])
def home61():
    resul=' '
    name=request.form['name']
    q.notconfirmartist(name)
    return jsonify('nonaccept')   
       

#deleteuser
@app.route('/deleteuser', methods=['POST'])
def home99():
    resul=' '
    name=request.form['name']
    q.deletuser(name)
    return jsonify('delete!!')   
       



#deletplaylist
@app.route('/deleteplaylistadmin', methods=['POST'])
def home62():
    resul=' '
    name=request.form['name']
    names=request.form['sazande']
    q.deletplaylist_admin(names,name)
    return jsonify('delete!!')   
       

#delete album
@app.route('/deletealbum', methods=['POST'])
def home65():
    resul=' '
    nameofartist=request.form['nameofartist']
    nameofalbum=request.form['nameofalbum']
    q.deletealbum_admin(nameofartistalbum,nameofalbum)
    return jsonify('delete!!') 


#showreports
@app.route('/showreports', methods=['GET'])
def home63():
    rv=q.shoereportsAdmin()
  

    payload = []
    content = {}
   
  
    for result in rv:
       content = {'nameofsong': result[0]}
       payload.append(content)
       content = {}
    return jsonify(payload)


#delsong admin
@app.route('/delsongadmin', methods=['POST'])
def home64():
    namemusic=request.form['namemusic']
    nameartist=request.form['nameartist']
    q.delsongadmin(namemusic,nameartist)
  
    return jsonify('delete')

#show eshterakha
@app.route('/shoeeshterakha', methods=['GET'])
def home66():
    
    rv=q.eshterakha()
    payload = []
    content = {}
   
  
    for result in rv:
       content = {'eshterakcost': result[0],'eshterakperiod':result[1],'eshterakid':result[2]}
       payload.append(content)
       content = {}
       return jsonify(payload)

#buy eshterak
@app.route('/buy eshterak', methods=['POST'])
def home68():
    id1=request.form['id']
    username=session.get('username')
    q.buyeshterak(id1,username)
    return jsonify('buyit:)')
  


'''#buy eshterak
@app.route('/suggestmusicplaylist', methods=['GET'])
def home70():
    res1=' '
    for i in 50:
        rv=q.suggestmusic_playlist(i)
        for row in tv:
            res1=row[0]
        if res!='No':'''

            
        
           



    
  
  
       
app.run()
'''cur.close()
cnx.close()'''