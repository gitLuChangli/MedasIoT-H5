<template>
	<div>
		<div class="toolbar">
			<p class="title">新增部门</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<el-radio-group v-model="action" size="small" @change="companyTypeChange">
				<el-radio-button label="department">课别</el-radio-button>
				<el-radio-button label="business_office">事业处</el-radio-button>
				<el-radio-button label="business_group">事业群</el-radio-button>
				<el-radio-button label="subgroup">次集团</el-radio-button>
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
			<el-form-item label="请选择次集团" v-show="type > 0">
				<el-select
					v-model="subgroupId"
					placeholder="请选择次集团"
					style="width: 500px"
					@change="subgroupChange"
				>
					<el-option v-for="item in subgroups" :key="item.id" :label="item.name" :value="item.id" />
				</el-select>
			</el-form-item>
			<el-form-item label="请选择事业群" v-show="type > 1">
				<el-select
					v-model="businessGroupId"
					placeholder="请选择事业群"
					style="width: 500px"
					@change="buninessGroupChange"
				>
					<el-option v-for="item in businessGroups" :key="item.id" :label="item.name" :value="item.id" />
				</el-select>
			</el-form-item>
			<el-form-item label="请选择事业处" v-show="type > 2">
				<el-select v-model="businessOfficeId" placeholder="请选择事业处" style="width: 500px">
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
				<el-input v-model="company.details"></el-input>
			</el-form-item>
			<el-form-item label="厂区" v-show="type > 2">
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
	import { getCompanies, newCompany } from '../../api/iot.js'

	export default {
		data() {
			return {
				action: 'department',
				company: {
					ancestor: '',
					code: '',
					name: '',
					details: '',
					area: ''
				},
				subgroupId: '',
				businessGroupId: '',
				businessOfficeId: '',
				subgroups: [],
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
			this.getCompanies()
		},
		methods: {
			getCompanies() {
				getCompanies().then(response => {
					if (response.status === 200) {
						this.subgroups = response.data.data
					}
				})
			},
			companyTypeChange: function (val) {
				if (val === 'department') this.type = 3
				else if (val === 'business_office') this.type = 2
				else if (val === 'business_group') this.type = 1
				else this.type = 0
			},
			subgroupChange: function (val) {
				for (var i = 0; i < this.subgroups.length; i++) {
					if (this.subgroups[i].id === val) {
						this.businessGroups = this.subgroups[i].descendants
						this.businessGroupId = ''
						this.businessOfficeId = ''
						break
					}
				}
			},
			buninessGroupChange: function (val) {
				for (var i = 0; i < this.businessGroups.length; i++) {
					if (this.businessGroups[i].id === val) {
						this.businessOffices = this.businessGroups[i].descendants
						this.businessOfficeId = ''
						break
					}
				}
			},
			newCompanyClick: function (e) {
				this.$refs[`company`].validate((valid) => {
					if (valid) {
						if (this.type === 0) {
							this.company.ancestor = ''
						} else if (this.type === 1) {
							this.company.ancestor = `${this.subgroupId}`
						} else if (this.type === 2) {
							this.company.ancestor = `${this.subgroupId},${this.businessGroupId}`
						} else {
							this.company.ancestor = `${this.subgroupId},${this.businessGroupId},${this.businessOfficeId}`
						}
						newCompany(this.company).then(res => {
							if (res.status === 200) {
								this.$message({
									message: '新增成功',
									type: 'success',
									showClose: true
								})
								this.resetClick(e)
								this.getCompanies()
							} else {
								this.$message({
									message: '新增失敗',
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
				this.subgroupId = ''
				this.businessGroupId = ''
				this.businessOfficeId = ''
				this.company.code = ''
				this.company.name = ''
				this.company.details = ''
				this.company.area = ''
				this.company.ancestor = ''
				this.$refs['company'].resetFields()
			}
		}
	}
</script>
