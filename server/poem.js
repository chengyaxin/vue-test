const mysql = require("mysql");
const db = mysql.createPool({
    host:"localhost",
    user:"root",
    password:"root",
    database:"yulu"
    });
const express = require("express");
var multiparty = require('multiparty');
const fs = require('fs');
module.exports = () =>
{
    const route = express.Router();
    function addPoem(req,res) {
    	var title = req.body.title;
    	var content = req.body.content;
    	var authorId = req.body.authorId;
    	var poem_produce = req.body.poem_produce;
    	var sql = `insert into poem_info(title,content,authorId,poem_produce) values('${title}','${content}','${authorId}','${poem_produce}')`;
    	db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send("add success").end();
            }
        })
    }
    function addPoet(req,res)
    {
        var author_name = req.body.author_name;
        var author_info = req.body.author_info;
        var author_dynasty = req.body.author_dynasty;
        var sql = `insert into poem_author(author_name,author_info,author_dynasty) values('${author_name}','${author_info}','${author_dynasty}')`;
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send(data).end();
            }
        })
    }
    function getAllAuthor(req,res)
    {
        var sql = "select Id value,author_name label from poem_author";
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send(data).end();
            }
        })
    }
    function getAllPoem(req,res)
    {
        var sql = "select poem_info.Id,poem_info.content,poem_info.poem_produce,poem_info.title,poem_author.author_name,poem_author.author_info from poem_info join poem_author on poem_info.authorId=poem_author.Id";
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send(data).end();
            }
        })
    }
    function deletePoem(req,res)
    {
        var id = req.body.Id;
        var sql = `delete from poem_info where Id='${id}'`;
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send(data).end();
            }
        })
    }
    route.post('/addPoem',(req,res)=>{
        addPoem(req,res);
    });
    route.post('/addPoet',(req,res)=>{
        addPoet(req,res);
    });
    route.get('/getAllAuthor',(req,res)=>{
        getAllAuthor(req,res);
    });
    route.get('/getAllPoem',(req,res)=>{
        getAllPoem(req,res);
    });
     route.post('/deletePoem',(req,res)=>{
        deletePoem(req,res);
    });
    return route;
}