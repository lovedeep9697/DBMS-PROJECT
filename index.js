var express = require('express');
var mysql = require('mysql');
var app = express();
app.set('view engine', 'ejs');
app.use( express.static( "public" ) );
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));


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
  	res.render('index');

});

app.post('/create_movie',function(req,res){
	console.log(req.body);
	console.log(req.body['movie_name ']);
	q = "insert into movie values(\""+req.body.movie_id+"\",\""+req.body.certifications+"\",\""+req.body.duration+"\",\""+req.body.release_date+"\",\""+req.body.movie_name+"\",\"8\",\"8\",\""+req.body.language+"\")";
	console.log(q)
	con.query(q, function (err, result) {
	    if (err) throw err;
	    console.log(result);
	});
	res.send('movie created');
});

app.listen(3000);