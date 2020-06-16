<template>
	<div>
		<el-container class="container-main">
			<el-aside :width="!collapse ? '200px' : '64px'" style="background: #393f4c;">
				<div class="logo-container">
					<img
						:src="!collapse ? '../../static/ic_logo.png' :'../../static/ic_logo2.png'"
						:class="!collapse ? 'logo' : 'logo2'"
					/>
				</div>
				<el-menu
					background-color="#393f4c"
					text-color="#ebf6f7"
					active-text-color="#ffffff"
					style="border: none"
					show-timeout="100"
					hide-timeout="100"
					:router="true"
					:unique-opened="true"
					:collapse="collapse"
					:default-active="active"
				>
					<el-submenu :index="item.path" v-for="(item, index) in menuData" :key="index">
						<template slot="title">
							<i :class="item.icon"></i>
							<span>{{item.name}}</span>
						</template>
						<el-menu-item
							v-for="(item2, index2) in item.items"
							:key="index2"
							:index="item2.path"
							@click="changeRoute(item, item2)"
						>{{item2.name}}</el-menu-item>
					</el-submenu>
				</el-menu>
			</el-aside>
			<el-container direction="vertical">
				<el-header class="header">
					<i
						:class="!collapse ? 'el-icon-s-fold menu-btn' : 'el-icon-s-unfold menu-btn'"
						@click="navClick"
					/>
					<i class="el-icon-refresh menu-btn" />
					<el-breadcrumb
						separator-class="el-icon-arrow-right"
						style="line-height: 60px; padding-left: 16px; float: left;"
					>
						<el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
						<el-breadcrumb-item v-for="item in currentPath" :key="item.path">{{item.name}}</el-breadcrumb-item>
					</el-breadcrumb>
					<el-dropdown style="float: right; background: transparent;">
						<el-button
							style="height: 59px; margin: 0px; padding: 0px 8px; line-height: 60px; border: none;"
						>
							<el-avatar :size="size" :src="avatar" style="margin: 16px 6px; padding: 0px; float: left;"></el-avatar>
							<span>卢昌利</span>
							<i class="el-icon-arrow-down el-icon--right"></i>
						</el-button>
						<el-dropdown-menu slot="dropdown">
							<el-dropdown-item>
								<i class="el-icon-user" />个人信息
							</el-dropdown-item>
							<el-dropdown-item>
								<i class="el-icon-lock" />修改密码
							</el-dropdown-item>
							<el-dropdown-item>
								<i class="el-icon-switch-button" />退出登录
							</el-dropdown-item>
						</el-dropdown-menu>
					</el-dropdown>
					<el-badge :value="v" class="u-bage" :hidden="v == 0">
						<i class="el-icon-message-solid" />
					</el-badge>
					<i class="el-icon-monitor menu-btn" style="float: right" />
				</el-header>
				<el-main style="background: #f5f7f9; margin: 0px; padding: 0px; min-width: 1000px">					
					<router-view />
				</el-main>
				<el-footer class="footer">
					Copyright © 2020 medasiot C次集團華南檢測中心物聯網產品部
					<b>系統版本：1.0.0.1</b>
				</el-footer>
			</el-container>
		</el-container>
	</div>
</template>
<script>
	export default {
		data() {
			return {
				active: '',
				collapse: false,
				size: 28,
				avatar: '../../static/ic_avatar.png',
				v: 0,
				currentPath: [],
				menuData: [
					{
						name: '首頁',
						path: '/',
						icon: 'el-icon-s-data',
						items: [
							{
								name: '主控台',
								path: '/main',
							},
							{
								name: '監控台',
								path: '/view'
							},
							{
								name: '工作台',
								path: '/workspace'
							}
						]
					},
					{
						name: '部門管理',
						path: '/company',
						icon: 'el-icon-office-building',
						items: [
							{
								name: '部门列表',
								path: '/company/'
							},
							{
								name: '新增部门',
								path: '/company/new'
							}
						]
					},
					{
						name: '用戶管理',
						path: '/user',
						icon: 'el-icon-s-custom',
						items: [
							{
								name: '用戶列表',
								path: '/user/'
							},
							{
								name: '禁用列表',
								path: '/user/disabled'
							},
							{
								name: '新增用戶',
								path: '/user/new'
							}
						]
					},
					{
						name: '應用管理',
						path: '/app',
						icon: 'el-icon-s-promotion',
						items: []
					},
					{
						name: '消息管理',
						path: '/msg',
						icon: 'el-icon-s-comment',
						items: []
					},
					{
						name: '設備管理',
						path: '/device/',
						icon: 'el-icon-cpu',
						items: [
							{
								name: '設備類型',
								path: '/device/type'
							},
							{
								name: '設備版本',
								path: '/device/version'
							},
							{
								name: '錄入設備',
								path: '/device/add'
							},
							{
								name: '設備列表',
								path: '/device/list'
							},
							{
								name: '生產數據',
								path: '/device/data'
							},
							{
								name: '異常數據',
								path: '/device/exception'
							}
						]
					},
					{
						name: '系統管理',
						path: '/system',
						icon: 'el-icon-s-tools',
						items: [{
							name: '資源管理',
							path: '/system/resource'
						},
						{
							name: '權限管理',
							path: '/system/authority'
						},
						{
							name: '角色管理',
							path: '/system/role'
						},
						{
							name: '部門管理',
							path: '/system/company'
						}]
					},
					{
						name: '個人中心',
						path: '/me',
						icon: 'el-icon-s-help',
						items: []
					}
				]
			}
		},
		watch: {
			$route(to, from) {
				this.active = to.path
			}
		},
		mounted() {
			this.active = this.$route.path
		},
		methods: {
			navClick: function (e) {
				this.collapse = !this.collapse
			},
			changeRoute: function (val1, val2) {
				this.currentPath = []
				this.currentPath.push({
					path: val1.path,
					name: val1.name
				})
				this.currentPath.push(val2)
			},
			removeTab(targetName) {
				let _tabs = this.tabs;
				let activeName = this.focus_tab;
				if (activeName === targetName) {
					_tabs.forEach((tab, index) => {
						if (tab.name === targetName) {
							let nextTab = _tabs[index + 1] || _tabs[index - 1]
							if (nextTab) {
								activeName = nextTab.name;
							}
						}
					})
				}
				
				this.focus_tab = activeName;
				this.tabs = _tabs.filter(tab => tab.name !== targetName)
			}
		}
	}
</script>
