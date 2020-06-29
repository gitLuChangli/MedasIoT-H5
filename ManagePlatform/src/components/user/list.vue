<template>
	<div>
		<div class="toolbar">
			<p class="title">用戶列表</p>
		</div>
		<div class="toolbar" style="text-align: center">
			所屬部門：
			<el-cascader
				:options="companies"
				:props="cascader_props"
				clearable
				placeholder="請選擇部門"
				v-model="companyIds"
				size="small"
				style="width: 500px"
				@change="companyChange"
			/>
			<el-button
				type="primary el-icon-plus"
				circle
				style="float: right"
				size="mini"
				@click="showNewClick"
			/>
		</div>
		<div class="content">
			<el-table :data="users" border stripe size="mini">
				<el-table-column prop="no" label="工號" width="100" />
				<el-table-column prop="name" label="姓名" align="center" width="130" />
				<el-table-column prop="companyName" label="部門" align="center" />
				<el-table-column prop="email" label="郵箱" align="center" />
				<el-table-column prop="ext" label="分機" align="center" />
				<el-table-column label="操作" width="200px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="roleClick(scope.row)">角色</el-button>
						<el-button size="mini" type="text" @click="editClick(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="resetClick(scope.row)">重置</el-button>
						<el-button size="mini" type="text" @click="deleteClick(scope.row)">刪除</el-button>
					</template>
				</el-table-column>
				<el-table-column label="狀態" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-switch
							v-model="scope.row.status"
							:width="32"
							@change="handleDisableChange(scope.row)"
							:active-value="0"
							:inactive-value="1"
						/>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				style="margin-top: 16px"
				@size-change="queryUsers"
				@current-change="queryUsers"
				:current-page.sync="current_page"
				:page-sizes="[10, 20, 30, 50]"
				:page-size="page_size"
				layout="total, prev, pager, next"
				:hide-on-single-page="false"
				:total="total"
			/>
			<el-dialog
				:title="dialog_title"
				:visible.sync="show_dialog"
				custom-class="dialog-n"
				center
				:close-on-click-modal="true"
				:destroy-on-close="true"
				top="16px"
			>
				<el-form ref="user" :model="user" label-position="left" size="small" :rules="rules">
					<el-form-item label="工號" prop="no">
						<el-input v-model="user.no" :readonly="modify" />
					</el-form-item>
					<el-form-item label="姓名" prop="name">
						<el-input v-model="user.name" />
					</el-form-item>
					<el-form-item label="郵箱" prop="email">
						<el-input v-model="user.email" />
					</el-form-item>
					<el-form-item label="手機號">
						<el-input v-model="user.phone" />
					</el-form-item>
					<el-form-item label="分機號">
						<el-input v-model="user.ext" />
					</el-form-item>
					<el-form-item label="微信openid">
						<el-input v-model="user.openId" />
					</el-form-item>
					<el-form-item label="香信openid">
						<el-input v-model="user.icivetId" />
					</el-form-item>
					<el-form-item label="所屬部門">
						<el-cascader
							v-model="user.companyIds"
							:options="companies"
							style="width: 100%"
							size="small"
							:props="cascader_props"
						></el-cascader>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="saveClick">{{button}}</el-button>
						<el-button @click="show_dialog = false">取消</el-button>
					</el-form-item>
				</el-form>
			</el-dialog>
			<el-dialog
				title="用户角色"
				:visible.sync="show_dialog_role"
				fullscreen
				center
				:close-on-click-modal="true"
				:destroy-on-close="true"
			>
				<div style="width: 930px; margin: 0 auto;">
					<el-card class="card-300">
						<div slot="header">
							<span>設置角色</span>
							<el-button style="float: right;" size="mini" type="primary" @click="setRoleClick">保存</el-button>
						</div>
						<div>
							<el-checkbox-group v-model="userRole.roleIds" size="small" @change="rolesChange">
								<el-checkbox
									v-for="item in roles"
									:label="item.id"
									:key="item.id"
									border
									style="width: 100%; margin: 2px 0;"
								>{{item.title}}</el-checkbox>
							</el-checkbox-group>
						</div>
					</el-card>
					<el-card class="card-300">
						<div slot="header" class="clearfix">
							<span>菜單</span>
						</div>
						<div>
							<el-menu
								background-color="#393f4c"
								text-color="#ebf6f7"
								active-text-color="#ffffff"
								style="border: none"
								show-timeout="100"
								hide-timeout="100"
								:unique-opened="true"
							>
								<el-submenu :index="item.url" v-for="item in menus" :key="item.id">
									<template slot="title">
										<i :class="item.icon"></i>
										<span>{{item.title}}</span>
									</template>
									<el-menu-item
										v-for="item2 in item.descendants"
										:key="item2.id"
										:index="item2.url"
									>{{item2.title}}</el-menu-item>
								</el-submenu>
							</el-menu>
						</div>
					</el-card>
					<el-card class="card-300">
						<div slot="header" class="clearfix">
							<span>按鈕</span>
						</div>
						<el-tree :data="buttons" :props="tree_props"></el-tree>
					</el-card>
				</div>
			</el-dialog>
		</div>
	</div>
</template>
<script>

	import { queryCompanies, queryUsers, saveUser, queryAncestorIds, resetPwd, disableUser, deleteUser, queryRoles, setUserRoles, queryRoleResources } from '../../api/iot.js'

	export default {
		data() {
			return {
				companyIds: [],
				companies: [],
				current_page: 1,
				page_size: 10,
				total: 0,
				users: [],
				user: {
					id: '',
					no: '',
					name: '',
					email: '',
					openId: '',
					icivetId: '',
					ext: '',
					phone: '',
					companyIds: [],
					companyId: ''
				},
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendants',
					checkStrictly: true
				},
				tree_props: {
					children: 'descendants',
					label: 'title'
				},
				show_dialog: false,
				dialog_title: '',
				button: '',
				modify: false,

				rules: {
					no: [{ required: true, message: '請輸入工號', trigger: 'blur' }],
					name: [{ required: true, message: '請輸入姓名', trigger: 'blur' }],
					email: [{ required: true, message: '請輸入郵箱', trigger: 'blur' }]
				},
				show_dialog_role: false,
				roles: [],
				userRole: {
					id: '',
					roleIds: []
				},
				menus: [],
				buttons: []
			}
		},
		mounted() {
			queryCompanies().then(res => {
				if (res.status === 200) {
					this.companies = res.data.data
				}
			})
			this.queryUsers('')
		},
		methods: {
			companyChange: function(e) {
				this.queryUsers()
			},
			clearUser() {
				this.user.id = ''
				this.user.no = ''
				this.user.name = ''
				this.user.email = ''
				this.user.openId = ''
				this.user.icivetId = ''
				this.user.ext = ''
				this.user.phone = ''
				this.user.companyIds = []
				this.user.companyId = ''
			},
			showNewClick: function(e) {
				this.clearUser()
				this.button = '新增'
				this.modify = false
				this.dialog_title = `${this.button}用戶`
				this.show_dialog = true
			},
			roleClick: function(val) {
				this.userRole.id = val.id
				queryRoles().then(res => {
					if (res.status === 200) {
						this.roles = res.data.data
						this.show_dialog_role = true
						console.log(this.roles)
					}
				})
			},
			editClick: function(val) {
				this.user = Object.assign({}, val)
				queryAncestorIds(val.companyId).then(res => {
					if (res.status === 200) {
						this.user.companyIds = res.data.data
						this.button = `修改`
						this.modify = true
						this.dialog_title = `${this.button}用戶`
						this.show_dialog = true
					}
				})
			},
			deleteClick: function(val) {
				this.$confirm(`此操作將徹底刪除：<br /><strong>${val.no} ${val.name}</strong><br />是否繼續？`, '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning',
						dangerouslyUseHTMLString: true
					}).then(() => {
						deleteUser(val.id).then(res => {
							if (res.status === 200) {
								this.showSuccess(`刪除成功`)
								this.queryUsers()
							} else {
								this.showError(`刪除失敗`)
							}
						})
					}
				)
			},
			queryUsers() {
				var companyId = ''
				if (this.companyIds.length > 0) {
					companyId = this.companyIds[this.companyIds.length - 1]
				}
				this.users = []
				queryUsers(companyId, this.current_page - 1, this.page_size).then(res => {
					if (res.status === 200) {
						if (res.data.data !== undefined) {
							this.users = res.data.data.content
							this.total = res.data.data.totalElements
						} else {
							this.users = []
							this.total = 0
						}
					} else {
						this.showError(`查詢失敗`)
					}
				})
			},
			resetClick: function (val) {
				this.$confirm(`此操作將重置：<br /><strong>${val.no} ${val.name}</strong><br />的密碼，是否繼續？`, '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					resetPwd(val.id).then(res => {
						if (res.status === 200) {
							this.showSuccess(`重置成功`)
						} else {
							this.showError(`重置失敗`)
						}
					})
				})
			},
			handleDisableChange: function (val) {
				var msg = val.status === 1 ? '停用' : '啓用'
				disableUser(val.id, val.status).then(res => {
					if (res.status === 200) {
						this.showSuccess(`${msg}成功`)
						this.queryUsers()
					} else {
						this.showError(`${msg}失敗`)
						val.status = val.status === 1 ? 0 : 1
					}
				})
			},
			saveClick: function (e) {
				this.$refs.user.validate(valid => {
					if (valid) {
						saveUser(this.modify, this.user).then(res => {
							if (res.status === 200) {
								this.showSuccess(`${this.button}成功`)
								this.queryUsers()
								this.show_dialog = false
							} else {
								this.showError(`${this.button}失敗`)
							}
						})
					}
				})
			},
			setRoleClick: function(e) {
				setUserRoles(this.userRole).then(res => {
					if (res.status === 200) {
						this.showSuccess(`設置成功`)
					} else {
						this.showError(`設置失敗`)
					}
				})
			},
			rolesChange: function(e) {
				this.menus = []
				queryRoleResources(this.userRole.roleIds).then(res => {
					if (res.status === 200) {
						this.menus = res.data.data.menus
						this.buttons = res.data.data.buttons
					}
				})
			}
		}
	}
</script>
