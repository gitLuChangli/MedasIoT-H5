<template>
	<div>
		<div class="toolbar">
			<p class="title">設備版本</p>
		</div>
		<div class="toolbar">
			<el-select
				v-model="deviceTypeId"
				size="small"
				placeholder="請選擇設備類型"
				@change="queryDeviceVersions"
			>
				<el-option
					v-for="item in deviceTypes"
					:key="item.id"
					:label="item.model + item.name"
					:value="item.id"
				/>
			</el-select>
			<el-button
				size="mini"
				icon="el-icon-plus"
				type="primary"
				circle
				@click="newClick"
				style="float: right"
			/>
		</div>
		<div class="content">
			<el-table :data="deviceVersions" border size="mini">
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
				<el-table-column label="説明" prop="details" align="center" />
				<el-table-column label="創建日期" prop="createOn" align="center" />
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
			<el-form
				ref="deviceVersion"
				:model="deviceVersion"
				label-position="left"
				size="small"
				:rules="rules"
			>
				<el-form-item label="設備類型" prop="deviceTypeId">
					<el-select
						v-model="deviceVersion.deviceTypeId"
						placeholder="請選擇設備類型"
						style="width: 100%"
						:readonly="modify"
					>
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
					<el-button type="primary" @click="saveClick">{{button}}</el-button>
					<el-button @click="resetClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
    import { queryDeviceTypes, queryDeviceVersions, saveDeviceVersion, deleteDeviceVersion } from '../../api/iot.js'

    export default {
        data() {
            return {
                deviceTypes: [],
                deviceVersions: [],
                deviceTypeId: '',
                dialog_title: '',
                show_dialog: false,
                deviceVersion: {
					id: '',
					deviceTypeId: '',
					version: '',
					hardVersion: '',
					imageUrl: '',
					details: ''
                },
                modify: false,
                button: '',
                rules: {
					deviceTypeId: [{ required: true, message: '請輸入設備型號', trigger: 'change' }],
					version: [{ required: true, message: '請輸入版本號', trigger: 'blur' }],
					hardVersion: [{ required: true, message: '請輸入硬件版本號', trigger: 'blur' }]
				}
            }
        },
        mounted() {
            queryDeviceTypes().then(res => {
                if (res.status === 200) {
                    this.deviceTypes = res.data.data
                }
            })
        },
        methods: {
            queryDeviceVersions() {
                queryDeviceVersions(this.deviceTypeId).then(res => {
                    if (res.status === 200) {
                        this.deviceVersions = res.data.data
                    } else {
                        this.$message({
                            message: `獲取失敗`,
                            type: 'error',
                            showClose: true
                        })
                    }
                })
            },
            clearVersion() {
				this.deviceVersion.id = ''
				this.deviceVersion.deviceTypeId = ''
				this.deviceVersion.version = ''
				this.deviceVersion.hardVersion = ''
				this.deviceVersion.imageUrl = ''
				this.deviceVersion.details = ''
			},
            newClick: function(e) {
                this.clearVersion()
				this.button = '新增'
				this.dialog_title = `${this.button}版本`
				this.show_dialog = true
				this.modify = false
            },
            saveClick: function(e) {
                this.$refs['deviceVersion'].validate(valid => {
					if (valid) {
						saveDeviceVersion(this.modify, this.deviceVersion).then(res => {
							if (res.status === 200) {
								this.$message({
									message: `${this.button}成功`,
									type: 'success',
									showClose: true
								})
								this.show_dialog = false
								this.queryDeviceVersions()
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
            resetClick: function(e) {
                this.$refs['deviceVersion'].resetFeilds()
                this.clearVersion()
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
					this.$message.error('上傳圖片大小不能超過1MB')
				}
				return isLt1M
            },
            editClick: function(val) {
                this.clearVersion()
                this.deviceVersion = Object.assign({}, val)
                this.button = '修改'
                this.dialog_title = `${this.button}版本`
                this.modify = true
                this.show_dialog = true
            },
            deleteClick: function(val) {
                this.$confirm(`如果該版本的設備沒有錄入，此操作將徹底刪除：<br /><strong>${val.version}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteDeviceVersion(val.id).then(res => {
						if (res.status === 200) {
							this.$message({
								message: '刪除成功',
								type: 'success',
								showClose: true
							})
							this.queryDeviceVersions()
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
