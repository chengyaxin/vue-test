const express = require("express");
const bodyParser = require("body-parser");
const server = express();
//bodyParser�м����������http�����壬��expressĬ��ʹ�õ��м��֮һ��
server.use(bodyParser.urlencoded({ extended: false }));
server.use(bodyParser.json());
server.all("*",function(req,res,next)
{
    //��Ӧͷ����
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
