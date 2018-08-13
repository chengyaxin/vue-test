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
                        title: '诗词题目',
                        key: 'title',
                        align: 'center',
                         width: 150,
                    },
                    {
                        title: '诗词作者',
                        key: 'author_name',
                        filters: [],
                        width: 150,
                        filterMultiple: false,
                        filterMethod (value, row) {
                            //遍历filters,找到与之相对应的value
                            for(var item of this.filters)
                            {
                                if(item.value === value)
                                {
                                    return row.author_name == item.label;
                                }
                            }
                        },
                        align: 'center'
                    },
                    {
                        title: '诗词简介',
                        key: 'poem_produce',
                        align: 'center', 
                        width:500,
                    },
                    {
                        title: '诗词内容',
                        key: 'content',
                        align: 'center', 
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
                                            this.remove(params.index)
                                            this.list.splice(params.index, 1);
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
            getAllPoem()
            {
                this.$axios.get("/getAllPoem").then((res) =>{
                    this.data1 = res.data;
                    var pageSize = this.$refs['pages'].pageSize;
                    this.list.splice(0, this.list.length);
                    this.list=this.data1.slice(0,1 * pageSize);
                }).catch((err)=>{
                    console.log(err);
                })
            },
            getAllAuthor()
            {
              this.$axios.get("/getAllAuthor").then((res)=>{
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
                    content: `诗词内容：${this.data1[index].content}<br>诗词简介：${this.data1[index].poem_produce}<br>`
                })
            },
            remove (index) {
                //index是索引，而非id
                var id = this.list[index].Id;
                 this.$axios.post("/deletePoem","Id="+id).then((res) =>{
                    console.log(res);    
                }).catch((err)=>{
                    console.log(err);
                })  
            }
        },
        mounted()
        {
            this.getAllPoem();
            this.getAllAuthor();
        }
    }
    export default event;
</script>
<style scoped>
</style>