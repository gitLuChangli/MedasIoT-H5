<template>
	<div>
		<div class="toolbar">
			<p class="title">新增部门</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<el-radio-group v-model="action" size="small" @change="companyTypeChange">
				<el-radio-button label="new">课别</el-radio-button>
				<el-radio-button label="new_bo">事业处</el-radio-button>
				<el-radio-button label="new_bg">事业群</el-radio-button>
				<el-radio-button label="new_sg">次集团</el-radio-button>
			</el-radio-group>
		</div>
		<el-form
			ref="company"
			:model="company"
			size="small"
			label-position="left"
			style="width: 500px; margin: 16px auto; background: #ffffff; padding: 16px;"
			:rules="rules"
		>
			<el-form-item label="请选择次集团" v-if="type > 0">
				<el-select
					v-model="company.subGroupId"
					placeholder="请选择次集团"
					style="width: 500px"
					@change="subGroupChange"
				>
					<el-option v-for="item in subGroups" :key="item.id" :label="item.name" :value="item.id" />
				</el-select>
			</el-form-item>
			<el-form-item label="请选择事业群" v-if="type > 1">
				<el-select
					v-model="company.businessGroupId"
					placeholder="请选择事业群"
					style="width: 500px"
					@change="buninessGroupChange"
				>
					<el-option v-for="item in businessGroups" :key="item.id" :label="item.name" :value="item.id" />
				</el-select>
			</el-form-item>
			<el-form-item label="请选择事业处" v-if="type > 2">
				<el-select v-model="company.businessOfficeId" placeholder="请选择事业处" style="width: 500px">
					<el-option v-for="item in businessOffices" :key="item.id" :label="item.name" :value="item.id" />
				</el-select>
			</el-form-item>
			<el-form-item label="请输入费用代码" prop="code">
				<el-input v-model="company.code"></el-input>
			</el-form-item>
			<el-form-item label="请输入部门名称" prop="name">
				<el-input v-model="company.name"></el-input>
			</el-form-item>
			<el-form-item label="部门说明">
				<el-input v-model="company.description"></el-input>
			</el-form-item>
			<el-form-item label="厂区" v-if="type > 2">
				<el-input v-model="company.area"></el-input>
			</el-form-item>
			<el-form-item>
				<el-button type="primary" @click="newCompanyClick">创建</el-button>
				<el-button @click="resetClick">重置</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
	import { getCompany, saveCompany } from '../../api/iot.js'

	export default {
		data() {
			return {
				action: 'new',
				company: {
					subGroupId: '',
					businessGroupId: '',
					businessOfficeId: '',
					code: '',
					name: '',
					description: '',
					area: ''
				},
				subGroups: [],
				businessGroups: [],
				businessOffices: [],
				type: 3,

				rules: {
					code: [{ required: true, message: '请输入费用代码', trigger: 'blur' }],
					name: [{ required: true, message: '请输入部门名称', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			getCompany().then(response => {
				if (response.data.code == 1) {
					this.subGroups = response.data.companies
				}
			})
		},
		methods: {
			companyTypeChange: function (val) {
				if (val == 'new') this.type = 3
				else if (val == 'new_bo') this.type = 2
				else if (val == 'new_bg') this.type = 1
				else this.type = 0
			},
			subGroupChange: function (val) {
				for (var i = 0; i < this.subGroups.length; i++) {
					if (this.subGroups[i].id == val) {
						this.businessGroups = this.subGroups[i].descendant
						this.company.businessGroupId = ''
						this.company.businessOfficeId = ''
						break
					}
				}
			},
			buninessGroupChange: function (val) {
				for (var i = 0; i < this.businessGroups.length; i++) {
					if (this.businessGroups[i].id == val) {
						this.businessOffices = this.businessGroups[i].descendant
						break
					}
				}
			},
			newCompanyClick: function (e) {
				this.$refs[`company`].validate((valid) => {
					if (valid) {
						saveCompany(this.action, this.company).then(res => {
							if (res.data.code == 1) {
								this.$message({
									message: '新增成功',
									type: 'success',
									showClose: true
								})
								this.resetClick(e)
							} else {
								this.$message({
									message: '新增失败',
									type: 'error',
									showClose: true
								})
							}
						}).catch(error => {
							console.log(error)
						})
					}
				})
			},
			resetClick: function (e) {
				this.$refs['company'].resetFields()
				this.company.subGroupId = ''
				this.company.businessGroupId = ''
				this.company.businessOfficeId = ''
				this.company.code = ''
				this.company.name = ''
			}
		}
	}
</script>