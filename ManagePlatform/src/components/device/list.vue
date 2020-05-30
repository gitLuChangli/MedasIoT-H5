<template>
	<div>
		<div class="toolbar">
			<p class="title">设备列表</p>
		</div>
		<div class="toolbar" style="text-align: center">
			请选择设备类型：
			<el-select v-model="deviceId" size="small" placeholder="请选择设备类型" @change="getDeviceItems">
				<el-option
					v-for="item in devices"
					:key="item.id"
					:label="item.no + item.name"
					:value="item.id"
				/>
			</el-select>
		</div>
		<div class="content">
			<el-table :data="items" border stripe size="mini">
				<el-table-column prop="name" label="设备名称" width="200" />
				<el-table-column prop="sn" label="设备编号" align="center" />
				<el-table-column label="设备版本" align="center">
					<template slot-scope="scope">{{scope.row.version.version}}</template>
				</el-table-column>
				<el-table-column prop="firm_ver" label="固件版本" align="center" />
				<el-table-column prop="soft_ver" label="软件版本" align="center" />
			</el-table>
		</div>
	</div>
</template>
<script>
	import { getDeviceType, getDeviceItems } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceId: '',
				devices: [],
				items: [],

				page_size: 10,
				current_page: 1,
				total: 0
			}
		},
		mounted() {
			this.getDeviceType()
		},
		methods: {
			getDeviceType() {
				getDeviceType().then(res => {
					if (res.data.code == 1) {
						this.devices = res.data.devices
					}
				})
			},
			getDeviceItems() {				
				getDeviceItems(this.deviceId, this.current_page, this.page_size).then(res => {
					if (res.data.code == 1) {
						this.items = res.data.items
					}
				})
			}
		}
	}
</script>