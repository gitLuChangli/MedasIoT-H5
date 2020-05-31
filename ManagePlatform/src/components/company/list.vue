<template>
	<div>
		<div class="toolbar">
			<p class="title">部门列表</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<el-select v-model="subGroupId" placeholder="请选择次集团" size="mini" @change="subGroupChange">
				<el-option v-for="item in subGroups" :key="item.id" :label="item.name" :value="item.id" />
			</el-select>
			<i class="el-icon-arrow-right" style="color: #c0c0c0" />
			<el-select
				v-model="businessGroupId"
				placeholder="请选择事业群"
				size="mini"
				style="width: 300px"
				@change="buninessGroupChange"
			>
				<el-option v-for="item in businessGroups" :key="item.id" :label="item.name" :value="item.id" />
			</el-select>
			<i class="el-icon-arrow-right" style="color: #c0c0c0" />
			<el-select
				v-model="businessOfficeId"
				placeholder="请选择事业处"
				style="width: 300px"
				size="mini"
				@change="businessOfficeChange"
			>
				<el-option v-for="item in businessOffices" :key="item.id" :label="item.name" :value="item.id" />
			</el-select>
		</div>

		<div class="content">
			<el-table :data="companies" border stripe size="mini">
				<el-table-column prop="code" label="费用代码" width="160" />
				<el-table-column prop="name" label="部门名称" align="center" />
				<el-table-column prop="description" label="说明" align="center" />
				<el-table-column prop="area" label="园区" width="160" align="center" v-if="show_area" />
				<el-table-column label="修改" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button
							size="mini"
							type="primary"
							icon="el-icon-edit"
							circle
							@click="editCompany(scope.row)"
						/>
					</template>
				</el-table-column>

				<el-table-column label="状态" width="60px" align="center" fixed="right">
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
			title="修改部门信息"
			:visible.sync="show_edit"
			width="550px"
			center
			:close-on-click-modal="true"
			@open="editOpen"
			top="60px"
		>
			<el-form ref="company" :model="company" size="small" label-position="top" :rules="rules">
				<el-form-item label="请选择次集团" v-if="type > 0">
					<el-select
						v-model="company.subGroupId"
						placeholder="请选择次集团"
						style="width: 500px"
						@change="subGroups2Change"
					>
						<el-option v-for="item in subGroups" :key="item.id" :label="item.name" :value="item.id" />
					</el-select>
				</el-form-item>
				<el-form-item label="请选择事业群" v-if="type > 1">
					<el-select
						v-model="company.businessGroupId"
						placeholder="请选择事业群"
						style="width: 500px"
						@change="businessGroups2Change"
					>
						<el-option
							v-for="item in businessGroups2"
							:key="item.id"
							:label="item.name"
							:value="item.id"
						/>
					</el-select>
				</el-form-item>
				<el-form-item label="请选择事业处" v-if="type > 2">
					<el-select v-model="company.businessOfficeId" placeholder="请选择事业处" style="width: 500px">
						<el-option
							v-for="item in businessOffices2"
							:key="item.id"
							:label="item.name"
							:value="item.id"
						/>
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
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button type="primary" @click="saveClick" size="small">修改</el-button>
				<el-button @click="show_edit=false" size="small">取消</el-button>
			</span>
		</el-dialog>
	</div>
</template>
<script>
	import { getCompany, saveCompany, disableCompany } from '../../api/iot.js'
	export default {
		data() {
			return {
				subGroups: [],
				businessGroups: [],
				businessOffices: [],
				subGroupId: '',
				businessGroupId: '',
				businessOfficeId: '',
				companies: [],
				show_area: false,
				company: {
					id: '',
					subGroupId: '',
					businessGroupId: '',
					businessOfficeId: '',
					code: '',
					name: '',
					description: '',
					area: ''
				},
				businessGroups2: [],
				businessOffices2: [],
				show_edit: false,

				type: 0,
				action: '',
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
				this.subGroupId = ''
				this.businessGroupId = ''
				this.businessOfficeId = ''
				getCompany().then(res => {
					console.log(res)
					if (res.data.code == 1) {
						this.companies = res.data.companies
						this.subGroups = res.data.companies
						this.total = this.companies.length
						this.show_area = false
					}
				})
			},
			subGroupChange: function (val) {
				for (var i = 0; i < this.subGroups.length; i++) {
					if (this.subGroups[i].id == val) {
						this.businessGroups = this.subGroups[i].descendant
						this.companies = this.businessGroups
						this.businessOffices = []
						this.businessGroupId = ''
						this.businessOfficeId = ''
						this.show_area = false
						break
					}
				}
			},
			buninessGroupChange: function (val) {
				for (var i = 0; i < this.businessGroups.length; i++) {
					if (this.businessGroups[i].id == val) {
						this.businessOffices = this.businessGroups[i].descendant
						this.companies = this.businessOffices
						this.businessOfficeId = ''
						this.show_area = false				
						break
					}
				}
			},
			businessOfficeChange: function (val) {
				for (var i = 0; i < this.businessOffices.length; i++) {
					if (this.businessOffices[i].id == val) {
						this.companies = this.businessOffices[i].descendant
						this.show_area = true						
					}
				}
			},
			viewMore: function (e) {
				var start = this.page_size * (this.current_page - 1)
				var len = this.page_size
				if (start + this.page_size > this.total) len = this.total - start
				this.companies = []
				for (var i = start; i < len; i++) {
					this.companies.push(this)
				}
			},
			editCompany(val) {
				this.businessGroups2 = this.businessGroups
				this.businessOffices2 = this.businessOffices
				this.company.id = val.id
				this.company.code = val.code
				this.company.name = val.name
				this.company.description = val.description
				this.company.area = val.area
				this.company.subGroupId = this.subGroupId
				this.company.businessGroupId = this.businessGroupId
				this.company.businessOfficeId = this.businessOfficeId
				this.show_edit = true
				console.log(this.company)
			},
			editOpen: function (e) {
				if (this.company.businessOfficeId != '' && this.businessOffices2 != null && this.businessOffices2.length > 0) {
					this.type = 3
					this.action = 'edit'
				} else if (this.company.businessGroupId != '' && this.businessGroups2 != null && this.businessGroups2.length > 0) {
					this.type = 2
					this.action = 'edit_bo'
				} else if (this.company.subGroupId != '' && this.subGroups != null && this.subGroups.length > 0) {
					this.type = 1
					this.action = 'edit_bg'
				} else {
					this.type = 0
					this.action = 'edit_sg'
				}
				console.log(this.action)
			},
			subGroups2Change: function (val) {
				console.log(val)
				for (var i = 0; i < this.subGroups.length; i++) {
					if (this.company.subGroupId == this.subGroups[i].id) {
						this.businessGroups2 = this.subGroups[i].descendant
						this.businessOffices2 = []
						this.company.businessGroupId = ''
						this.company.businessOfficeId = ''
					}
				}
			},
			businessGroups2Change: function (val) {
				for (var i = 0; i < this.businessGroups2.length; i++) {
					if (this.company.businessGroupId == this.businessGroups2[i].id) {
						this.businessOffices2 = this.businessGroups2[i].descendant
						this.company.businessOfficeId = ''
					}
				}
			},
			saveClick: function (e) {
				saveCompany(this.action, this.company).then(res => {
					console.log(res)
					if (res.data.code == 1) {
						this.$message({
							message: '修改成功',
							type: 'success',
							showClose: true
						})
						this.show_edit = false
						this.getCompanies()
					} else {
						this.$message({
							message: '修改失败',
							type: 'error',
							showClose: true
						})
					}
				})
			},
			handleDisableChange: function (val) {
				console.log(val)
				var msg = val.status == '0' ? '启用' : '禁用'
				disableCompany(val.id, val.status).then(res => {
					console.log(res)
					if (res.data.code == 1) {
						this.$message({
							message: `${msg}成功`,
							type: 'success',
							showClose: true
						})
					} else {
						val.status = val.status == '0' ? '1' : '0'
						this.$message({
							message: `${msg}失败`,
							type: 'error',
							showClose: false
						})
					}
				})
			}
		}
	}
</script>