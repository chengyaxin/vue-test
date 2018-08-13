<template>
<div>
    <Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
        <FormItem label="诗词题目" prop="title">
            <Input v-model="formValidate.title" placeholder="Enter your title"></Input>
        </FormItem>
        <FormItem label="诗词作者" prop="author">
            <Select v-model="formValidate.author" placeholder="Select author">
                <Option v-for="item in authorList" :value="item.value" :key="item.Id">{{item.label}}</Option>
            </Select>
        </FormItem>
        <FormItem>
        	没有该作者?<Button type="text" @click="addAuthor()">点击添加</Button>
        </FormItem>
        <FormItem label="诗词内容" prop="content">
            <Input v-model="formValidate.content" placeholder="Enter content" type="textarea" :autosize="{minRows: 8,maxRows: 5}"></Input>
        </FormItem>
         <FormItem label="诗词背景" prop="poem_produce">
            <Input v-model="formValidate.poem_produce" placeholder="Enter poem_produce" type="textarea" :autosize="{minRows: 8,maxRows: 5}"></Input>
        </FormItem>
        <FormItem>
            <Button type="primary" @click="handleSubmit('formValidate')">Submit</Button>
            <Button @click="handleReset('formValidate')" style="margin-left: 8px">Reset</Button>
        </FormItem>
    </Form>

    <!-- 弹出层 -->
    <div id="alert_class" style="display:none">
        <Form ref="formValidate1" :model="formValidate1" :rules="ruleValidate1" :label-width="80" class="formClass">
         <FormItem label="作者名称" prop="author_name">
            <Input v-model="formValidate1.author_name" placeholder="Enter author_name"></Input>
        </FormItem>
        <FormItem label="作者朝代" prop="author_dynasty">
            <Select v-model="formValidate1.author_dynasty" placeholder="Select dynasty">
                <Option v-for="item in dynasty" :value="item" :key="item">{{item}}</Option>
            </Select>
        </FormItem>
        <FormItem label="作者简介" prop="author_info">
            <Input v-model="formValidate1.author_info" placeholder="Enter author_info" type="textarea" :autosize="{minRows: 8,maxRows: 5}"></Input>
        </FormItem>
    </Form>
    </div>
    </div>
</template>
<script>

    export default {
        data () {
            return {
                formValidate: {
                    title: '',
                    content: '',
                    author: '',
                    poem_produce:'', 
                },
                authorList:[],
                ruleValidate: {
                    title: [
                        { required: true, message: '题目不可为空', trigger: 'blur' }
                    ],
                    content: [
                        { required: true, message: '诗句不可为空', trigger: 'blur' },
                    ],
                    author:[
                    	{ type:'number',required: true, message: '作者不可为空', trigger: 'change' },
                    ],
                    poem_produce: [],
                },
                dynasty:["夏","商","西周","东周","秦","西汉","东汉","魏","蜀","吴","西晋","东晋","十六国","南朝","北朝","隋","唐","北宋","南宋","辽","西夏","金","元","明","清"],
                formValidate1:{
                    author_name:'',
                    author_info:'',
                    author_dynasty:''
                },
                ruleValidate1: {
                    author_name:[
                        {required: true, message: '作者不可为空', trigger: 'blur'},
                    ],
                    author_dynasty:[
                        {required: true, message: '朝代不可为空', trigger: 'change'}
                    ],
                    author_info:[]
                },
                
            }
        },
        methods: {
            handleSubmit (name) {
            	let self = this;
                this.$refs[name].validate((valid) => {
                    if (valid) {
                    	var str = "title="+this.formValidate.title+"&content="+this.formValidate.content;
                    	str += "&authorId="+this.formValidate.author+"&poem_produce="+this.formValidate.poem_produce;
                        this.$axios.post("/addPoem",str)
	                    .then(function (res) {
	                        if(res.status==200)
	                        {
	                        	self.$Message.success('添加成功!');
	                        	self.handleReset('formValidate');
	                        }
	                    }).catch(function (err) {
	                        console.log(err);
	                	})
                    } else {
                        this.$Message.error('Fail!');
                    }
                })
            },
            handleReset (name) {
                this.$refs[name].resetFields();
            },
            addAuthor () {
                var self = this;
                layer.open({
                    type: 1,
                    title:false,
                    area:['50%','45%'],
                    content:$("#alert_class"),
                    move:false,
                    scrollbar :false,
                    btn:["确定","重置"],
                    closeBtn:1,
                    shade:[0.5,"#000"],
                    resize:false,
                    shadeClose:true,
                    scrollbar:false,
                    yes: function(index, layero){
                        self.SubmitAlert('formValidate1',index);
                        // layer.close(index);
                    },
                    btn2:function(index,layero)
                    {
                        self.ResetAlert('formValidate1');
                        return false;
                    }
                  })
            },
            SubmitAlert (name,index) {
                let self = this;
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        var str = "author_name="+self.formValidate1.author_name+"&author_info="+self.formValidate1.author_info;
                        str += "&author_dynasty="+self.formValidate1.author_dynasty;
                        this.$axios.post("/addPoet",str)
                        .then(function (res) {
                            console.log(res);
                            if(res.status==200)
                            {
                                self.$Message.success('添加成功!');
                                self.authorList.push({"Id":res.data.insertId,"author_name":self.formValidate1.author_name});
                                self.handleReset('formValidate1');
                                layer.close(index);
                            }
                        }).catch(function (err) {
                            console.log(err);
                        })
                    }else {
                        this.$Message.error('Fail!');
                    }
                  })
            },
            ResetAlert (name) {
                this.$refs[name].resetFields();
            },
	       getAllAuthor () {
	       		let self = this;
	       		this.$axios.get("/getAllAuthor")
                    .then(function (res) {
                        self.authorList = res.data;
                    }).catch(function (err) {
                        console.log(err);
                	})
	       	}
        },
        mounted () {
           this.getAllAuthor();
        }
    }
</script>
<style type="text/css" scoped>
.formClass{
    padding-top: 30px;
    padding-right: 30px;
    
}
</style>