<template>
	<div>
		<div class="toolbar">
			<p class="title">設備類型</p>
		</div>
		<div class="toolbar">
			<el-button size="mini" icon="el-icon-plus" type="primary"  style="float: right" circle @click="newClick" />
		</div>

		<div class="content">
			<el-table :data="deviceTypes" border stripe size="mini">
				<el-table-column prop="model" label="設備型號" width="200" />
				<el-table-column prop="name" label="設備名稱" align="center" />
				<el-table-column prop="details" label="設備描述" align="center" />
				<el-table-column label="操作" align="center" width="150px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="editClick(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="deleteClick(scope.row)">刪除</el-button>
					</template>
				</el-table-column>
			</el-table>
		</div>

		<el-dialog
			:title="dialog_title"
			:visible.sync="show_dialog"
			custom-class="dialog-n"
			center
			:close-on-click-modal="false"
			:destroy-on-close="true"
			top="64px"
		>
			<el-form ref="deviceType" :model="deviceType" label-position="left" size="small" :rules="rules">
				<el-form-item label="設備型號" prop="model">
					<el-input v-model="deviceType.model" />
				</el-form-item>
				<el-form-item label="設備名稱" prop="name">
					<el-input v-model="deviceType.name" />
				</el-form-item>
				<el-form-item label="設備描述">
					<el-input v-model="deviceType.details" />
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
	import { queryDeviceTypes, saveDeviceType, deleteDeviceType } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceTypes: [],
				dialog_title: '',
				show_dialog: false,
				button: '',
				show_version: false,
				deviceType: {
					id: '',
					model: '',
					name: '',
					details: ''
				},
				modify: false,
				rules: {
					model: [{ required: true, message: '請輸入設備型號', trigger: 'blur' }],
					name: [{ required: true, message: '請輸入設備名稱', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			this.queryDeviceTypes()
		},
		methods: {
			queryDeviceTypes() {
				queryDeviceTypes().then(res => {
					if (res.status === 200) {
						this.deviceTypes = res.data.data
					}
				})
			},
			saveClick: function (e) {
				this.$refs['deviceType'].validate(valid => {
					if (valid) {
						saveDeviceType(this.modify, this.deviceType).then(res => {
							if (res.status === 200) {
								this.$message({
									message: `${this.button}成功`,
									type: 'success',
									showClose: true
								})
								this.show_dialog = false
								this.queryDeviceTypes()
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
			clearType() {
				this.deviceType.id = ''
				this.deviceType.model = ''
				this.deviceType.name = ''
				this.deviceType.details = ''
			},
			newClick: function (e) {
				this.clearType()
				this.button = '新增'
				this.dialog_title = `${this.button}設備類型`
				this.show_dialog = true
				this.modify = false
			},
			resetClick: function (e) {
				this.$refs['deviceType'].resetFields()
				this.clearType()
			},
			editClick: function (val) {
				this.clearType()
				this.deviceType = Object.assign({}, val)
				this.button = '修改'
				this.dialog_titlte = `${this.button}設備類型`
				this.show_dialog = true
				this.modify = true
			},
			deleteClick: function (val) {
				this.$confirm(`如果該型號的設備沒有錄入，此操作將徹底刪除：<br /><strong>${val.model} ${val.name}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteDeviceType(val.id).then(res => {
						if (res.status === 200) {
							this.$message({
								message: '刪除成功',
								type: 'success',
								showClose: true
							})
							this.queryDeviceTypes()
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
