var express = require('express');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var mysql = require('mysql');
var app = express();
app.set('view engine', 'ejs');
app.use( express.static( "public" ) );
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));
var sess;
app.use(cookieParser());
app.use(session({secret: "Shh, its a secret!",resave: true,
  saveUninitialized: true}));


app.use("/",function(req,res,next){
	sess = req.session;
	console.log("new session added"+sess.email);
	next();
})

app.use(function(req,res,next){
	if(req.path=='/sign_in' || req.path == '/' || req.path == '/req_sign_in'){
		return next();
	}
	if(sess.email){
		next();
	}else{
		console.log("new user");
		res.redirect('/');
	}
});


app.post('/get_cinema',function(req,res){
	
	movie_id = req.body.movie_id;
	q = "select * from cinema_hall natural join movie_cinema_hall where movie_id = \""+movie_id+"\"";	
	
	con.query(q, function (err, result){
		if(err) throw err;
		console.log(result);	
	});

});


app.post('/req_sign_in',function(req,res){
	
	pass = req.body.cust_pass;
	email = req.body.email;
	q = "select * from customer where email = \""+email+"\"";
	console.log(q);
	con.query(q, function (err, result) {
	    if (err) throw err;
	    // console.log(result);
	    if(result){
	    	// console.log("setting sess.email");
	    	sess.email = email;
			// console.log(sess.email);
			res.redirect('/');
	    }else{
	    	res.render('sign_form.ejs');
	    }	
	});
	// console.log("outside"+sess.email);
});

app.post('/',function(req,res){

	search = req.body.search;
	// console.log("search se aaya",search);
	q = "select * from movie where movie_name = \""+search+"\"";
  	console.log(q);
  	movies = []
  	con.query(q, function (err, result) {
	    if (err) throw err;
	   	// console.log(result);

	   	res.render('front_screen.ejs',{name:sess.email,movies:result});
	});


});


var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  
});
con.query("use movieticket", function (err, result) {
    if (err) throw err;
    console.log(result);
});

app.get('/', function(req, res){	
  	// res.render('index');
  	// console.log("aaya")
  	q = "select * from movie ";
  	movies = []
  	console.log(q);
  	con.query(q, function (err, result) {
	    if (err) throw err;
	   	movies = result;
	   	// for (movie in movies){
	   	// 	q_e = "select director_name from director_movie where movie_id ="+"\""+movies[movie].movie_id+"\"";
	   	// 	movies[movie].director = "";
	   	// 	con.query(q_e,function(err,result){
	   	// 		for (i in result){
	   	// 			movies[movie].director+=toString(result[i]);
	   	// 		}	
	   	// 	});
	   	// }
	   	res.render('front_screen.ejs',{name:sess.email,movies:result});
	});
});

app.get('/create_movie',function(req,res){
	res.render('index.ejs');
})


app.get('/sign_in', function(req, res){	
  	// res.render('index');
  	res.render('sign_form.ejs');

});


app.get('/create_cinema_hall',function(req,res){
	res.render('cinema_hall');
});

app.get('/create_movie_cinema_hall',function(req,res){
	res.render('cinema_hall');
});

app.post('/create_movie',function(req,res){
	console.log(req.body);
	// console.log(req.body['movie_name ']);
	director_name = req.body.director_name;
	actor_name = req.body.actor_name;
	q = "insert into movie values(\""+req.body.movie_id+"\",\""+req.body.certifications+"\",\""+req.body.duration+"\",\""+req.body.release_date+"\",\""+req.body.movie_name+"\",\""+req.body.rating+"\",\""+req.body.trailer+"\",\""+req.body.genre+"\",\""+req.body.description+"\",\""+req.body.img_link+"\",\""+req.body.img_link2+"\",\""+req.body.language+"\")";
	console.log(q);
	con.query(q, function (err, result) {
	    if (err) throw err;
	    console.log(result);
	});

	director_name = director_name.split(",");
	actor_name = actor_name.split(",");
	console.log(director_name,actor_name);
	for (i in director_name){
		q = "insert into director_movie values(\""+director_name[i]+"\",\""+req.body.movie_id+"\")";
		console.log(q);
		con.query(q, function (err, result) {
		    if (err) throw err;
		    console.log(result);
		});
		
	}

	for (i in actor_name){
		q = "insert into actor_movie values(\""+actor_name[i]+"\",\""+req.body.movie_id+"\")";
		console.log(q);
		con.query(q, function (err, result) {
		    if (err) throw err;
		    console.log(result);
		});
		
	}
	
	res.send('movie created');
});

app.post('/create_cinema_hall',function(req,res){
	q = "insert into cinema_hall values(\""+req.body.cinema_hall_id+"\",\""+req.body.hall_name+"\")";
	console.log(q);
	con.query(q, function (err, result) {
	    if (err) throw err;
	    console.log(result);
	});
	res.send('cinema_hall created');
});


app.post('/create_movie_cinema_hall',function(req,res){
	q = "insert into cinema_hall values(\""+req.body.cinema_hall_id+"\",\""+req.body.movie_id+"\")";
	console.log(q);
	con.query(q, function (err, result) {
	    if (err) throw err;
	    console.log(result);
	});
	res.send('movie in cinema hall created created');
});


app.listen(3000);