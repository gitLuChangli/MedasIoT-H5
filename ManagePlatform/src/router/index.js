import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/',
            name: '首页',
            component: (resolve) => require(['@/components/admin'], resolve),
            children: [{
                    path: '/user/',
                    component: (resolve) => require(['@/components/user/list'], resolve)
                },
                {
                    path: '/device/type',
                    component: (resolve) => require(['@/components/device/type'], resolve)
                },
                {
                    path: '/device/version',
                    component: (resolve) => require(['@/components/device/version'], resolve)
                },
                {
                    path: '/device/add',
                    component: (resolve) => require(['@/components/device/add'], resolve)
                },
                {
                    path: '/device/list',
                    component: (resolve) => require(['@/components/device/list'], resolve)
                },
                {
                    path: '/device/data',
                    component: (resolve) => require(['@/components/device/data'], resolve)
                },
                {
                    path: '/system/resource',
                    component: (resolve) => require(['@/components/system/resource'], resolve)
                },
                {
                    path: '/system/authority',
                    component: (resolve) => require(['@/components/system/authority'], resolve)
                },
                {
                    path: '/system/role',
                    component: (resolve) => require(['@/components/system/role'], resolve)
                },
                {
                    path: 'system/company',
                    component: (resolve) => require(['@/components/system/company'], resolve)
                },
                {
                    path: '/app/list',
                    component: (resolve) => require(['@/components/app/list'], resolve)
                },
                {
                    path: '/app/version',
                    component: (resolve) => require(['@/components/app/version'], resolve)
                },
                {
                    path: '/app/task',
                    component: (resolve) => require(['@/components/app/task'], resolve)
                },
                {
                    path: '/app/records',
                    component: (resolve) => require(['@/components/app/records'], resolve)
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