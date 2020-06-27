<template>
	<div>
		<div class="toolbar">
			<p class="title">資源管理</p>
		</div>
		<div class="toolbar">
			<el-radio-group v-model="action" size="mini" @change="actionChange">
				<el-radio-button label="menu">菜單</el-radio-button>
				<el-radio-button label="button">按鈕</el-radio-button>
			</el-radio-group>
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
				:data="resources"
				style="width: 100%; margin-bottom: 20px;"
				row-key="id"
				border
				stripe
				size="mini"
				default-expand-all
				:tree-props="{ children: 'descendants' }"
			>
				<el-table-column prop="name" label="ID" width="250" sortable />
				<el-table-column prop="title" label="標題" />
				<el-table-column prop="details" label="說明" />
				<el-table-column label="圖標" width="100px" align="center">
					<template slot-scope="scope">
						<i :class="scope.row.icon" />
					</template>
				</el-table-column>
				<el-table-column prop="url" label="訪問地址" />
				<el-table-column prop="index" label="順序" width="100" align="center" v-if="action === 'menu'" />
				<el-table-column prop="method" label="訪問方式" align="center" v-if="action === 'button'" />
				<el-table-column label="操作" align="center" fixed="right">
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
			<el-form ref="resource" :model="resource" label-position="left" size="small" :rules="rules">
				<el-form-item label="ID" prop="name">
					<el-input v-model="resource.name" />
				</el-form-item>
				<el-form-item label="標題" prop="title">
					<el-input v-model="resource.title" />
				</el-form-item>
				<el-form-item label="說明">
					<el-input v-model="resource.details" />
				</el-form-item>
				<el-form-item label="訪問地址">
					<el-input v-model="resource.url" />
				</el-form-item>
				<el-form-item label="訪問方式" v-show="action === 'button'">
					<el-select v-model="resource.method" placeholder="請選擇" style="width: 100%">
						<el-option v-for="item in methods" :key="item" :label="item" :value="item"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="圖標">
					<el-input v-model="resource.icon" />
				</el-form-item>
				<el-form-item label="序號" v-show="action === 'menu'">
					<el-input v-model="resource.index" />
				</el-form-item>
				<el-form-item label="資源分組">
					<el-cascader
						v-model="resource.ancestorIds"
						:options="resources"
						style="width: 100%"
						:props="cascader_props"
						:key="isResouceShow"
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
	import { queryResources, disableResource, saveResource, deleteResource } from '../../api/iot.js'
	export default {
		data() {
			return {
				action: 'menu',
				show_dialog: false,
				dialog_title: '',
				resource: {
					id: '',
					name: '',
					title: '',
					details: '',
					icon: '',
					url: '',
					index: '',
					method: '',
					status: '',
					ancestorIds: []
				},
				rules: {
					name: [{ required: true, message: '請輸入ID', trigger: 'blur' }],
					title: [{ required: true, message: '請輸入標題', trigger: 'blur' }]
				},
				resources: [],
				cascader_props: {
					label: 'title',
					value: 'id',
					children: 'descendants',
					checkStrictly: true
				},
				methods: ['GET', 'POST', 'PUT', 'DELETE'],
				modify: false,
				button: '新增',
				isResouceShow: 0
			}
		},
		mounted() {
			this.queryResources()
		},
		methods: {
			queryResources() {
				queryResources(this.action, true).then(res => {
					if (res.status === 200) {						
						this.resources = res.data.data
					}
				})
			},
			actionChange: function (e) {
				this.queryResources()
			},
			handleDisableChange: function (val) {
				var msg = val.status === 0 ? '啟用' : '禁用'
				disableResource(this.action, val.id, val.status).then(res => {
					if (res.status === 200) {
						this.showSuccess(`${msg}成功`)
						this.queryResources()
					} else {
						val.status = val.status === 0 ? 1 : 0
						this.showError(`${msg}成功`)
					}
				})
			},
			showNewClick: function (e) {
				this.clearCache()
				this.button = '新增'
				this.dialog_title = this.button + (this.action === 'menu' ? '菜單' : '按鈕')
				this.show_dialog = true
				this.modify = false
			},
			editClick: function (val) {
				this.clearCache()
				this.resource = Object.assign({}, val)
				this.button = '修改'
				this.dialog_title = this.button + (this.action === 'menu' ? '菜單' : '按鈕')
				this.show_dialog = true
				this.modify = true
			},
			resetClick: function (e) {
				this.$refs['resource'].resetFields()
				this.clearCache()
			},
			clearCache() {
				this.resource.id = ''
				this.resource.name = ''
				this.resource.title = ''
				this.resource.details = ''
				this.resource.url = ''
				this.resource.icon = ''
				this.resource.index = ''
				this.resource.method = ''
				this.resource.ancestor = []
				++this.isResouceShow
			},
			saveClick: function (e) {
				this.$refs[`resource`].validate(valid => {
					if (valid) {
						saveResource(this.modify, this.action, this.resource).then(res => {
							if (res.status === 200) {
								this.showSuccess(`${this.button}成功`)
								this.resetClick(e)
								this.queryResources()
								this.show_dialog = false
							} else {
								this.showError(`${this.button}失敗`)
							}
						})
					}
				})
			},
			deleteClick: function (val) {
				this.$confirm(`此操作將徹底刪除：<br /><strong>${val.name} / ${val.details}</strong><br />是否繼續？`, '提示', {
					confirmButtonText: '刪除',
					cancelButtonText: '取消',
					type: 'warning',
					dangerouslyUseHTMLString: true
				}).then(() => {
					deleteResource(this.action, val.id).then(res => {
						if (res.status === 200) {
							this.showSuccess(`刪除成功`)
							this.queryResources()
						} else {
							this.showError(`刪除失敗`)
						}
					})
				})
			}
		}
	}
</script>
