<template>
	<div>
		<div class="toolbar">
			<p class="title">應用列表</p>
		</div>
		<div class="toolbar">
			<el-button
				size="mini"
				icon="el-icon-plus"
				type="primary"
				style="float: right"
				circle
				@click="newClick"
			/>
		</div>
		<div class="content">
			<el-table :data="apps" border stripe size="mini">
				<el-table-column prop="appId" label="AppId" width="150" />
				<el-table-column prop="secret" label="Secret" />
				<el-table-column prop="name" label="名稱" />
				<el-table-column prop="details" label="說明" />
				<el-table-column prop="parentName" label="上級應用" />
				<el-table-column label="操作" align="center" width="150px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="paramClick(scope.row)">參數</el-button>
						<el-button size="mini" type="text" @click="editClick(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="deleteClick(scope.row)">删除</el-button>
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
			custom-class="dialog-n"
			center
			:destroy-on-close="true"
			:close-on-click-modal="false"
		>
			<el-form ref="app" :model="app" label-position="left" size="small" :rules="rules">
				<el-form-item label="AppId" prop="appId">
					<el-input v-model="app.appId" />
				</el-form-item>
				<el-form-item label="Secret" prop="secret">
					<el-input v-model="app.secret" />
				</el-form-item>
				<el-form-item label="名稱" prop="name">
					<el-input v-model="app.name" />
				</el-form-item>
				<el-form-item label="一級應用">
					<el-select v-model="app.parentId" clearable placeholder="請選擇" style="width: 100%">
						<el-option v-for="item in masterApps" :key="item.id" :label="item.name" :value="item.id"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="説明">
					<el-input v-model="app.details" />
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="saveClick">{{button}}</el-button>
					<el-button @click="resetClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
		<el-dialog
			:title="dialog_title_param"
			:visible.sync="show_dialog_param"
			custom-class="dialog-w"
			center
			top="16px"
			@close="clearParam"
			:destroy-on-close="true"
			:close-on-click-modal="false"
		>
			<el-form ref="appParam" :model="appParam" label-position="left" size="small" :rules="rules">				
				<el-form-item v-for="(item, index) in appParam.params" :key="index">
					<label>名稱：</label>
					<el-input v-model="item.name" style="width: 150px;" />
					<label>標題：</label>
					<el-input v-model="item.title" style="width: 150px;" />
					<label>説明：</label>
					<el-input v-model="item.details" style="width: 300px;" />
					<el-button
						type="danger"
						circle
						class="el-icon-minus"
						size="mini"
						@click="minusParameterItemClick(index)"
					/>
				</el-form-item>
				<el-form-item style="text-align: center">
					<el-button type="primary" circle class="el-icon-plus" @click="addParameterItemClick" />
				</el-form-item>
				<el-form-item style="text-align: center">
					<el-button type="primary" @click="saveParamClick">保存</el-button>					
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { queryApps, queryMasterApps, saveApp, disableApp, deleteApp, getAppParameters, setAppParameters } from '../../api/iot.js'
	export default {
		data() {
			return {
				dialog_title: '',
				show_dialog: false,
				button: '',
				app: {
					id: '',
					appId: '',
					secret: '',
					name: '',
					details: '',
					parentId: ''
				},
				dialog_title_param: '',
				show_dialog_param: false,
				appParam: {
					id: '',
					params: []
				},
				apps: [],
				masterApps: [],
				rules: {
					appId: [{ required: true, message: '請輸入AppId', trigger: 'blur' }],
					secret: [{ required: true, message: '請輸入密鑰', trigger: 'blur' }],
					name: [{ required: true, message: '請輸入名稱', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			this.queryApps()
			this.queryMasterApps()
		},
		methods: {
			queryApps() {
				queryApps().then(res => {
					if (res.status === 200) {
						this.apps = res.data.data
					}
				})
			},
			queryMasterApps() {
				queryMasterApps().then(res => {
					if (res.status === 200) {
						this.masterApps = res.data.data
					}
				})
			},		
			clearApp() {
				this.app.id = ''
				this.app.appId = ''
				this.app.secret = ''
				this.app.name = ''
				this.app.details = ''
			},
			newClick: function (e) {
				this.clearApp()
				this.button = '新增'
				this.dialog_title = `${this.button}應用`
				this.show_dialog = true
				this.modify = false
			},
			saveClick: function (e) {
				this.$refs['app'].validate(valid => {
					if (valid) {
						saveApp(this.modify, this.app).then(res => {
							if (res.status === 200) {
								this.$message({
									message: `${this.button}成功`,
									type: 'success',
									showClose: true
								})
								this.show_dialog = false
								if (!this.modify) {
									this.queryMasterApps()
								}
								this.queryApps()
							} else {
								this.$message({
									message: `${this.button}失敗`,
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			resetClick: function (e) {
				this.$refs['app'].resetFields()
			},
			minusParameterItemClick: function (val) {				
				this.appParam.params.splice(val, 1)
			},
			addParameterItemClick: function (e) {
				this.appParam.params.push({
					id: '', name: '', title: '', details: ''
				})
			},
			handleDisableChange: function (val) {
				var msg = val.status === 0 ? '啟用' : '禁用'
				disableApp(val.id, val.status).then(res => {
					if (res.status === 200) {
						this.$message({
							message: `${msg}成功`,
							type: `success`,
							showClose: true
						})
					} else {
						val.status = val.status === 0 ? 1 : 0
						this.$message({
							message: `${msg}失败`,
							type: `error`,
							showClose: true
						})
					}
				})
			},
			clearParam() {
				this.appParam.id = ''
				this.appParam.prarms = []
			},
			paramClick: function(val) {
				getAppParameters(val.id).then(res => {
					if (res.status === 200) {
						this.appParam.appid = val.id
						this.appParam.params = res.data.data
						this.dialog_title_param = `${val.name}參數`
						this.show_dialog_param = true
					}
				})
			},
			saveParamClick: function(e) {
				setAppParameters(this.appParam.appid, this.appParam.params).then(res => {
					if (res.status === 200) {
						this.$message({
							message: `設置成功`,
							type: 'success',
							showClose: true
						})
						this.show_dialog_param = false
					} else {
						this.$message({
							message: `設置失敗`,
							type: `error`,
							showClose: false
						})
					}
				})
			},
			editClick: function(val) {
				this.button = '修改'
				this.dialog_title = `${this.button}應用`
				this.app = Object.assign({}, val)
				this.modify = true
				this.show_dialog = true
			},
			deleteClick: function(val) {
				this.$confirm(`此操作將徹底刪除：<br /><strong>${val.name} / ${val.details}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteApp(val.id).then(res => {
						if (res.status === 200) {
							this.$message({
								message: '刪除成功',
								type: 'success',
								showClose: true
							})
							this.queryApps()
							this.queryMasterApps()
						} else {
							this.$message({
								message: '刪除失敗',
								type: 'error',
								showClose: true
							})
						}
					})
				})
			}
		}
	}
</script>
