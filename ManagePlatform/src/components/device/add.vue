<template>
	<div>
		<div class="toolbar">
			<p class="title">錄入設備</p>
		</div>
		<el-form
			class="form"
			ref="device"
			:model="device"
			size="small"
			label-position="left"
			style="width: 500px; margin: 16px auto; background: #ffffff; padding: 16px;"
		>
			<el-form-item label="設備類型">
				<el-select
					v-model="deviceTypeId"
					placeholder="請選擇設備類型"
					style="width: 100%"
					@change="typeChange"
				>
					<el-option
						v-for="item in deviceTypes"
						:key="item.id"
						:label="item.model + item.name"
						:value="item.id"
					/>
				</el-select>
			</el-form-item>
			<el-form-item label="版本" prop="version">
				<el-select
					v-model="device.versionId"
					placeholder="請選擇版本"
					style="width: 100%"
					@change="versionChange"
				>
					<el-option
						v-for="item in deviceVersions"
						:key="item.id"
						:label="item.version"
						:value="item.id"
					/>
				</el-select>
			</el-form-item>

			<div
				style="background: #f7f9fe; text-align: center; margin: 16px 0px; padding: 10px 0px;"
				v-if="show_version"
			>
				<p>
					<strong>設備信息</strong>
				</p>
				<img :src="RES_URL + version.imageUrl" style="width: 300px; margin: 10px;" />
				<p>
					<label>硬件版本：{{version.hardVersion}}</label>
					<label style="margin-left: 32px;">創建日期：{{version.createOn}}</label>
				</p>
			</div>
			<el-form-item label="設備編號">總計：<strong>{{device.sns.length}}</strong></el-form-item>
			<p>
				<el-tag
					:key="tag"
					v-for="tag in device.sns"
					closable
					:disable-transitions="false"
					@close="handleClose(tag)"
					style="margin:0 4px 4px 0px;"
				>{{tag}}</el-tag>
			</p>
			<el-form-item>
				<el-input placeholder="請輸入設備編號" v-model="sn" @keyup.enter.native="addClick">
					<el-button slot="append" icon="el-icon-plus" @click="addClick"></el-button>
				</el-input>
			</el-form-item>
			<el-form-item>
				<el-button type="primary" @click="newClick">錄入</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
	import { queryDeviceTypes, queryDeviceVersions, adminAddDevices } from '../../api/iot.js'
	export default {
		data() {
			return {
				deviceTypes: [],
				deviceVersions: [],
				deviceTypeId: '',
				device: {
					versionId: '',
					sns: []
				},
				version: {},
				show_version: false,
				sn: ''
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
			typeChange: function (val) {
				this.deviceVersions = []
				queryDeviceVersions(this.deviceTypeId).then(res => {
					if (res.status === 200) {
						this.deviceVersions = res.data.data
						this.device.versionId = ''
						this.version = {}
						this.show_version = false
					}
				})
			},
			versionChange: function(val) {
				for (var i = 0; i < this.deviceVersions.length; i++) {
					if (this.deviceVersions[i].id === val) {
						this.version = Object.assign({}, this.deviceVersions[i])
						this.show_version = true
						break
					}
				}
			},
			addClick: function(e) {
				if (this.device.sns.indexOf(this.sn) === -1) {
					this.device.sns.push(this.sn)
					this.sn = ''
				}
			},
			handleClose: function(val) {
				var idx = this.device.sns.indexOf(val)
				if (idx > -1) {
					this.device.sns.splice(idx, 1)
				}
			},
			newClick: function (e) {
				this.$refs.device.validate((valid) => {
					if (valid) {
						adminAddDevices(this.device).then(res => {
							if (res.status === 200) {
								this.$message({
									message: '錄入成功',
									type: 'success',
									showClose: true
								})
								this.device.sns = []
							} else {
								this.$message({
									message: '錄入失敗',
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			}
		}
	}
</script>
