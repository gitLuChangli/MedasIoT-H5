<template>
	<div>
		<div class="toolbar">
			<p class="title">部门列表</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<el-select v-model="subgroupId" placeholder="请选择次集团" size="mini" @change="subgroupChange">
				<el-option v-for="item in subgroups" :key="item.id" :label="item.name" :value="item.id" />
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
				<el-table-column prop="details" label="说明" align="center" />
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
			:close-on-click-modal="false"
			@open="editOpen"
			top="60px"
		>
			<el-form ref="company" :model="company" size="small" label-position="top" :rules="rules">
				<el-form-item label="请选择次集团" v-if="type > 0">
					<el-select
						v-model="subgroupId2"
						placeholder="请选择次集团"
						style="width: 500px"
						@change="subgroups2Change"
					>
						<el-option v-for="item in subgroups" :key="item.id" :label="item.name" :value="item.id" />
					</el-select>
				</el-form-item>
				<el-form-item label="请选择事业群" v-show="type > 1">
					<el-select
						v-model="businessGroupId2"
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
				<el-form-item label="请选择事业处" v-show="type > 2">
					<el-select v-model="businessOfficeId2" placeholder="请选择事业处" style="width: 500px">
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
					<el-input v-model="company.details"></el-input>
				</el-form-item>
				<el-form-item label="厂区" v-show="type > 2">
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
	import { getCompanies, editCompany, disableCompany } from '../../api/iot.js'
	export default {
		data() {
			return {
				subgroups: [],
				businessGroups: [],
				businessOffices: [],
				subgroupId: '',
				businessGroupId: '',
				businessOfficeId: '',				
				show_area: false,
				company: {
					id: '',
					code: '',
					name: '',
					details: '',
					area: ''
				},
				companies: [],
				businessGroups2: [],
				businessOffices2: [],
				subgroupId2: '',
				businessGroupId2: '',
				businessOfficeId2: '',
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
				this.subgroupId = ''
				this.businessGroupId = ''
				this.businessOfficeId = ''
				getCompanies().then(res => {					
					if (res.status == 200) {
						this.companies = res.data.data
						this.subgroups = res.data.data
						this.total = this.companies.length
						this.show_area = false
					}
				})
			},
			subgroupChange: function (val) {
				for (var i = 0; i < this.subgroups.length; i++) {
					if (this.subgroups[i].id == val) {
						this.businessGroups = this.subgroups[i].descendants
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
						this.businessOffices = this.businessGroups[i].descendants
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
						this.companies = this.businessOffices[i].descendants
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
				this.company.details = val.details
				this.company.area = val.area
				this.subgroupId2 = this.subgroupId
				this.businessGroupId2 = this.businessGroupId
				this.businessOfficeId2 = this.businessOfficeId
				this.show_edit = true
			},
			editOpen: function (e) {
				if (this.company.businessOfficeId != '' && this.businessOffices2 != null && this.businessOffices2.length > 0) {
					this.type = 3
				} else if (this.company.businessGroupId != '' && this.businessGroups2 != null && this.businessGroups2.length > 0) {
					this.type = 2
				} else if (this.company.subgroupId != '' && this.subgroups != null && this.subgroups.length > 0) {
					this.type = 1
				} else {
					this.type = 0
				}
			},
			subgroups2Change: function (val) {
				for (var i = 0; i < this.subgroups.length; i++) {
					if (this.company.subgroupId == this.subgroups[i].id) {
						this.businessGroups2 = this.subgroups[i].descendants
						this.businessOffices2 = []
						this.businessGroupId2 = ''
						this.businessOfficeId2 = ''
					}
				}
			},
			businessGroups2Change: function (val) {
				for (var i = 0; i < this.businessGroups2.length; i++) {
					if (this.company.businessGroupId == this.businessGroups2[i].id) {
						this.businessOffices2 = this.businessGroups2[i].descendants
						this.businessOfficeId2 = ''
					}
				}
			},
			saveClick: function (e) {
				if (this.type === 0) {
					this.company.ancestor = ''
				} else if (this.type === 1) {
					this.company.ancestor = `${this.subgroupId}`
				} else if (this.type === 2) {
					this.company.ancestor = `${this.subgroupId},${this.businessGroupId}`
				} else {
					this.company.ancestor = `${this.subgroupId},${this.businessGroupId},${this.businessOfficeId}`
				}
				editCompany(this.company).then(res => {					
					if (res.status == 200) {
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
				var msg = val.status == '0' ? '启用' : '禁用'
				disableCompany(val.id, val.status).then(res => {					
					if (res.status == 200) {
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