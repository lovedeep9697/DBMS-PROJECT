var express = require('express');
var mysql = require('mysql');
var app = express();
app.set('view engine', 'ejs');
app.use( express.static( "public" ) );

var con = mysql.createConnection({
	  host: "localhost",
	  user: "root",
	  password: "password"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  
});

app.get('/', function(req, res){
	
    
    con.query("use movieticket", function (err, result) {
	    if (err) throw err;
	    console.log(result);
  	});
  	
  	res.render('index');

});

app.listen(3000);