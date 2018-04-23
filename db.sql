create database movieticket;
use movieticket;

create table movie (
    movie_id varchar(50) primary key ,
    certifications varchar(50) not null,
    duration integer not null,
    release_date date not null,
    movie_name varchar(50) not null,
    /* actors multivalued */
    rating numeric(3,1),
    /* director multivalued */
    trailer varchar(50),
    genre varchar(50),
    description varchar(1000),
    img_link varchar(500),
    img_link2 varchar(500),
    language varchar(50) not null
    -- check rating<20
);

/* multivalued attribute */
create table director_movie (
    director_name varchar(50),
    movie_id varchar(50),
    foreign key(movie_id) references movie(movie_id),
    primary key(movie_id,director_name)
);

/* multivalued attribute */
create table actor_movie (
    actor_name varchar(50),
    movie_id varchar(50),
    foreign key(movie_id) 
        references movie(movie_id) on delete cascade,

    primary key(movie_id,actor_name)
);

create table cinema_hall (
    cinema_hall_id varchar(50),
    hall_name varchar(50),
    link varchar(100),
    primary key(cinema_hall_id)
);
/* named as screened in relation ER diagram */
create table movie_cinema_hall (
    cinema_hall_id varchar(50),
    movie_id varchar(50),
    
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
    show_id varchar(50),
    start_time varchar(50),
    end_time varchar(50),
    cinema_hall_id varchar(50),
    movie_id varchar(50),
    foreign key(cinema_hall_id,movie_id)
    references movie_cinema_hall(cinema_hall_id,movie_id)
    on delete cascade,
    primary key(show_id,cinema_hall_id,movie_id)
);

create table payments(
    amount int,
    payment_id int not null AUTO_INCREMENT,
    primary key(payment_id)
);


create table administrator (
    admin_id varchar(50) ,
    password varchar(50),
    /*merging cinema hall*/
    cinema_hall_id varchar(50),
    primary key(admin_id),
    foreign key(cinema_hall_id)
    references cinema_hall(cinema_hall_id)    
);

create table customer(
    cust_id varchar(50),
    cust_pass varchar(50) not null,
    email varchar(50),
    first_name varchar(50),
    middle_name varchar(50),
    last_name varchar(50),
    cus_date date,
    primary key(cust_id)
);


create table tickets (
    ticket_no int AUTO_INCREMENT,
    seat_no varchar(50),
    hall_no varchar(50),
    -- show_id varchar(50),

    admin_id varchar(50) /* sells relation merge */,
    
    /* is for relation with shows being merged */
    show_id varchar(50),    
    cinema_hall_id varchar(50),
    movie_id varchar(50),

    /* for referencing payments*/
    payment_id int,

    /*for referencing customer */
    cust_id varchar(50),

    foreign key (admin_id)
    references administrator(admin_id),

    foreign key (show_id,cinema_hall_id,movie_id)
    references shows(show_id,cinema_hall_id,movie_id),

    foreign key(payment_id) 
    references payments (payment_id),
    foreign key(cust_id ) 
    references customer(cust_id),

    primary key(ticket_no)
);
/* named administrator in ER model */

create table seats(
  seat_no varchar(50),
  amount int,
  cinema_hall_id varchar(50),

  foreign key(cinema_hall_id)
  references cinema_hall(cinema_hall_id)

);

create table phone_number(
    phone_number varchar(50),
    cust_id varchar(50),

    primary key (phone_number,cust_id),
    foreign key(cust_id) references customer(cust_id)

);


create table offline(
    receipt_no varchar(50),
    payment_id int,
    foreign key(payment_id) references payments(payment_id),
    primary key(receipt_no)    
);
create table online(
    card_no varchar(50),
    bank varchar(50),
    name_on_card varchar(50),
    payment_id int,
    transaction_id varchar(50),
    foreign key(payment_id) references payments(payment_id),
    primary key(transaction_id) 
);


