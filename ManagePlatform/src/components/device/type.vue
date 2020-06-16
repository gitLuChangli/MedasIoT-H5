<template>
	<div>
		<div class="toolbar">
			<p class="title">設備類型</p>
		</div>
		<div class="toolbar">
			<el-button size="mini" icon="el-icon-plus" type="primary" @click="showNewTypeClick">類型</el-button>
			<el-button size="mini" icon="el-icon-plus" type="primary" @click="showVersionClick">版本</el-button>
			<el-button type="danger" size="mini" @click="deleteClick" v-if="multipleSelection.length > 0">删除</el-button>
		</div>

		<div class="content">
			<el-table :data="deviceTypes" border stripe size="mini" @selection-change="selectionChange">
				<el-table-column type="selection" width="55" />
				<el-table-column prop="model" label="設備型號" width="200" />
				<el-table-column prop="name" label="設備名稱" align="center" />
				<el-table-column prop="details" label="設備描述" align="center" />
				<el-table-column type="expand" label="版本" width="130">
					<template slot-scope="scope">
						<el-table :data="scope.row.deviceVersions" border size="mini">
							<el-table-column label="版本號" prop="version" align="center" />
							<el-table-column label="固件版本號" prop="hardVersion" align="center" />
							<el-table-column label="圖片" align="center">
								<template slot-scope="scope">
									<img
										:src="RES_URL + scope.row.imageUrl"
										style="width: 128px;"
										v-if="scope.row.imageUrl != ''"
									/>
								</template>
							</el-table-column>
							<el-table-column label="説明" prop="description" align="center" />
							<el-table-column label="創建日期" prop="createOn" align="center" />
						</el-table>
					</template>
				</el-table-column>
				<el-table-column label="操作" align="center" width="150px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="editTypeClick(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="deleteTypeClick(scope.row)">刪除</el-button>
					</template>
				</el-table-column>
			</el-table>
		</div>

		<el-dialog
			:title="typeTitlte"
			:visible.sync="show_type"
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
					<el-button type="primary" @click="saveTypeClick">{{buttonType}}</el-button>
					<el-button @click="resetTypeClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>

		<el-dialog
			:title="versionTitle"
			:visible.sync="show_version"
			custom-class="dialog-n"
			center			
			:close-on-click-modal="false"
			:destroy-on-close="true"
			top="64px"
		>
			<el-form
				ref="deviceVersion"
				:model="deviceVersion"
				label-position="left"
				size="small"
				:rules="rules"
			>
				<el-form-item label="設備類型">
					<el-select v-model="deviceVersion.deviceType" placeholder="請選擇設備類型" style="width: 100%">
						<el-option
							v-for="item in deviceTypes"
							:key="item.id"
							:label="item.model + item.name"
							:value="item.id"
						/>
					</el-select>
				</el-form-item>
				<el-form-item label="版本號" prop="version">
					<el-input v-model="deviceVersion.version" />
				</el-form-item>
				<el-form-item label="硬件本版號" prop="hardVersion">
					<el-input v-model="deviceVersion.hardVersion" />
				</el-form-item>
				<el-form-item label="説明">
					<el-input
						v-model="deviceVersion.details"
						maxlength="512"
						type="textarea"
						rows="3"
						show-word-limit
					/>
				</el-form-item>
				<el-form-item label="設備外觀">
					<el-input v-model="deviceVersion.imageUrl" :hidden="true" />
				</el-form-item>

				<el-upload
					ref="upload"
					:action="this.RES_URL + '/upload'"
					list-type="picture-card"
					:multiple="false"
					:limit="1"
					accept=".jpg, .jpeg, .png"
					style="margin-bottom: 16px;"
					:on-success="uploadSuccess"
					:on-error="uploadError"
					:before-upload="beforeUpload"
					:with-credentials="true"
				>
					<i class="el-icon-plus"></i>
				</el-upload>
				<el-form-item>
					<el-button type="primary" @click="saveVersionClick">{{buttonVersion}}</el-button>
					<el-button @click="resetVersionClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { queryDeviceTypes, saveDeviceType, deleteDeviceType, saveDeviceVersion, deleteDeviceVersion } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceTypes: [],
				typeTitlte: '',
				show_type: false,
				buttonType: '',
				versionTitle: '',
				show_version: false,
				buttonVersion: '',
				deviceType: {
					id: '',
					model: '',
					name: '',
					details: ''
				},
				deviceVersion: {
					id: '',
					deviceType: '',
					version: '',
					hardVersion: '',
					imageUrl: '',
					details: ''
				},
				typeModify: false,
				versionModify: false,
				rules: {
					model: [{ required: true, message: '請輸入設備型號', trigger: 'blur' }],
					name: [{ required: true, message: '請輸入設備名稱', trigger: 'blur' }],
					version: [{ required: true, message: '請輸入版本號', trigger: 'blur' }],
					hardVersion: [{ required: true, message: '請輸入硬件版本號', trigger: 'blur' }]
				},

				multipleSelection: []
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
			saveTypeClick: function (e) {
				this.$refs['deviceType'].validate(valid => {
					if (valid) {
						saveDeviceType(this.typeModify, this.deviceType).then(res => {
							if (res.status === 200) {
								this.$message({
									message: `${this.buttonType}成功`,
									type: 'success',
									showClose: true
								})
								this.show_type = false
								this.queryDeviceTypes()
							} else {
								this.$message({
									message: `${this.buttonType}失敗`,
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
			showNewTypeClick: function (e) {
				this.clearType()
				this.buttonType = '新增'
				this.typeTitlte = `${this.buttonType}設備類型`
				this.show_type = true
				this.typeModify = false
			},
			resetTypeClick: function (e) {
				this.$refs['deviceType'].resetFields()
				this.clearType()
			},
			editTypeClick: function (val) {
				this.clearType()
				this.deviceType = Object.assign({}, val)
				this.buttonType = '修改'
				this.typeTitlte = `${this.buttonType}設備類型`
				this.show_type = true
				this.typeModify = true
			},
			deleteTypeClick: function (val) {
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
			},
			clearVersion() {
				this.deviceVersion.id = ''
				this.deviceVersion.deviceType = ''
				this.deviceVersion.version = ''
				this.deviceVersion.hardVersion = ''
				this.deviceVersion.imageUrl = ''
				this.deviceVersion.details = ''
			},
			showVersionClick: function (e) {
				this.clearVersion()
				this.buttonVersion = '新增'
				this.versionTitle = `${this.buttonVersion}版本`
				this.show_version = true
				this.versionModify = false
			},
			saveVersionClick: function (e) {
				this.$refs['deviceVersion'].validate(valid => {
					if (valid) {
						saveDeviceVersion(this.versionModify, this.deviceVersion).then(res => {
							if (res.status === 200) {
								this.$message({
									message: `${this.buttonVersion}成功`,
									type: 'success',
									showClose: true
								})
								this.show_version = false
								this.queryDeviceTypes()
							} else {
								this.$message({
									message: `${this.buttonVersion}失敗`,
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			resetVersionClick: function (e) {
				this.$refs['deviceVersion'].resetFields()
				this.clearVersion()
			},			
			deleteClick: function (e) {
				this.$confirm('此操作将删除设备类别及版本，删除后无法恢复，是否继续？', '提示', {
					confirmButtonText: '删除',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					var ids = []
					for (var i = 0; i < this.multipleSelection.length; i++) {
						ids.push(this.multipleSelection[i].id)
					}
					deleteDevice(ids).then(res => {
						if (res.data.code == 1) {
							this.$message({
								message: '删除成功',
								type: 'success',
								showClose: true
							})
							this.getDevices()
						} else {
							this.$message({
								message: '删除失败',
								type: 'error',
								showClose: true
							})
						}
					})
				})
			},
			uploadSuccess: function (res, file) {				
				if (res.code === 1) {
					this.deviceVersion.imageUrl = res.filePath
				}
			},
			uploadError: function (res, file) {
				this.$message.error('文件上傳失敗')
			},
			beforeUpload: function (file) {
				const isLt1M = file.size / 1024 / 1024 < 1
				if (!isLt1M) {
					this.$message.error('上傳圖片大小不能超過1MB');
				}
				return isLt1M;
			},			
			selectionChange: function (val) {
				this.multipleSelection = val
			}
		}
	}
</script>