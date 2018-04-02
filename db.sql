create database movieticket;
use movieticket;

create table movie (
    movie_id varchar(20) primary key,
    certifications varchar(20) not null,
    duration integer not null,
    release_date date not null,
    movie_name varchar(20) not null,
    /* actors multivalued */
    rating numeric(3,1),
    /* director multivalued */
    trailer varchar(50),
    language varchar(10) not null,
    check rating<20,

);

/* multivalued attribute */
create table director_movie (
    director_name varchar(20),
    movie_id varchar(20),
    foreign key(movie_id) references movie,
    primary key(movie_id,director_name)
);

/* multivalued attribute */
create table actor_movie (
    actor_name varchar(20),
    movie_id varchar(20),
    foreign key(movie_id) references movie on delete cascade,
    primary key(movie_id,director_name)
);

create table cinema_hall (
    cinema_hall_id varchar(20),
    hall_name varchar(20),
    primary key(cinema_hall_id)
);
/* named as screening in ER diagram */
create table movie_cinema_hall (
    cinema_hall_id varchar(20),
    movie_id varchar(20),
    
    foreign key(cinema_hall_id)
    references cinema_hall
    on delete cascade,
    
    foreign key(movie_id) 
    references movie
    on delete cascade,
    
    primary key(cinema_hall_id,movie_id)
);

/* renamed shows as screening */
/* has relation merged in shows ... weak entity */
create table shows (
    show_id varchar(20),
    start_time varchar(20),
    end_time varchar(20),

    cinema_hall_id varchar (20),
    movie_id varchar (20),

    foreign key(cinema_hall_id,movie_id)
    references movie_cinema_hall
    on delete cascade,

    primary key(show_id,cinema_hall_id,movie_id)
);

create table tickets (
    ticket_no varchar(20),
    seat_no varchar(20),
    hall_no varchar(20),
    show_id varchar(20),

    admin_id varchar(20) /* sells relation merge */,
    
    /* is for relation with shows being merged */
    show_id varchar(20),
    cinema_hall_id varchar(20),
    movie_id varchar(20),

    foreign key (admin_id)
    references administrator,

    foreign key (show_id,cinema_hall_id,movie_id)
    references shows,

    primary key(ticket_no)
);
/* named administrator in ER model */
create table administrator (
    
);