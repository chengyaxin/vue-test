import Vue from 'vue'
import Router from 'vue-router'
//import HelloWorld from '@/components/HelloWorld'
import YlList from "@/components/YlList"
import AddYl from "@/components/AddYl"
import AddPoem from "@/components/AddPoem"
import PoemList from "@/components/PoemList"
Vue.use(Router)

export default new Router({
//	mode:"history",   //去除地址栏后面加/#/
  routes: [
    {
      path: '/ylList',
      name:YlList,
      component:()=>import('../components/YlList.vue')
    },
    {
        path: '/addYl',
        name:AddYl,
        component:()=>import('../components/AddYl.vue')
    },
    {
        path: '/AddPoem',
        name:AddPoem,
        component:()=>import('../components/AddPoem.vue')
    },
    {
        path: '/PoemList',
        name:PoemList,
        component:()=>import('../components/PoemList.vue')
    },
  ]
})
