<template>
	<div>
		<div class="toolbar">
			<p class="title">添加设备</p>
		</div>
		<el-form
			class="form"
			ref="device"
			:model="device"
			size="small"
			label-position="left"
			:rules="rules"
			style="width: 500px; margin: 16px auto; background: #ffffff; padding: 16px;"
		>
			<el-form-item label="请选择设备类型" prop="deviceId">
				<el-select
					v-model="device.deviceId"
					placeholder="请选择设备类型"
					style="width: 100%"
					@change="deviceTypeChange"
				>
					<el-option
						v-for="item in devices"
						:key="item.id"
						:label="item.no + item.name"
						:value="item.id"
					/>
				</el-select>
			</el-form-item>
			<el-form-item label="请选择版本" prop="versionId">
				<el-select v-model="device.versionId" placeholder="请选择版本" style="width: 100%">
					<el-option v-for="item in versions" :key="item.id" :label="item.version" :value="item.id" />
				</el-select>
			</el-form-item>
			<el-form-item label="请输入设备名称" prop="name">
				<el-input v-model="device.name"></el-input>
			</el-form-item>
			<el-form-item label="请输入设备编号" prop="sn">
				<el-input v-model="device.sn"></el-input>
			</el-form-item>
			<el-form-item label="请输入网络mac地址" prop="mac">
				<el-input v-model="device.mac"></el-input>
			</el-form-item>
			<el-form-item label="请输入主板编号" prop="motherboard">
				<el-input v-model="device.motherboard"></el-input>
			</el-form-item>
			<el-form-item>
				<el-button type="primary" @click="newItemClick">创建</el-button>
				<el-button @click="resetClick">重置</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
	import { getDeviceType, newDeviceItem } from '../../api/iot.js'
	export default {
		data() {
			return {
				devices: [],
				versions: [],
				deviceId: '',

				device: {
					deviceId: '',
					versionId: '',
					name: '',
					sn: '',
					mac: '',
					motherboard: ''
				},

				rules: {
					deviceId: [{ required: true, message: '请选择设备类型', trigger: 'change' }],
					versionId: [{ required: true, message: '请选择版本号', trigger: 'change' }],
					name: [{ required: true, message: '请输入设备名称', trigger: 'blur' }],
					sn: [{ required: true, message: '请输入设备编号', trigger: 'blur' }],
					mac: [{ required: true, message: '请输入网络mac地址', trigger: 'blur' }],
					motherboard: [{ required: true, message: '请输入主板编号', trigger: 'blur' }]
				}
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
			deviceTypeChange: function (val) {
				this.deviceId = val
				for (var i = 0; i < this.devices.length; i++) {
					if (this.devices[i].id == val) {
						this.versions = this.devices[i].versions
						break
					}
				}
			},
			newItemClick: function (e) {
				this.$refs.device.validate((valid) => {
					if (valid) {
						newDeviceItem(this.device).then(res => {
							if (res.data.code == 1) {
								this.$message({
									message: '添加成功',
									type: 'success',
									showClose: true
								})
								this.devices.name = ''
								this.device.sn = ''
								this.device.mac = ''
								this.device.motherboard = ''
							} else {
								this.$message({
									message: '添加失败',
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			resetClick: function (e) {
				this.$refs.device.resetFields()
			}
		}
	}
</script>