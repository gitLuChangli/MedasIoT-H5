<template>
	<div>
		<div class="toolbar">
			<p class="title">角色管理</p>
		</div>
		<div class="toolbar">
			<el-button
				type="primary el-icon-plus"
				circle
				style="float: right; clear: both"
				size="mini"
				@click="showNewClick"
			/>
		</div>
		<div class="content">
			<el-table :data="roles" style="width: 100%; margin-bottom: 20px;" border stripe size="mini">
				<el-table-column prop="name" label="ID" width="300" sortable />
				<el-table-column prop="title" label="標題" />
				<el-table-column prop="details" label="詳情" />
				<el-table-column label="權限">
					<template slot-scope="scope">
						<el-link
							v-for="item in scope.row.permissionTitles"
							:key="item"
							type="primary"
							style="margin: 4px 8px;"
						>{{item}}</el-link>
					</template>
				</el-table-column>
				<el-table-column label="操作" align="center" width="150px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="editClick(scope.row)">修改</el-button>
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
		</div>
		<el-dialog
			v-bind:title="dialog_title"
			:visible.sync="show_dialog"
			center
			custom-class="dialog-n"
			:destroy-on-close="true"
			:close-on-click-modal="false"
		>
			<el-form ref="role" :model="role" label-position="left" size="small" :rules="rules">
				<el-form-item label="ID" prop="name">
					<el-input v-model="role.name" />
				</el-form-item>
				<el-form-item label="標題" prop="title">
					<el-input v-model="role.title" />
				</el-form-item>
				<el-form-item label="詳情">
					<el-input v-model="role.details" />
				</el-form-item>
				<el-form-item label="權限">
					<el-select v-model="role.permissionIds" multiple placeholder="請選擇" style="width: 100%">
						<el-option v-for="item in authoarities" :key="item.id" :label="item.title" :value="item.id"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="saveClick">{{button}}</el-button>
					<el-button @click="resetClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { queryAuthorities, saveRole, queryRoles, deleteRole, disableRole } from '../../api/iot.js'
	export default {
		data() {
			return {
                roles: [],
				dialog_title: '',
				show_dialog: false,
				role: {
					id: '',
					name: '',
					title: '',
					details: '',
					permissionIds: [],
					status: ''
				},
				modify: false,
				authoarities: [],
				button: '',
				rules: {
					name: [{ required: true, message: '請輸入ID', trigger: 'blur' }],
					title: [{ required: true, message: '請輸入標題', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			queryAuthorities().then(res => {
				if (res.status === 200) {
					this.authoarities = res.data.data
				}
			})
			this.queryRoles()
		},
		methods: {
			clearCache() {
				this.role.id = ''
				this.role.name = ''
				this.role.title = ''
				this.role.details = ''
				this.role.permissionIds = []
			},
            showNewClick: function(e) {
				this.clearCache()
				this.button	= '新增'
				this.dialog_title = this.button + '權限'
				this.show_dialog = true
				this.modify = false
            },
			saveClick: function(e) {
				this.$refs['role'].validate(valid => {
					if (valid) {
						saveRole(this.modify, this.role).then(res => {
							if (res.status === 200) {
								this.showSuccess(`${this.button}成功`)
								this.queryRoles()
								this.show_dialog = false
							} else {
								this.showError(`${this.button}失敗`)
							}
						})
					}
				})
			},
			resetClick: function(e) {
				this.clearCache()
				this.$refs['role'].resetFields()
			},
			queryRoles() {
				queryRoles().then(res => {
					if (res.status === 200) {
						this.roles = res.data.data
					}
				})
			},
			editClick: function(val) {
				this.button = '修改'
				this.dialog_title = `${this.button}角色`
				this.role = Object.assign({}, val)
				this.show_dialog = true
				this.modify = true
			},
			deleteClick: function(val) {
				this.$confirm(`此操作將徹底刪除：<br /><strong>${val.name} / ${val.title}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteRole(val.id).then(res => {
						if (res.status === 200) {
							this.showSuccess(`刪除成功`)
							this.queryRoles()
						} else {
							val.status = val.status === 1 ? 0 : 1
							this.showError(`刪除失敗`)
						}
					})
				})
			},
			handleDisableChange: function(val) {
				var _msg = val.status === 1 ? '禁用' : '啟用'
				disableRole(val.id, val.status).then(res => {
					if (res.status === 200) {
						this.showSuccess(`${_msg}成功`)
					} else {
						this.showError(`${_msg}失敗`)
						val.status = val.status === 0 ? 1 : 0
					}
				})
			}
		}
	}
</script>
