CREATE TABLE  uuser (
    USERNAME VARCHAR(25)  NOT NULL,
    email  VARCHAR(30)    NOT NULL,
    password VARCHAR(25)  NOT NULL,
    country VARCHAR(25)   NOT NULL,
    Fname VARCHAR(25)     NOT NULL,
    Lname VARCHAR(25)     NOT NULL,
    PRIMARY KEY (USERNAME),
     UNIQUE  (email)
);

CREATE TABLE artist (
    USERNAME  VARCHAR(25) NOT NULL ,
    year_begin  YEAR     NOT NULL,
    Accepted  INT       NOT NULL,
<<<<<<< HEAD
    PRIMARY KEY (USERNAME)
     
=======
    PRIMARY KEY (USERNAME),
    
>>>>>>> ee0b4a4c147fa44bac083b1f60399b772e955a4e
);
CREATE TABLE admin(
    USERNAME  VARCHAR(25) NOT NULL PRIMARY KEY
);

CREATE TABLE listener(
    USERNAME  VARCHAR(25)  NOT NULL ,
    birth_date  DATE        NOT NULL ,
    PRIMARY KEY (USERNAME)
<<<<<<< HEAD
    PRIMARY KEY (USERNAME)
     
=======
    PRIMARY KEY (USERNAME),
    
>>>>>>> ee0b4a4c147fa44bac083b1f60399b772e955a4e
);

CREATE TABLE Album_release (
    ID  INT   PRIMARY key    NOT NULL  AUTO_INCREMENT ,
    title  VARCHAR (25)     NOT NULL ,
    yearrelease  DATE       NOT NULL ,
    genre  VARCHAR(40)       NOT NULL ,
    userArtist  VARCHAR(25) NOT NULL ,
    FOREIGN KEY (userArtist ) REFERENCES artist (USERNAME) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE  TABLE Song (
    ID  INT PRIMARY key      NOT NULL  AUTO_INCREMENT,
    title  VARCHAR (25)     NOT NULL ,
    duration  TIME            NOT NULL ,
    Artistname  VARCHAR(25) NOT NULL ,
    IDALBUM INT              NOT NULL ,
    FOREIGN KEY (IDALBUM) REFERENCES Album_release  (ID ) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE PlayList (
    ID INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
<<<<<<< HEAD
    Title VARCHAR(25) NOT NULL 
=======
    Title VARCHAR(25) NOT NULL ,
    lasteditdate  DATE,
    sugestsong1  INT,
    sugestsong2 INT
>>>>>>> ee0b4a4c147fa44bac083b1f60399b772e955a4e

);

CREATE TABLE follow_user(
    username_followed VARCHAR(25) NOT NULL,
    username_follower VARCHAR(25) NOT NULL,
    Fdate DATE                     NOT NULL ,
    PRIMARY KEY (username_follower,username_followed),
    FOREIGN KEY (username_follower) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (username_followed) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE
);

  

CREATE TABLE createplaylist_user(
    Idplaylist INT     NOT NULL ,
    uname VARCHAR(25) NOT NULL ,
    Createdate DATE    NOT NULL ,
    PRIMARY key (Idplaylist,uname),
    FOREIGN KEY (Idplaylist) REFERENCES PlayList  (ID ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE  LikedPlaylistbyUser(
    Idplaylist INT     NOT NULL ,
    uname VARCHAR(25) NOT NULL ,
    likedate DATE    NOT NULL ,
    PRIMARY key (Idplaylist,uname),
    FOREIGN KEY (Idplaylist) REFERENCES PlayList  (ID ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE LikedSongbyUser(
    uname VARCHAR(25) NOT NULL ,
    Idsong     INT     NOT NULL ,
    likedate DATE    NOT NULL ,
    PRIMARY key (Idsong,uname),
    FOREIGN KEY (Idsong) REFERENCES Song  (ID ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE PlayListhasSong(
    Idsong     INT     NOT NULL ,
    Idplaylist INT     NOT NULL ,
    Adddate   DATE     NOT NULL,
    PRIMARY key (Idsong,Idplaylist),
    FOREIGN KEY (Idplaylist) REFERENCES PlayList  (ID ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Idsong) REFERENCES Song  (ID ) ON DELETE CASCADE ON UPDATE CASCADE

);

 CREATE TABLE SongplaybyUser(
    uname VARCHAR(25) NOT NULL ,
    Idsong     INT     NOT NULL ,
    dateplay     DATE    NOT NULL,
     ID INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
    FOREIGN KEY (Idsong) REFERENCES Song  (ID ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE

    
 );



 CREATE TABLE userReports(
    uname VARCHAR(25) NOT NULL ,
    Idsong     INT     NOT NULL ,
<<<<<<< HEAD
    rtype  VARCHAR(25)      NOT NULL ,
=======
    rtype  VARCHAR (25)     NOT NULL ,
>>>>>>> ee0b4a4c147fa44bac083b1f60399b772e955a4e
    PRIMARY key (Idsong,uname),
    FOREIGN KEY (Idsong) REFERENCES Song  (ID ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE

    
 );

CREATE TABLE reply(
    uname VARCHAR(25) NOT NULL ,
    Id      INT          NOT NULL ,
    reply   VARCHAR(255)  NOT NULL,
    PRIMARY key (Id,uname),
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id) REFERENCES question  (id ) ON DELETE CASCADE ON UPDATE CASCADE
   
   
 );
 CREATE TABLE question  (
    id int NOT NULL ,
    q varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

 CREATE TABLE buypermium(
    uname VARCHAR(25) NOT NULL ,
    Id     INT     NOT NULL  ,
    numcard    INT     NOT NULL  AUTO_INCREMENT,
    datebuy DATE  NOT NULL ,
    Expired  DATE  NOT NULL ,
    PRIMARY key (Id,uname),
    FOREIGN KEY (uname) REFERENCES uuser  (USERNAME ) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID) REFERENCES eshterak  (id ) ON DELETE CASCADE ON UPDATE CASCADE  ,
    UNIQUE(numcard) 
 );
 CREATE TABLE eshterak(
     cost  INT    NOT NULL,
     periodd        INT  NOT NULL,
     id      INT NOT NULL,
     PRIMARY KEY(id)
 );




