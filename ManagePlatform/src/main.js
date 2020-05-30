// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import promise from 'es6-promise'
import ElementUI from 'element-ui'
import 'babel-polyfill'
import 'element-ui/lib/theme-chalk/index.css'
import App from './App'
import router from './router'
import axios from 'axios'
import qs from 'qs'
import Vuex from 'vuex'
import store from './vuex/store'
import echarts from 'echarts'
import NProgress from '../static/nprogress/nprogress'
import '../static/nprogress/nprogress.css'
import '../static/style/style.css'

promise.polyfill()
Vue.config.productionTip = false
Vue.use(ElementUI)
Vue.use(Vuex)
Vue.prototype.$axios = axios
Vue.prototype.$qs = qs
Vue.prototype.$store = store
Vue.prototype.$echarts = echarts

Vue.prototype.RES_URL = "http://127.0.0.1:8080"

NProgress.configure({
    easing: 'ease', // 动画方式    
    speed: 500, // 递增进度条的速度    
    showSpinner: false, // 是否显示加载ico    
    trickleSpeed: 200, // 自动递增间隔    
    minimum: 0.3 // 初始化时的最小百分比
})

router.beforeEach((to, from, next) => {
    NProgress.start()
    next()
})

router.afterEach(() => {
    NProgress.done()
})


/* eslint-disable no-new */
new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<App/>'
})