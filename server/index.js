const express = require("express");
const bodyParser = require("body-parser");
const server = express();
//bodyParser中间件用来解析http请求体，是express默认使用的中间件之一。
server.use(bodyParser.urlencoded({ extended: false }));
server.use(bodyParser.json());
server.all("*",function(req,res,next)
{
    //响应头设置
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
    res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');
    if (req.method == 'OPTIONS') {
        res.send(200);
        /make the require of options turn back quickly/
    } else {
        next();
    }
});

server.listen(3334,()=>
{
    console.log("3334 port");
})
server.use('/',require("./api.js")());
server.use('/',require("./poem.js")());
