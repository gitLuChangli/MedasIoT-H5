<template>
	<div>
		<div class="toolbar">
			<p class="title">設備列表</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<label>設備類型：</label>
			<el-select
				v-model="deviceType"
				size="small"
				placeholder="請選擇設備類型"
				@change="typeChange(deviceType)"
				style="width: 300px"
			>
				<el-option
					v-for="item in deviceTypes"
					:key="item.id"
					:label="item.model + item.name"
					:value="item.id"
				/>
			</el-select>
		</div>
		<div class="content">
			<el-table :data="devices" border stripe size="mini">
				<el-table-column prop="sn" label="設備編號" width="200" />
				<el-table-column prop="model" label="設備型號" width="150" />
				<el-table-column prop="name" label="設備名稱" />
				<el-table-column prop="details" label="設備詳情" />
				<el-table-column prop="companyName" label="部門" align="center" />
				<el-table-column prop="applicationName" label="應用" align="center" />
				<el-table-column prop="version" label="產品版本" width="100" align="center" />
				<el-table-column prop="firm_ver" label="固件版本" width="100" align="center" />
				<el-table-column prop="soft_ver" label="軟件版本" width="100" align="center" />
				<el-table-column label="操作" align="center" width="150px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="setAppClick(scope.row)">應用</el-button>
						<el-button size="mini" type="text" @click="setCompanyClick(scope.row)">部門</el-button>
						<el-button size="mini" type="text" @click="setParameterClick(scope.row)">參數</el-button>
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
				@size-change="queryByType"
				@current-change="queryByType"
				:current-page.sync="current_page"
				:page-sizes="[10, 20, 30, 50]"
				:page-size="page_size"
				layout="total, prev, pager, next"
				:hide-on-single-page="false"
				:total="total"
			/>
		</div>
		<el-dialog
			:title="dialog_title_company"
			:visible.sync="show_dialog_company"
			custom-class="dialog-n"
			center
			:close-on-click-modal="false"
			:destroy-on-close="true"
		>
			<el-form ref="deviceCompany" :model="deviceCompany" size="small" label-position="left">
				<el-form-item>
					<el-cascader
						:options="companies"
						:props="cascader_props"
						clearable
						v-model="deviceCompany.companyIds"
						size="small"
						:show-all-levels="true"
						style="width: 100%"
					/>
				</el-form-item>
				<el-form-item style="text-align: center">
					<el-button type="primary" @click="saveCompanyClick">設置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>

		<el-dialog
			:title="dialog_title_app"
			:visible.sync="show_dialog_app"
			custom-class="dialog-n"
			center
			:close-on-click-modal="false"
			:destroy-on-close="true"
		>
			<el-form ref="deviceApp" :model="deviceApp" size="small" label-position="left" :rules="rules">
				<el-form-item>
					<el-select
						v-model="deviceApp.applicationId"
						size="small"
						placeholder="請選擇應用"
						style="width: 100%"
						prop="applicationId"
					>
						<el-option v-for="item in apps" :key="item.id" :label="item.name" :value="item.id" />
					</el-select>
				</el-form-item>
				<el-form-item style="text-align: center">
					<el-button type="primary" @click="saveAppClick">設置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>

		<el-dialog
			title="設備參數"
			:visible.sync="show_dialog_param"
			custom-class="dialog-n"
			center
			:destroy-on-close="true"
			:close-on-click-modal="false"
			top="16px"
		>
			<el-form ref="devParams" :model="devParams" label-position="left" size="small">
				<el-form-item
					v-for="(item, index) in devParams.params"
					:key="index"
					:label="item.title + '：' +  item.details"
				>
					<el-input v-model="item.value" @change="change" />
				</el-form-item>
				<el-form-item style="text-align: center">
					<el-button type="primary" @click="saveParamClick">保存</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { queryDeviceTypes, adminQueryDeviceByType, queryCompanies, adminSetDeviceCompany, queryApps, deviceSetApplication, getAppParameters, deviceSetParameter, queryAncestorIds } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceType: '',
				deviceVersion: {},
				deviceTypes: [],
				devices: [],
				page_size: 10,
				current_page: 1,
				total: 0,
				dialog_title_company: '',
				show_dialog_company: false,
				deviceCompany: {
					deviceId: '',
					companyIds: ''
				},
				companies: [],
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendants',
					checkStrictly: true
				},
				dialog_title_app: '',
				show_dialog_app: false,
				deviceApp: {
					deviceId: '',
					applicationId: ''
				},
				apps: [],
				rules: {
					applicationId: [{ required: true, message: '請選擇設備應用', trigger: 'change' }]
				},
				show_dialog_param: false,
				devParams: {
					params: []
				}
			}
		},
		mounted() {
			this.queryDeviceTypes()
			queryCompanies().then(res => {
				if (res.status === 200) {
					this.companies = res.data.data
				}
			})
			queryApps().then(res => {
				if (res.status === 200) {
					this.apps = res.data.data
				}
			})
		},
		methods: {
			queryDeviceTypes() {
				this.deviceType = ''
				queryDeviceTypes().then(res => {
					if (res.status === 200) {
						this.deviceTypes = res.data.data
					}
				})
			},
			queryByType() {
				adminQueryDeviceByType(this.deviceType, this.current_page - 1, this.page_size).then(res => {
					if (res.status === 200) {
						this.devices = res.data.data.content
						this.total = res.data.data.totalElements
					} else {
						this.showError(`查詢失敗`)
					}
				})
			},
			typeChange: function (val) {
				this.queryByType()
			},
			handleDisableChange: function (val) {

			},
			setAppClick: function (val) {
				this.deviceApp.deviceId = val.id
				this.deviceApp.applicationId = val.applicationId
				this.dialog_title_app = `設置應用：${val.sn}`
				this.show_dialog_app = true
			},
			setCompanyClick: function (val) {
				if (val.companyId === '' || val.companyId === null) {
					this.deviceCompany.deviceId = val.id
					this.deviceCompany.companyIds = []
					this.dialog_title_company = `設置部門：${val.sn}`
					this.show_dialog_company = true
				} else {
					queryAncestorIds(val.companyId).then(res => {
						if (res.status === 200) {
							this.deviceCompany.deviceId = val.id
							this.deviceCompany.companyIds = res.data.data
							this.dialog_title_company = `設置部門：${val.sn}`
							this.show_dialog_company = true
						} else {
							this.showError(`獲取部門層級關係失敗`)
						}
					})
				}
			},
			setParameterClick: function (val) {
				if (val.applicationId === '' || val.applicationId === null) {
					this.showError(`該設備還未設置應用`)
					return
				}
				getAppParameters(val.applicationId).then(res => {
					if (res.status === 200) {
						var obj = res.data.data
						if (val.parameter !== '' && val.parameter !== null) {
							var j = JSON.parse(val.parameter)
							var n
							for (var i = 0; i < obj.length; i++) {
								n = obj[i].name
								console.log(n)
								console.log(j[n])
								if (j[n] !== undefined) {
									obj[i].value = j[n]
								}
							}
							console.log(obj)
						}
						this.devParams.params = obj
						this.devParams.id = val.id
						this.show_dialog_param = true
					}
				})
			},
			saveCompanyClick: function (e) {
				adminSetDeviceCompany(this.deviceCompany).then(res => {
					if (res.status === 200) {
						this.showSuccess(`設置成功`)
						this.show_dialog_company = false
						this.queryByType()
					}
				})
			},
			saveAppClick: function (e) {
				this.$refs['deviceApp'].validate(valid => {
					if (valid) {
						deviceSetApplication(this.deviceApp.deviceId, this.deviceApp.applicationId).then(res => {
							if (res.status === 200) {
								this.showSuccess(`設置成功`)
								this.show_dialog_app = false
								this.queryByType()
							} else {
								this.showError(`設置失敗`)
							}
						})
					}
				})
			},
			saveParamClick: function (e) {
				var obj = {}
				for (var i = 0; i < this.devParams.params.length; i++) {
					obj[this.devParams.params[i].name] = this.devParams.params[i].value
				}
				deviceSetParameter(this.devParams.id, obj).then(res => {
					if (res.status === 200) {
						this.showSuccess(`設置成功`)
						this.queryByType()
						this.show_dialog_param = false
					} else {
						this.showError(`設置失敗`)
					}
				})
			},
			change: function(e) {
				this.$forceUpdate()
			}
		}
	}
</script>
