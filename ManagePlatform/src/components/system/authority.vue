<template>
	<div>
		<div class="toolbar">
			<p class="title">權限管理</p>
		</div>
		<div class="toolbar">
			<el-button
				type="primary el-icon-plus"
				circle
				style="float: right; clear: both"
				size="mini"
				@click="showNewClick"
			/>
		</div>
		<div class="content">
			<el-table
				:data="authorities"
				style="width: 100%; margin-bottom: 20px;"
				border
				stripe
				size="mini"
			>
				<el-table-column prop="name" label="ID" width="250" sortable />
				<el-table-column prop="title" label="標題" />
				<el-table-column prop="details" label="詳情" />
				<el-table-column label="菜單">
					<template slot-scope="scope">
						<el-link
							v-for="item in scope.row.menuList"
							:key="item.id"
							:icon="item.icon"
							type="primary"
							style="margin: 4px 8px;"
						>{{item.title}}</el-link>
					</template>
				</el-table-column>
				<el-table-column label="按鈕">
					<template slot-scope="scope">
						<el-link
							v-for="item in scope.row.buttonList"
							:key="item.id"
							:icon="item.icon"
							type="primary"
							style="margin: 4px 8px;"
						>{{item.title}}</el-link>
					</template>
				</el-table-column>
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
			<el-form ref="authority" :model="authority" label-position="left" size="small" :rules="rules">
				<el-form-item label="ID" prop="name">
					<el-input v-model="authority.name" />
				</el-form-item>
				<el-form-item label="標題" prop="title">
					<el-input v-model="authority.title" />
				</el-form-item>
				<el-form-item label="詳情">
					<el-input v-model="authority.details" />
				</el-form-item>
				<el-form-item label="菜單">
					<el-cascader
						v-model="authority.menuIds"
						:options="menus"
						style="width: 100%"
						:props="cascader_props"
						clearable
					></el-cascader>
				</el-form-item>
				<el-form-item label="按鈕">
					<el-cascader
						v-model="authority.buttonIds"
						:options="buttons"
						:key="isResouceShow"
						style="width: 100%"
						:props="cascader_props2"
						clearable
					></el-cascader>
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
	import { queryResources, saveAuthority, queryAuthorities, disableAuthority, deleteAuthority } from '../../api/iot.js'
	export default {
		data() {
			return {
				authorities: [],
				menus: [],
				buttons: [],
				dialog_title: '',
				show_dialog: false,
				button: '',
				authority: {
					id: '',
					name: '',
					title: '',
					details: '',
					menuIds: [],
					buttonIds: [],
					status: 0
				},
				cascader_props: {
					label: 'title',
					value: 'id',
					children: 'descendants',
					checkStrictly: true,
					multiple: true
				},
				cascader_props2: {
					label: 'title',
					value: 'id',
					children: 'descendants',
					multiple: true
				},
				rules: {
					name: [{ required: true, message: '請輸入ID', trigger: 'blur' }],
					title: [{ required: true, message: '請輸入標題', trigger: 'blur' }]
				},
				isResouceShow: 0
			}
		},
		mounted() {
			queryResources('menu', true).then(res => {
				if (res.status === 200) {
					this.menus = res.data.data
				}
			})
			queryResources('button', true).then(res => {
				if (res.status === 200) {
					this.buttons = res.data.data
				}
			})
			this.queryAuthorities()
		},
		methods: {
			clearForm() {
				++this.isResouceShow
				this.authority.id = ''
				this.authority.name = ''
				this.authority.title = ''
				this.authority.details = ''
				this.authority.menuIds = []
				this.authority.buttonIds = []
				this.authority.status = ''
			},
			showNewClick: function (e) {
				this.clearForm()
				this.button = '新增'
				this.dialog_title = `${this.button}權限`
				this.show_dialog = true
				this.modify = false
				this.isResouceShow = 0
			},
			handleDisableChange: function (val) {
				var _msg = val.status === 1 ? '禁用' : '啟用'
				disableAuthority(val.id, val.status).then(res => {
					if (res.status === 200) {
						this.showSuccess(`${_msg}成功`)
						this.queryAuthorities()
					} else {
						this.showError(`${_msg}失敗`)
						val.status = val.status === 0 ? 1 : 0
					}
				})
			},
			saveClick: function (e) {
				this.$refs['authority'].validate(valid => {
					if (valid) {
						saveAuthority(!this.modify, this.authority).then(res => {
							if (res.status === 200) {
								this.showSuccess(`${this.button}成功`)
								this.queryAuthorities()
								this.clearForm()
								this.show_dialog = false
							} else {
								this.showError(`${this.button}失敗`)
							}
						})
					}
				})
			},
			resetClick: function (e) {
				this.$refs['authority'].resetFields()
				this.clearForm()
			},
			queryAuthorities() {
				queryAuthorities().then(res => {
					if (res.status === 200) {
						this.authorities = res.data.data
					}
				})
			},
			editClick: function (val) {
				this.clearForm()
				this.authority = Object.assign({}, val)
				this.button = '修改'
				this.dialog_title = `${this.button}權限`
				this.show_dialog = true
				this.modify = true
				this.isResouceShow = 0
			},
			deleteClick: function (val) {
				this.$confirm(`此操作將徹底刪除：<br /><strong>${val.name} / ${val.title}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteAuthority(val.id).then(res => {
						if (res.status === 200) {
							this.showSuccess(`刪除成功`)
							this.queryAuthorities()
						} else {
							this.showError(`刪除失敗`)
						}
					})
				})
			}
		}
	}
</script>
