import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/',
            name: '首页',
            component: (resolve) => require(['@/components/admin'], resolve),
            children: [{
                    path: '/company/',
                    name: '部门列表',
                    component: (resolve) => require(['@/components/company/list'], resolve)
                },
                {
                    path: '/company/new',
                    name: '新建部门',
                    component: (resolve) => require(['@/components/company/new'], resolve)
                },
                {
                    path: '/user/',
                    name: '用户列表',
                    component: (resolve) => require(['@/components/user/list'], resolve)
                },
                {
                    path: '/user/new',
                    name: '新建用户',
                    component: (resolve) => require(['@/components/user/new'], resolve)
                },
                {
                    path: '/user/disabled',
                    name: '停用列表',
                    component: (resolve) => require(['@/components/user/disabled'], resolve)
                },
                {
                    path: '/device/type',
                    name: '设备类型',
                    component: (resolve) => require(['@/components/device/type'], resolve)
                },
                {
                    path: '/device/add',
                    name: '录入设备',
                    component: (resolve) => require(['@/components/device/add'], resolve)
                },
                {
                    path: '/device/list',
                    name: '设备列表',
                    component: (resolve) => require(['@/components/device/list'], resolve)
                },
                {
                    path: '/device/data',
                    name: '生产数据',
                    component: (resolve) => require(['@/components/device/data'], resolve)
                },
                {
                    path: '/res/menu',
                    name: '菜單管理',
                    component: (resolve) => require(['@/components/resource/menu'], resolve)
                },
                {
                    path: '/res/button',
                    name: '按鈕管理',
                    component: (resolve) => require(['@/components/resource/menu'], resolve)
                },
                {
                    path: '/res/new',
                    name: '新增資源',
                    component: (resolve) => require(['@/components/resource/new'], resolve)
                }
            ]
        },
        {
            path: '/login',
            name: 'login',
            component: (resolve) => require(['@/components/login'], resolve)
        }
    ]
})