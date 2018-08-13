<template>
	<Form ref="formValidate1" :model="formValidate1" :rules="ruleValidate1" :label-width="80" class="formClass">
         <FormItem label="作者名称" prop="author_name">
            <Input v-model="formValidate1.title" placeholder="Enter author_name"></Input>
        </FormItem>
        <FormItem label="作者朝代" prop="author_dynasty">
            <Select v-model="formValidate1.author_dynasty" placeholder="Select dynasty">
                
            </Select>
        </FormItem>
        <FormItem label="作者简介" prop="author_info">
            <Input v-model="formValidate1.author_info" placeholder="Enter author_info" type="textarea" :autosize="{minRows: 8,maxRows: 5}"></Input>
        </FormItem>
        <FormItem>
            <Button type="primary" @click="handleSubmit()">Submit</Button>
            <Button @click="handleReset()" style="margin-left: 8px">Reset</Button>
        </FormItem>
    </Form>
</template>
<script type="text/javascript">
import bus from "../../static/js/main.js"
export default {
 	name:"alert",
 	data(){
 		return {
 			 formValidate1:{
                    author_name:'',
                    author_dynasty:'',
                    author_info:''
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
 	// mounted()
 	// {
 	// 	 this.bus.$emit('sendAuthor','首页')
 	// }
 }
</script>
<style type="text/css" scoped>
	.formClass{
        padding-top: 30px;
        padding-right: 30px;
        
    }
</style>