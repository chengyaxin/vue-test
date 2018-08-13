<template>
    <Form :model="formItem" :label-width="80">
        <FormItem label="*语录内容">
            <Input v-model="formItem.textarea" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="Enter something..." required></Input>
        </FormItem>
        <FormItem label="*语录属性">
            <Select v-model="formItem.select" required>
                <Option value="1">爱情语录</Option>
                <Option value="2">经典搞笑语录</Option>
                <Option value="3">名人语录</Option>
                <Option value="4">人生感悟</Option>
            </Select>
        </FormItem>
       <FormItem label="*心情图片">
           <div class="demo-upload-list" v-for="item in uploadList">
               <template v-if="item.status === 'finished'">
                   <img :src="item.url">
                   <div class="demo-upload-list-cover">
                       <Icon type="ios-eye-outline" @click.native="handleView(item.name)"></Icon>
                       <Icon type="ios-trash-outline" @click.native="handleRemove(item)"></Icon>
                   </div>
               </template>
               <template v-else>
                   <Progress v-if="item.showProgress" :percent="item.percentage" hide-info></Progress>
               </template>
           </div>
           <Upload
                   ref="upload"
                   :show-upload-list="false"
                   :default-file-list="defaultList"
                   :on-success="handleSuccess"
                   :format="['jpg','jpeg','png','gif']"
                   :max-size="2048"
                   :on-format-error="handleFormatError"
                   :on-exceeded-size="handleMaxSize"
                   :before-upload="handleBeforeUpload"
                   multiple
                   type="drag"
                   action="http://localhost:3334/fileUpload"
                   style="display: inline-block;width:58px;">
               <div style="width: 58px;height:58px;line-height: 58px;">
                   <Icon type="ios-camera" size="20"></Icon>
               </div>
           </Upload>
           <Modal title="View Image" v-model="visible">
               <img :src="'https://o5wwk8baw.qnssl.com/' + imgName + '/large'" v-if="visible" style="width: 100%">
           </Modal>
       </FormItem>
        <FormItem>
            <Button type="primary" @click="handleSubmit()">Submit</Button>
            <Button style="margin-left: 8px">Cancel</Button>
        </FormItem>
    </Form>
</template>
<script>
import {Message} from 'iview';
    export default {
        data () {
            return {
                formItem: {
                    select: '',
                    textarea: ''
                },
                defaultList: [
                ],
                imgName: '',
                visible: false,
                uploadList: []
            }
        },
        methods: {
            handleView (name) {
                this.imgName = name;
                this.visible = true;
            },
            handleRemove (file) {
                const fileList = this.$refs.upload.fileList;  //对应上文的ref="upload"
                this.$axios.post("/deleteFile","fileName="+fileList[0].name)
                    .then(function (res) {
                        console.log(res.data);
                    }).catch(function (err) {
                        console.log(err);
                })
                this.$refs.upload.fileList.splice(fileList.indexOf(file), 1);
            },
            handleSuccess (res, file) {
                file.url = '../../static/images/'+res.fileName;
                file.name = res.fileName;
            },
            handleFormatError (file) {
                this.$Notice.warning({
                    title: 'The file format is incorrect',
                    desc: 'File format of ' + file.name + ' is incorrect, please select jpg or png or gif.'
                });
            },
            handleMaxSize (file) {
                this.$Notice.warning({
                    title: 'Exceeding file size limit',
                    desc: 'File  ' + file.name + ' is too large, no more than 2M.'
                });
            },
            handleBeforeUpload () {
                const check = this.uploadList.length < 5;
                if (!check) {
                    this.$Notice.warning({
                        title: 'Up to five pictures can be uploaded.'
                    });
                }
                return check;
            },
            //提交表单
            handleSubmit() {
              let _this = this;
               try {
                   var param = "typeId="+this.formItem.select+"&content="+this.formItem.textarea+"&img="+this.uploadList[0].name;
                   this.$axios.post("/submitData",param)
                       .then(function (res) {
                           console.log(res);
                           _this.$Message.success({
                             content: '上传成功!',
                             duration: 10,
                             closable: true
                         });
                       }).catch(function (err) {
                         _this.$Message.error({
                               content: '上传失败!',
                               duration: 10,
                               closable: true
                           });
                      })
                  //清空所填项
                  this.formItem.select = "";
                  this.formItem.textarea = "";
                  this.uploadList = [];
               }catch (e) {
                   _this.$Message.error({
                       content: '带*号项为必填项',
                       duration: 10,
                       closable: true
                   });
               }
            }
        },
        mounted () {
            this.uploadList = this.$refs.upload.fileList;
        }
    }
</script>
<style>
    .demo-upload-list{
        display: inline-block;
        width: 60px;
        height: 60px;
        text-align: center;
        line-height: 60px;
        border: 1px solid transparent;
        border-radius: 4px;
        overflow: hidden;
        background: #fff;
        position: relative;
        box-shadow: 0 1px 1px rgba(0,0,0,.2);
        margin-right: 4px;
    }
    .demo-upload-list img{
        width: 100%;
        height: 100%;
    }
    .demo-upload-list-cover{
        display: none;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0,0,0,.6);
    }
    .demo-upload-list:hover .demo-upload-list-cover{
        display: block;
    }
    .demo-upload-list-cover i{
        color: #fff;
        font-size: 20px;
        cursor: pointer;
        margin: 0 2px;
    }
</style>