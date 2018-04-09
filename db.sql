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
    language varchar(10) not null
    -- check rating<20
);

/* multivalued attribute */
create table director_movie (
    director_name varchar(20),
    movie_id varchar(20),
    foreign key(movie_id) references movie(movie_id),
    primary key(movie_id,director_name)
);

/* multivalued attribute */
create table actor_movie (
    actor_name varchar(20),
    movie_id varchar(20),
    foreign key(movie_id) references movie on delete cascade,

    primary key(movie_id,actor_name)
);

create table cinema_hall (
    cinema_hall_id varchar(20),
    hall_name varchar(20),
    primary key(cinema_hall_id)
);
/* named as screened in relation ER diagram */
create table movie_cinema_hall (
    cinema_hall_id varchar(20),
    movie_id varchar(20),
    
    foreign key(cinema_hall_id)
    references cinema_hall(cinema_hall_id)
    on delete cascade,
    
    foreign key(movie_id) 
    references movie(movie_id)
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
    references movie_cinema_hall(cinema_hall_id,movie_id)
    on delete cascade,

    primary key(show_id,cinema_hall_id,movie_id)
);

create table payments(
    amount int,
    payment_id varchar(20),

    primary key(payment_id)

);


create table administrator (
    admin_id varchar(20) ,
    password varchar(20),
    /*merging cinema hall*/
    cinema_hall_id varchar(20),


    primary key(admin_id),
    foreign key(cinema_hall_id)
    references cinema_hall(cinema_hall_id)

    
);

create table tickets (
    ticket_no varchar(20),
    seat_no varchar(20),
    hall_no varchar(20),
    -- show_id varchar(20),

    admin_id varchar(20) /* sells relation merge */,
    
    /* is for relation with shows being merged */
    show_id varchar(20),
    cinema_hall_id varchar(20),
    movie_id varchar(20),

    /* for referencing payments*/
    payment_id varchar(20),

    /*for referencing customer */
    cust_id varchar(20),

    foreign key (admin_id)
    references administrator(admin_id),

    foreign key (show_id,cinema_hall_id,movie_id)
    references shows(show_id,cinema_hall_id,movie_id),

    foreign key(payment_id) references payments (payment_id),
    foreign key(cust_id ) references customer(cust_id),

    primary key(ticket_no)
);
/* named administrator in ER model */

create table seats(
  seat_no varchar(20),
  amount int,
  cinema_hall_id varchar(20),

  foreign key(cinema_hall_id)
  references cinema_hall(cinema_hall_id)

);

create table phone_number(
    phone_number varchar(20),
    cust_id varchar(20),

    primary key (phone_number,cust_id),
    foreign key(cust_id) references customer(cust_id)

);


create table offline(
    receipt_no varchar(20),
    payment_id varchar(20),
    
    foreign key(payment_id) references payments(payment_id),
    primary key(receipt_no)    

);
create table online(
    card_no varchar(20),
    bank varchar(20),
    name_on_card varchar(20),
    payment_id varchar(20),
    transaction_id varchar(20),

    foreign key(payment_id) references payments(payment_id),
    primary key(transaction_id) 



);