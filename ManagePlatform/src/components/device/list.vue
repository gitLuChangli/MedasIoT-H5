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
			>
				<el-option
					v-for="item in deviceTypes"
					:key="item.id"
					:label="item.model + item.name"
					:value="item.model"
				/>
			</el-select>
			<label>設備版本：</label>
			<el-select
				v-model="deviceVersionId"
				size="small"
				placeholder="請選擇設備版本"
				@change="versionChange(deviceVersionId)"
			>
				<el-option
					v-for="item in deviceVersions"
					:key="item.id"
					:label="item.version"
					:value="item.id"
				/>
			</el-select>
		</div>
		<div class="content">
			<el-table :data="devices" border stripe size="mini">
				<el-table-column prop="model" label="設備型號" width="150" />
				<el-table-column prop="name" label="設備名稱" width="200" />
				<el-table-column prop="sn" label="設備編號" align="center" />
				<el-table-column prop="firm_ver" label="固件版本" align="center" />
				<el-table-column prop="soft_ver" label="軟件版本" align="center" />
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
		</div>
		<el-dialog
			:title="dialog_title_company"
			:visible.sync="show_dialog_company"
			custom-class="dialog-n"
			center
			:close-on-click-modal="false"
			:destroy-on-close="true"
			top="64px"
		>
			<el-form ref="deviceCompany" :model="deviceCompany" size="small" label-position="left">
				<el-form-item>
					<el-cascader
						:options="companies"
						:props="cascader_props"
						clearable
						v-model="deviceCompany.companyIds"
						size="small"
						:show-all-levels="false"
						style="width: 100%"
					/>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="saveCompanyClick">設置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { queryDeviceTypes, queryDeviceVersions, adminQueryDeviceByModel, adminQueryDeviceByVersionId, queryCompanies, adminSetDeviceCompany } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceType: '',
				deviceVersion: {},
				deviceVersionId: '',
				deviceTypes: [],
				deviceVersions: [],
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
					children: 'descendants'
				},
			}
		},
		mounted() {
			this.queryDeviceTypes()
			queryCompanies().then(res => {
				if (res.status === 200) {
					this.companies = res.data.data
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
				adminQueryDeviceByModel(this.deviceType, this.current_page - 1, this.page_size).then(res => {
					if (res.status === 200) {
						this.devices = res.data.data.content
						this.total = res.data.data.totalElements
					} else {
						this.$message({
							message: `查詢失敗`,
							type: 'error',
							showClose: true
						})
					}
				})
			},
			queryByVersion() {
				adminQueryDeviceByVersionId(this.deviceVersionId).then(res => {
					if (res.status === 200) {
						this.devices = res.data.data.content
						this.total = res.data.data.totalElements
					} else {
						this.$message({
							message: `查詢失敗`,
							type: 'error',
							showClose: true
						})
					}
				})
			},
			typeChange: function (val) {
				this.deviceVersions = []
				this.deviceVersionId = ''
				for (var i = 0; i < this.deviceTypes.length; i++) {
					if (this.deviceTypes[i].model === val) {
						queryDeviceVersions(this.deviceTypes[i].id).then(res => {
							if (res.status === 200) {
								this.deviceVersions = res.data.data
							}
						})
						break
					}
				}
				this.queryByType()
			},
			versionChange: function (val) {
				this.queryByVersion()	
			},
			handleDisableChange: function (val) {

			},
			setAppClick: function (val) {

			},
			setCompanyClick: function (val) {
				this.deviceCompany.deviceId = val.id
				this.deviceCompany.companyIds = val.companyIds
				this.dialog_title_company = `設置部門：${val.sn}`
				this.show_dialog_company = true
			},
			setParameterClick: function (val) {

			},
			saveCompanyClick: function (e) {
				adminSetDeviceCompany(this.deviceCompany).then(res => {
					if (res.status === 200) {
						this.$message({
							message: `設置成功`,
							type: 'success',
							showClose: true
						})
						this.show_dialog_company = false
						if (this.deviceType === '' && this.deviceVersionId !== '') {
							this.queryByVersion()
						} else if (this.deviceType !== '' && this.deviceVersionId === '') {
							this.queryByType()
						}						
					}
				})
			}
		}
	}
</script>
