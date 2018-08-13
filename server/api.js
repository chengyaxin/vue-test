const express = require("express");
const mysql = require("mysql");
var multiparty = require('multiparty');
const fs = require('fs');
const db = mysql.createPool({
    host:"localhost",
    user:"root",
    password:"root",
    database:"yulu"
});
module.exports = () =>
{
    const route = express.Router();
    //获取所有语录的数据
    function getYlList(res)
    {
        var sql = "select yulu_info.Id,yulu_info.content,yulu_info.img,yulu_type.type_name type from yulu_info join yulu_type on yulu_info.typeId=yulu_type.Id order by yulu_info.Id asc";
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.send(data);
            }
        })
    }
    //获取所有语录属性
    function getYlType(res)
    {
        var sql = "select Id value,type_name label from yulu_type";
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.send(data);
            }
        })
    }
    //文件上传
    function fileUpload(req,res)
    {
        //生成multiparty对象，并配置上传目标路径
        var form = new multiparty.Form({uploadDir: '../static/images/'});
        //上传完成后处理
        form.parse(req, function(err, fields, files) {
        var filesTmp = JSON.stringify(files,null,2);
        if(err){
            } else {
            var inputFile = files.file[0];
            var uploadedPath = inputFile.path;
            var dstPath = '../static/images/' + inputFile.originalFilename;
             //重命名为真实文件名
            fs.rename(uploadedPath, dstPath, function(err) {
            if(err){
                    console.log('rename error: ' + err);
                    } else {
                    console.log('rename ok');
                    }
                });
            }
            res.send({"fileName":inputFile.originalFilename});

        });
    }
    function submitData(req,res){
        let content = req.body.content;
        let typeId = req.body.typeId;
        let img = req.body.img;
        var sql = `insert into yulu_info(content,typeId,img) values('${content}','${typeId}','${img}')`;
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send("提交成功").end();
            }
        })
    }
    function deleteFile(req,res)
    {
        var path = "../static/images/"+req.body.fileName;
        console.log(path);
        fs.unlink(path,function (err) {
            if(err) throw err;
            res.status(200).send("delete file success").end();
        });
    }
    function removeYl(req,res)
    {
        var Id = req.body.Id;
        var sql = `delete from yulu_info where Id=${Id}`;
        console.log(sql);
        db.query(sql,(err,data)=>{
            if(err)
            {
                res.status(500).send('database err').end();
            }else{
                res.status(200).send("delete data success").end();
            }
        })
    }
    route.get('/getYlList',(req,res)=>{
        getYlList(res);
    });
    route.get('/getYlType',(req,res)=>{
        getYlType(res);
    });
    route.post('/fileUpload',(req,res)=>{
        fileUpload(req,res);
    });
    route.post('/submitData',(req,res)=>{
        submitData(req,res);
    });
    route.post('/deleteFile',(req,res)=>{
        deleteFile(req,res);
    });
    route.post('/removeYl',(req,res)=>{
        removeYl(req,res);
    });
    return route;
}
