<template>
	<div>
		<div class="toolbar">
			<p class="title">設備列表</p>
		</div>
		<div class="toolbar" style="text-align: center">
			設備類型：
			<el-select v-model="deviceType" size="small" placeholder="請選擇設備類型" @change="typeChange(deviceType)">
				<el-option
					v-for="item in deviceTypes"
					:key="item.id"
					:label="item.model + item.name"
					:value="item.model"
				/>
			</el-select>
			設備版本
			<el-select v-model="deviceVersionId" size="small" placeholder="請選擇設備版本" @change="versionChange(deviceVersionId)">
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
	</div>
</template>
<script>
	import { queryDeviceTypes, queryDeviceVersions, adminQueryDeviceByModel, adminQueryDeviceByVersionId } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceType: {},
				deviceVersion: {},
				deviceVersionId: '',
				deviceTypes: [],
				deviceVersions: [],
				devices: [],
				page_size: 10,
				current_page: 1,
				total: 0
			}
		},
		mounted() {
			this.queryDeviceTypes()
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
			typeChange: function(val) {
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
				adminQueryDeviceByModel(val, this.current_page - 1, this.page_size).then(res => {
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
			versionChange: function(val) {
				adminQueryDeviceByVersionId(val).then(res => {
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
			handleDisableChange: function(val) {

			},
			setAppClick: function(val) {

			},
			setCompanyClick: function(val) {

			},
			setParameterClick: function(val) {

			}
		}
	}
</script>
