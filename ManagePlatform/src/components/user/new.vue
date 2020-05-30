<template>
	<div>
		<div class="toolbar">
			<p class="title">新建用户</p>
		</div>
		<el-form class="form" ref="user" :model="user" label-position="left" size="small" :rules="rules">
			<el-form-item label="请输入工号" prop="no">
				<el-input v-model="user.no" />
			</el-form-item>
			<el-form-item label="请输入姓名" prop="name">
				<el-input v-model="user.name" />
			</el-form-item>
			<el-form-item label="请输入邮箱" prop="mail">
				<el-input v-model="user.mail" />
			</el-form-item>
			<el-form-item label="请输入手机号">
				<el-input v-model="user.phone" />
			</el-form-item>
			<el-form-item label="请输入分机号">
				<el-input v-model="user.ext" />
			</el-form-item>
			<el-form-item label="微信openid">
				<el-input v-model="user.openId" />
			</el-form-item>
			<el-form-item label="香信openid">
				<el-input v-model="user.icivetId" />
			</el-form-item>
			<el-form-item label="请选择部门">
				<el-cascader
					v-model="user.cascadeIds"
					:options="companies"
					@change="handleChange"
					style="width: 100%"
					size="small"
					:props="cascader_props"
				></el-cascader>
			</el-form-item>
			<el-form-item>
				<el-button type="primary" @click="newUserClick">创建</el-button>
				<el-button @click="resetClick">重置</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
	import { getCompany, saveUser } from '../../api/iot.js'
	export default {
		data() {
			return {
				user: {
					no: '',
					name: '',
					mail: '',
					openId: '',
					icivetId: '',
					ext: '',
					phone: '',
					cascadeIds: []
				},
				companies: [],
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendant'
				},
				rules: {
					no: [{ required: true, message: '请输入工号', trigger: 'blur' }],
					name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
					mail: [{ required: true, message: '请输入邮箱', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			getCompany().then(res => {
				if (res.data.code == 1) {
					this.companies = res.data.companies
					console.log(this.companies)
				}
			})
		},
		methods: {
			handleChange: function (val) {
				console.log(val)				
			},
			newUserClick: function (val) {
				this.$refs['user'].validate((valid) => {
					if (valid) {
						saveUser(true, this.user).then(res => {
							console.log(res)
							if (res.data.code == 1) {
								this.$message({
									message: '创建成功',
									type: 'success',
									showClose: 'true'
								})
								this.resetClick()
							} else {
								this.$message({
									message: '创建失败',
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			resetClick() {
				this.$refs['user'].resetFields()
				this.user.companyId = ''
				this.user.subGroupId = ''
				this.user.businessGroupId = ''
				this.user.businessOfficeId = ''
				this.user.ext = ''
				this.user.phone = ''
				this.user.openId = ''
				this.user.icivetId = ''
			}
		}
	}
</script>