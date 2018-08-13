<template>
    <div>
    <Table border :columns="columns1" :data="list" ref="table"></Table>
         <div style="margin: 10px;overflow: hidden">
            <div style="float: right;">
                <Page :total="pageCount" :current="currentPage" @on-change="changePage" show-sizer ref="pages"   @on-page-size-change='handlePageSize'></Page>
            </div>
        </div>
        <div style="margin: 10px;overflow: hidden">
            <div style="float: left;">
                <Button type="primary" size="large" @click="exportData(1)"><Icon type="ios-download-outline"></Icon> Export source data</Button>
            </div>
        </div>
    </div>
</template>
<script>
     var event =  {
        data () {
            return {
                columns1: [
                	{
                        type: 'selection',
                        width: 60,
                        align: 'center'
                    },
                    {
                        title: 'Id',
                        key: 'Id',
                        align: 'center',
                        width: 80,
                        sortable: true,
                    },
                    {
                        title: '语录内容',
                        key: 'content',
                        align: 'center',
                    },
                    {
                        title: '文章属性',
                        key: 'type',
                        filters: [],
                        width: 150,
                        filterMultiple: false,

                        filterMethod (value, row) {
                            //遍历filters,找到与之相对应的value
                            for(var item of this.filters)
                            {
                                if(item.value === value)
                                {
                                    return row.type == item.label;
                                }
                            }
                        },
                        align: 'center'
                    },
                    {
                        title: '心情图片',
                        key: 'img',
                        align: 'center',
                        width:150,
                        render:(h,params)=>{
                        	return h("img",{
                        		attrs:{
                        			src:"../../static/images/"+params.row.img,
                                    style: 'width: 40px;height: 40px'
                        		}

                        	})
                        }
                    },
                     {
                        title: 'Action',
                        key: 'action',
                        width: 250,
                        align: 'center',
                        render: (h, params) => {
                               return h('div', [
                                h('Button', {
                                    props: {
                                        type: 'primary',
                                        size: 'small'
                                    },
                                    style: {
                                        marginRight: '5px'
                                    },
                                    on: {
                                        click: () => {
                                            this.show(params.index)
                                        }
                                    }
                                }, 'View'),
                                 h('Poptip', {
                                    props: {
                                        confirm: true,
                                        title: "确定删除这行数据吗?",
                                        placement:"left",
                                        transfer:true
                                    },
                                    style:{

                                    },
                                    on: {
                                        'on-ok': () => {

                                            console.log("delete");
                                            this.remove(params.index)
                                            this.list.splice(params.index, 1);
                                            console.log("delete success");
                                        },
                                        'on-cancel':()=>{
                                            this.$Message.info('You click cancel');
                                        }
                                    },
                                }, 
                                [
                                    h('Button', {
                                        props: {
                                            type: 'error',
                                            size: 'small'
                                        },
                                    }, 'Delete')
                                    ]
                                ),
                               
                            ]);
                        }
                    }
                ],
                data1: [],
                list:[],
                pageSize:10,
                currentPage:1
            }
        },
        computed:{
            pageCount(){
                return this.data1.length
            }
        },
        methods: {
            getYlList()
            {
                this.$axios.get("/getYlList").then((res) =>{
                    console.log(res);
                    this.data1 = res.data;
                    var pageSize = this.$refs['pages'].pageSize;
                    this.list.splice(0, this.list.length);
                    this.list=this.data1.slice(0,1 * pageSize);
                }).catch((err)=>{
                    console.log(err);
                })
            },
            getYlType()
            {
              this.$axios.get("/getYlType").then((res)=>{
                  console.log(res);
                  this.columns1[3].filters = res.data;
              }).catch((err)=>{
                  console.log(err);
              })
            },
            changePage () {
                var currentPage = this.$refs['pages'].currentPage;
                var pageSize = this.pageSize;
                this.list.splice(0, this.list.length);
                this.list=this.data1.slice((currentPage - 1) * pageSize,currentPage * pageSize);
            },
            handlePageSize (value){
                console.log(this.pageSize);
                this.pageSize = value;
                this.currentPage = 1;
                this.changePage(); 
            },
            exportData (type) {
                    this.$refs.table.exportCsv({
                        filename: 'The original data',
                        columns:this.columns1.filter((col, index) => col.type != "selection" && col.key != "action"),
                        data:this.data1
                    });
            },
            show (index) {
                this.$Modal.info({
                    title: 'detail',
                    content: `语录内容：${this.data1[index].content}<br>语录属性：${this.data1[index].type}<br>心情图片：${this.data1[index].img}`
                })
            },
            remove (index) {
                //index是索引，而非id
                var id = this.list[index].Id;
                 this.$axios.post("/removeYl","Id="+id).then((res) =>{
                    console.log(res);    
                }).catch((err)=>{
                    console.log(err);
                })
                
            }
        },
        mounted()
        {
            this.getYlList();
            this.getYlType();
        }
    }
    export default event;
</script>
<style scoped>
</style>