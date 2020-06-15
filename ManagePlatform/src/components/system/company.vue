<template>
	<div>
		<div class="toolbar">
			<p class="title">部門管理</p>
		</div>
		<div class="toolbar">
			<el-button
				type="primary el-icon-plus"
				circle
				style="float: right"
				size="mini"
				@click="showNewClick"
			/>
		</div>
		<div class="content">
			<el-table
				:data="companies"
				border
				stripe
				size="mini"
				row-key="id"
				:tree-props="{ children: 'descendants' }"
			>
				<el-table-column prop="code" label="费用代碼" width="250" />
				<el-table-column prop="name" label="部門名稱" align="center" />
				<el-table-column prop="details" label="説明" align="center" />
				<el-table-column prop="area" label="園區" width="160" align="center" />
				<el-table-column label="操作" align="center" width="150px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="editClick(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="deleteClick(scope.row)">刪除</el-button>
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
		<el-dialog
			v-bind:title="dialog_title"
			:visible.sync="show_dialog"
			center
			custom-class="dialog-n"
			:destroy-on-close="true"
			:close-on-click-modal="false"
		>
			<el-form ref="company" :model="company" size="small" label-position="left" :rules="rules">
				<el-form-item label="費用代碼" prop="code">
					<el-input v-model="company.code" />
				</el-form-item>
				<el-form-item label="部門名稱" prop="name">
					<el-input v-model="company.name" />
				</el-form-item>
				<el-form-item label="説明">
					<el-input v-model="company.details" />
				</el-form-item>
				<el-form-item label="廠區">
					<el-input v-model="company.area" />
				</el-form-item>
				<el-form-item label="所屬部門">
					<el-cascader
						:options="companies"
						:props="cascader_props"
						clearable
						v-model="company.ancestorIds"
						size="small"
						style="width: 100%"
					/>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="saveClick">{{button}}</el-button>
					<el-button @click="resetClick">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
	import { queryCompanies, saveCompany, disableCompany, deleteCompany } from '../../api/iot.js'
	export default {
		data() {
			return {
				companies: [],
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendants',
					checkStrictly: true
				},
				dialog_title: '',
				show_dialog: false,
				button: '',
				modify: false,
				company: {
					id: '',
					code: '',
					name: '',
					details: '',
					region: '',
					province: '',
					city: '',
					county: '',
					address: '',
					area: '',
					status: '',
					ancestorIds: []
				},
				rules: {
					code: [{ required: true, message: '請輸入費用代碼', trigger: 'blur' }],
					name: [{ required: true, message: '請輸入部門名稱', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			this.queryCompanies()
		},
		methods: {
			queryCompanies() {
				queryCompanies().then(res => {
					if (res.status === 200) {
						this.companies = res.data.data
						this.companies2 = res.data.data
					}
				})
			},
			clearCache() {
				this.company.id = ''
				this.company.code = ''
				this.company.name = ''
				this.company.details = ''
				this.company.region = ''
				this.company.province = ''
				this.company.city = ''
				this.company.county = ''
				this.company.address = ''
				this.company.area = ''
				this.company.status = ''
				this.company.ancestorIds = []
			},
			showNewClick: function (e) {
				this.button = '新增'
				this.clearCache()
				this.dialog_title = `${this.button}部門`
				this.show_dialog = true
				this.modify = false
			},
			editClick: function (val) {
				this.company = Object.assign({}, val)
				this.button = '修改'
				this.dialog_title = `${this.button}部門`
				this.show_dialog = true
				this.modify = true
				console.log(this.company)
			},
			deleteClick: function (val) {
				this.$confirm(`此操作將徹底刪除：<br /><strong>${val.name}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteCompany(val.id).then(res => {
						if (res.status === 200) {
							this.$message({
								message: `刪除成功`,
								type: 'success',
								showClose: true
							})
							this.queryCompanies()
						} else {
							this.$message({
								message: `刪除失敗`,
								type: 'error',
								showClose: true
							})
						}
					})
				})
			},
			saveClick: function (e) {
				this.$refs['company'].validate(valid => {
					if (valid) {
						console.log(this.company)
						saveCompany(this.modify, this.company).then(res => {
							if (res.status === 200) {
								this.$message({
									message: `${this.button}成功`,
									type: 'success',
									showClose: true
								})
								this.show_dialog = false
								this.queryCompanies()
							} else {
								this.$message({
									message: `${this.button}失敗`,
									type: 'error',
									showClose: true
								})
							}
						})
					}
				})
			},
			resetClick: function (e) {
				this.clearCache()
				this.$refs['company'].resetFields()
			},
			handleDisableChange: function (val) {
				var _msg = val.status === 1 ? '禁用' : '啟用'
				disableCompany(val.id, val.status).then(res => {
					if (res.status === 200) {
						this.$message({
							message: `${_msg}成功`,
							type: 'success',
							showClose: true
						})
					} else {
						this.$message({
							message: `${_msg}失敗`,
							type: 'error',
							showClose: false
						})
						val.status = val.status === 1 ? 0 : 1
					}
				})
			}
		}
	}
</script>
