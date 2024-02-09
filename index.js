const express = require('express');
const session = require('express-session');
const route = require('./controller/router');
const routePost = require('./controller/routePost')
const path = require('path');
const ip = "127.0.0.1";
const port = 3000;
const server = express();

server.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
server.use(express.json());
server.use(express.urlencoded({extended: true}));

// For The display of the Files in the public file 
server.use(express.static(path.join(__dirname, 'public')));

server.set('views', path.join(__dirname, 'views'));
server.set('view engine', 'ejs');

server.use('/', route);
server.use('/', routePost);

server.listen(port, ip, ()=>{
    console.log(`Server is running is running on ${ip}:${port}`);
});