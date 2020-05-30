<template>
	<div>
		<div class="toolbar">
			<p class="title">用户列表</p>
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
				style="width: 200px"
				@change="buninessGroupChange"
			>
				<el-option v-for="item in businessGroups" :key="item.id" :label="item.name" :value="item.id" />
			</el-select>
			<i class="el-icon-arrow-right" style="color: #c0c0c0" />
			<el-select
				v-model="businessOfficeId"
				placeholder="请选择事业处"
				style="width: 200px"
				size="mini"
				@change="businessOfficeChange"
			>
				<el-option v-for="item in businessOffices" :key="item.id" :label="item.name" :value="item.id" />
			</el-select>
			<i class="el-icon-arrow-right" style="color: #c0c0c0" />
			<el-select
				v-model="companyId"
				placeholder="请选择部门"
				style="width: 250px"
				size="mini"
				@change="companyChange"
			>
				<el-option v-for="item in companies" :key="item.id" :label="item.name" :value="item.id" />
			</el-select>
		</div>
		<div class="content">
			<el-table :data="users" border stripe size="mini">
				<el-table-column prop="no" label="工号" width="100" />
				<el-table-column prop="name" label="姓名" align="center" width="130" />
				<el-table-column prop="mail" label="邮箱" align="center" />
				<el-table-column prop="phone" label="电话" align="center" width="120" />
				<el-table-column prop="ext" label="分机" align="center" width="100" />
				<el-table-column prop="openId" label="微信ID" align="center" width="200" />
				<el-table-column label="修改" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button
							size="mini"
							type="primary"
							icon="el-icon-edit"
							circle
							@click="editClick(scope.row)"
						/>
					</template>
				</el-table-column>
				<el-table-column label="重置" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button
							size="mini"
							type="warning"
							icon="el-icon-lock"
							circle
							@click="resetClick(scope.row)"
						/>
					</template>
				</el-table-column>
				<el-table-column label="停用" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button
							size="mini"
							type="danger"
							icon="el-icon-minus"
							circle
							@click="stopClick(scope.row)"
						/>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				style="margin-top: 16px"
				@size-change="getUsers"
				@current-change="getUsers"
				:current-page.sync="current_page"
				:page-sizes="[10, 20, 30, 50]"
				:page-size="page_size"
				layout="total, prev, pager, next"
				:hide-on-single-page="false"
				:total="total"
			/>
			<el-dialog
				title="修改用户信息"
				:visible.sync="show_edit"
				width="610px"
				center
				:close-on-click-modal="true"
				:destroy-on-close="true"
				top="16px"
			>
				<el-form ref="user" :model="user" label-position="left" size="small" :rules="rules">
					<el-form-item label="请输入工号">
						<el-input v-model="user.no" :readonly="true" />
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
							:options="subGroups"
							style="width: 100%"
							size="small"
							:props="cascader_props"
						></el-cascader>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="saveClick">修改</el-button>
						<el-button @click="show_edit = false">取消</el-button>
					</el-form-item>
				</el-form>
			</el-dialog>
		</div>
	</div>
</template>
<script>

	import { getCompany, getUsers, saveUser, getUserCascadeIds, resetPwd, disableUser } from '../../api/iot.js'

	export default {
		data() {
			return {
				subGroups: [],
				businessGroups: [],
				businessOffices: [],
				companies: [],
				subGroupId: '',
				businessGroupId: '',
				businessOfficeId: '',
				companyId: '',
				current_page: 1,
				page_size: 10,
				total: 0,
				users: [],

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
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendant'
				},
				show_edit: false,

				rules: {
					name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
					mail: [{ required: true, message: '请输入邮箱', trigger: 'blur' }]
				}
			}
		},
		mounted() {
			getCompany().then(res => {
				if (res.data.code == 1) {
					this.subGroups = res.data.companies
				}
			})
			this.getUsers('')
		},
		methods: {
			subGroupChange: function (val) {
				for (var i = 0; i < this.subGroups.length; i++) {
					if (this.subGroups[i].id == val) {
						this.businessGroups = this.subGroups[i].descendant
						this.businessOffices = []
						this.companies = []
						this.businessGroupId = ''
						this.businessGroupId = ''
						this.companyId = ''
						this.getUsers()
						break
					}
				}
			},
			buninessGroupChange: function (val) {
				for (var i = 0; i < this.businessGroups.length; i++) {
					if (this.businessGroups[i].id == val) {
						this.businessOffices = this.businessGroups[i].descendant
						this.companies = []
						this.businessOfficeId = ''
						this.companyId = ''
						this.getUsers()
						break
					}
				}
			},
			businessOfficeChange: function (val) {
				for (var i = 0; i < this.businessOffices.length; i++) {
					if (this.businessOffices[i].id == val) {
						this.companies = this.businessOffices[i].descendant
						this.companyId = ''
						this.getUsers()
						break
					}
				}
			},
			companyChange: function (val) {
				this.getUsers()
			},
			getUsers() {
				var val = ''
				if (this.companyId != '') {
					val = this.companyId
				}
				else if (this.businessOfficeId != '') {
					val = this.businessOfficeId
				}
				else if (this.businessGroupId != '') {
					val = this.businessGroupId
				}
				else if (this.subGroupId != '') {
					val = this.subGroupId
				}
				this.users = []
				getUsers(val, 0, this.current_page, this.page_size).then(res => {
					if (res.data.code == 1) {
						this.users = res.data.users
						this.total = res.data.total
					}
				})
			},
			editClick: function (val) {
				this.user = val
				this.getCascadeIds()
			},
			getCascadeIds() {
				getUserCascadeIds(this.user.no).then(res => {
					if (res.data.code == 1) {
						this.user.cascadeIds = res.data.cascadeIds
						this.show_edit = true
					}
				})
			},
			resetClick: function (val) {
				this.$confirm(`此操作将重置 ' ${val.no} ${val.name} ' 的密码，是否继续？`, '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					resetPwd(val.no).then(res => {
						if (res.data.code == 1) {
							this.$message({
								type: 'success',
								message: '重置成功',
								showClose: true
							})
						} else {
							this.$message({
								type: 'error',
								message: '重置失败',
								showClose: true
							})
						}
					})
				})
			},
			stopClick: function (val) {
				this.$confirm(`此操作将停用 ' ${val.no} ${val.name} ' ，停用后将无法使用此系统，是否继续？`, '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					disableUser(val.no, 1).then(res => {
						if (res.data.code == 1) {
							this.$message({
								message: '停用成功',
								type: 'success',
								showClose: true
							})
							this.getUsers()
						} else {
							this.$message({
								message: '停用失败',
								type: 'error',
								showClose: true
							})
						}
					})
				})
			},
			saveClick: function (e) {
				saveUser(false, this.user).then(res => {
					if (res.data.code == 1) {
						this.$message({
							type: 'success',
							message: '修改成功',
							showClose: true
						})
						this.show_edit = false
						this.getUsers()
					} else {
						this.$message({
							type: 'error',
							message: '修改失败',
							showClose: true
						})
					}
				})
			}
		}
	}
</script>