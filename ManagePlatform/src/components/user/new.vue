<template>
	<div>
		<div class="toolbar">
			<p class="title">新增用戶</p>
		</div>
		<el-form class="form" ref="user" :model="user" label-position="left" size="small" :rules="rules">
			<el-form-item label="請輸入工號" prop="no">
				<el-input v-model="user.no" />
			</el-form-item>
			<el-form-item label="請輸入姓名" prop="name">
				<el-input v-model="user.name" />
			</el-form-item>
			<el-form-item label="請輸入郵箱" prop="email">
				<el-input v-model="user.email" />
			</el-form-item>
			<el-form-item label="請輸入手機號">
				<el-input v-model="user.phone" />
			</el-form-item>
			<el-form-item label="請輸入分機號">
				<el-input v-model="user.ext" />
			</el-form-item>
			<el-form-item label="微信openid">
				<el-input v-model="user.openId" />
			</el-form-item>
			<el-form-item label="香信openid">
				<el-input v-model="user.icivetId" />
			</el-form-item>
			<el-form-item label="請選擇部門">
				<el-cascader
					v-model="user.companyIds"
					:options="companies"					
					style="width: 100%"
					size="small"
					:props="cascader_props"
				></el-cascader>
			</el-form-item>
			<el-form-item>
				<el-button type="primary" @click="newUserClick">新增</el-button>
				<el-button @click="resetClick">重置</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
	import { getCompanies, newUser } from '../../api/iot.js'
	export default {
		data() {
			return {
				user: {
					no: '',
					name: '',
					email: '',
					openId: '',
					icivetId: '',
					ext: '',
					phone: '',
					companyIds: []
				},
				companies: [],
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendants'
				},
				rules: {
					no: [{ required: true, message: '請輸入工號', trigger: 'blur' }],
					name: [{ required: true, message: '請輸入姓名', trigger: 'blur' }],
					email: [{ required: true, message: '請輸入郵箱', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			getCompanies().then(res => {
				if (res.status == 200) {
					this.companies = res.data.data
					console.log(this.companies)
				}
			})
		},
		methods: {
			newUserClick: function (val) {
				this.$refs['user'].validate((valid) => {
					if (valid) {
						console.log(this.user)
						newUser(this.user).then(res => {
							console.log(res)
							if (res.status == 200) {
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
				this.user.no = ''
				this.user.name = ''
				this.user.email = ''
				this.user.ext = ''
				this.user.phone = ''
				this.user.openId = ''
				this.user.icivetId = ''
				this.user.companyIds = []
			}
		}
	}
</script>