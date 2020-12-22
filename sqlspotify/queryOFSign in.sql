SELECT uuser.USERNAME FROM uuser WHERE uuser.USERNAME='reshte i k karbar vared karde' 
/* vaqti resht ei ra baraye username vared mikonad nabayad dar database vojod daste bashad
ya b ebarati query bala khoroji ndashte bashad
 b tor moshabeh baray emili ke vared mikonad */

SELECT uuser.USERNAME FROM uuser WHERE uuser.email='reshte i k karbar vared karde' 

/*
#################################################################################################################
# vaqti username va email uniqe boodand maqadir dar table uuser insert mishavad
# bedon dar nazar gereftan salt+password  */

INSERT INTO uuser (uuser.USERNAME,uuser.email,uuser.password,uuser.country,uuser.Fname,uuser.Lname,uuser.joindate)
VALUES ('username karbar','email','pass','country ','fname','lname',CURRENT_DATE);
 /* #################################################################################################################
# pas az entekhab noe karbari khod bayad motenaseb ba an b table haie joda insert shavand 
# agar b onvan listener ast:  */
INSERT INTO listener (listener.USERNAME,listener.birth_date)
VALUES ('username karbar','tarikh'); 
 /* # userneme k bala vared shode mizarim dobare az karbar nmigirim  fqt tarikh tavalod bayad bege */

 /* # b onvan artist  */

/* #userneme k bala vared shode mizarim dobare az karbar nmigirim fqt tarikh shoro karesho bege */

VALUES ('username karbar','tarikh',3);

  /* ##################################################################################################################
#namayesh soalat baray karbar  */
SELECT question.Q,question.id
FROM question

/* #pas az entekhab yek soal ,soal va pasokh an dar tablee reply zakhire mishavad ke user karbar (session) vali id soal va pasokh ra az karbar migirim. */

INSERT INTO reply (reply.uname, reply.Id, reply.reply)
VALUES ('username karbar','id soali ke entekha kard','pasokh karbar');

/*
#####################################################################################################################
# baraye taqir password soal namayesh dde mishavad
# bedon dar nazar gereftan salt+password */

SELECT question.Q
FROM question,reply
WHERE reply.Id=question.ID
AND reply.uname='username karbar'  /* #session


# vaqti b soal pasokh dad barrasi pasokh inja pasokh qbli ra midahad ke bayad ba in jadid moqayese konim  */
SELECT reply.reply
FROM reply
WHERE reply.uname='username karbar'  /*#session  

baray login */ /* check krdn dorost password*/
SELECT uuser.password
FROM uuser
WHERE uuser.USERNAME=' '

