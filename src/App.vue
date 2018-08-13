<style scoped>
.layout{
    border: 1px solid #d7dde4;
    background: #f5f7f9;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
    width: 100%;
    height: 100%;
}
.layout-logo{
    width: 100px;
    height: 30px;
    background: #5b6270;
    border-radius: 3px;
    float: left;
    position: relative;
    top: 15px;
    left: 20px;
}
.layout-nav{
    width: 420px;
    margin: 0 auto;
    margin-right: 20px;
}
.ivu-layout{
	height: 100%;
}
.ivu-layout-header,.ivu-menu-dark {
    background: #17233d;
}
.ivu-layout-sider{
	background-color: #17233D !important;
}
.ivu-menu-light{
	background: none;
}
.ivu-layout-sider-children .ivu-menu
{
	position:inherit;
}
.ivu-menu-light.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu)
{
	background-color: #5B6270;
	color: white;
}
.ivu-menu-light.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu):after
{
	background: #17233D;
}
.ivu-menu{
	color: white;
}
.ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened,.ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened .ivu-menu-submenu-title,.ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened .ivu-menu-submenu-title
{
	background: #17233D;
}
.ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened .ivu-menu-submenu-title
{
	background: #17233D;
}
a{
	text-decoration:none;
	out-line: none;
	color: #515a6e;
}
</style>
<template>
    <div class="layout">
        <Layout>
            <Header>
                <Menu mode="horizontal" theme="dark" active-name="1" >
                    <div class="layout-logo"></div>
                    <div class="layout-nav">
                        
                    </div>
                </Menu>
            </Header>
            <Layout>
                <Sider hide-trigger :style="{background: '#fff'}">
                    <Menu  theme="light" width="auto" :open-names="['1']">
                        <Submenu  name="1">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                经典语录
                            </template>
                            <router-link to="/ylList">
                            	<MenuItem name="1-1">                            		
                            		语录列表
                            	</MenuItem>
                            </router-link>
                            <router-link to="/addYl">
                                <MenuItem name="1-2">添加语录</MenuItem>
                            </router-link>

                        </Submenu>
                        <Submenu name="2">
                            <template slot="title">
                                <Icon type="ios-keypad"></Icon>
                                诗句大全
                            </template>
                             <router-link to="PoemList">
                                <MenuItem name="2-1">诗词列表</MenuItem>
                            </router-link>
                            <router-link to="/AddPoem">
                               <MenuItem name="2-2">添加诗词</MenuItem>
                            </router-link>  
                        </Submenu>
                    </Menu>
                </Sider>
                <Layout :style="{padding: '0 24px 0px'}">
                    <Breadcrumb :style="{margin: '24px 0'}">
                    </Breadcrumb>
                  	  <Content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">
                        <router-view>

                        </router-view>
                    </Content>
                </Layout>
            </Layout>
        </Layout>
    </div>
</template>
<script>
    export default {
        name: 'app',
    }
</script>