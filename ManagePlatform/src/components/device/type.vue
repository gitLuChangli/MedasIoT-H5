<template>
	<div>
		<div class="toolbar">
			<p class="title">设备类型</p>
		</div>
		<div class="toolbar">
			<el-button size="mini" icon="el-icon-plus" @click="show_device = true">新增类型</el-button>
			<el-button size="mini" icon="el-icon-plus" @click="show_version = true">新增版本</el-button>
			<el-button type="danger" size="mini" @click="deleteClick" v-if="multipleSelection.length > 0">删除</el-button>
		</div>

		<div class="content">
			<el-table :data="devices" border stripe size="mini" @selection-change="selectionChange">
				<el-table-column type="selection" width="55" />
				<el-table-column prop="no" label="设备编号" width="200" />
				<el-table-column prop="name" label="设备名称" align="center" />
				<el-table-column prop="description" label="说明" align="center" />
				<el-table-column type="expand" label="版本" width="130">
					<template slot-scope="scope">
						<el-table :data="scope.row.versions" border size="mini">
							<el-table-column label="版本号" prop="version" align="center" />
							<el-table-column label="硬件版本号" prop="hardVersion" align="center" />
							<el-table-column label="图片" align="center">
								<template slot-scope="scope">
									<img
										:src="RES_URL + scope.row.imageUrl"
										style="width: 128px;"
										v-if="scope.row.imageUrl != ''"
									/>
								</template>
							</el-table-column>
							<el-table-column label="说明" prop="description" align="center" />
							<el-table-column label="创建日期" prop="createOn" align="center" />
						</el-table>
					</template>
				</el-table-column>
			</el-table>
		</div>

		<el-dialog
			title="新增设备类型"
			:visible.sync="show_device"
			width="610px"
			center
			:close-on-click-modal="false"
			:destroy-on-close="true"
			:before-close="deviceBeforeClose"
			top="64px"
		>
			<el-form ref="device" :model="device" label-position="left" size="small" :rules="rules">
				<el-form-item label="请输入设备编号" prop="no">
					<el-input v-model="device.no" />
				</el-form-item>
				<el-form-item label="请输入名称" prop="name">
					<el-input v-model="device.name" />
				</el-form-item>
				<el-form-item label="说明">
					<el-input v-model="device.description" />
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="newDeviceClick">创建</el-button>
					<el-button @click="resetClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>

		<el-dialog
			title="创建版本"
			:visible.sync="show_version"
			width="610px"
			center
			:before-close="beforeClose"
			:close-on-click-modal="false"
			top="64px"
		>
			<el-form ref="version" :model="version" label-position="left" size="small" :rules="rules">
				<el-form-item label="请选择设备类型" prop="no">
					<el-select v-model="version.no" placeholder="请选择设备类型" style="width: 100%">
						<el-option
							v-for="item in devices"
							:key="item.no"
							:label="item.no + item.name"
							:value="item.no"
						/>
					</el-select>
				</el-form-item>
				<el-form-item label="请输入版本号" prop="version">
					<el-input v-model="version.version" />
				</el-form-item>
				<el-form-item label="请输入硬件版本号" prop="hardVersion">
					<el-input v-model="version.hardVersion" />
				</el-form-item>
				<el-form-item label="说明">
					<el-input
						v-model="version.description"
						maxlength="512"
						type="textarea"
						rows="3"
						show-word-limit
					/>
				</el-form-item>
				<el-form-item label="设备外观">
					<el-input v-model="version.imageUrl" :hidden="true" />
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
					<el-button type="primary" @click="newVersionClick">创建</el-button>
					<el-button @click="resetClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { getDeviceType, saveDeviceType, newDeviceVersion, deleteDevice } from '../../api/iot.js'
	export default {
		data() {
			return {
				devices: [],
				show_device: false,
				show_version: false,
				device: {
					no: '',
					name: '',
					description: ''
				},
				rules: {
					no: [{ required: true, message: "请输入设备编号", trigger: 'blur' }],
					name: [{ required: true, message: '请输入设备名称', trigger: 'blur' }],
					version: [{ required: true, message: '请输入版本号', trigger: 'blur' }],
					hardVersion: [{ required: true, message: '请输入硬件版本号', trigger: 'blur' }]
				},
				version: {
					no: '',
					version: '',
					hardVersion: '',
					imageUrl: '',
					description: ''
				},
				multipleSelection: []
			}
		},
		mounted() {
			this.getDevices()
		},
		methods: {
			getDevices() {
				getDeviceType().then(res => {
					if (res.data.code == 1) {
						this.devices = res.data.devices
					}
				})
			},
			resetClick: function (e) {
				this.$refs['device'].resetFields()
				this.$refs['version'].resetFields()
			},
			newDeviceClick: function (e) {
				this.$refs['device'].validate((valid) => {
					if (valid) {
						saveDeviceType(true, this.device).then(res => {
							if (res.data.code == 1) {
								this.$message({
									message: '新建成功',
									type: 'success',
									showClose: true
								})
								this.getDevices()
								this.clearDevice()
								this.show_device = false
							} else {
								this.$message({
									message: '新建失败',
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			clearDevice() {
				this.device.no = ''
				this.device.name = ''
				this.device.description = ''
			},
			deviceBeforeClose: function(done) {
				this.clearDevice()
				done()
			},
			newVersionClick: function (e) {
				this.$refs['version'].validate((valid) => {
					if (valid) {
						newDeviceVersion(this.version).then(res => {
							if (res.data.code == 1) {
								this.$message({
									message: '新建版本成功',
									type: 'success',
									showClose: true
								})
								this.clearVersion()
								this.getDevices()
								this.show_version = false
							} else {
								this.$message({
									message: '新建版本失败',
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			clearVersion() {
				this.version.no = ''
				this.version.version = ''
				this.version.hardVersion = ''
				this.version.description = ''
				this.version.imageUrl = ''
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
					deleteDevice(ids).then(res=> {
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
				if (res.code == 1) {
					this.version.imageUrl = res.filePath
				}
			},
			uploadError: function (res, file) {				
				this.$message.error('文件上传失败')
			},
			beforeUpload: function (file) {
				const isLt1M = file.size / 1024 / 1024 < 1
				if (!isLt1M) {
					this.$message.error('上传图片大小不能超过1MB');
				}
				return isLt1M;
			},
			beforeClose: function (done) {
				this.clearVersion()
				done()
			},
			selectionChange: function (val) {				
				this.multipleSelection = val
			}
		}
	}
</script>