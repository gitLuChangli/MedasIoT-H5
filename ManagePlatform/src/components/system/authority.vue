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
				<el-table-column prop="name" label="ID" width="300" sortable />
				<el-table-column prop="details" label="詳情" sortable />
				<el-table-column label="菜單">
					<template slot-scope="scope">
						<el-link
							v-for="item in scope.row.menuList"
							:key="item.id"
							:icon="item.icon"
							type="primary"
							style="margin: 4px 8px;"
						>{{item.details}}</el-link>
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
						>{{item.details}}</el-link>
					</template>
				</el-table-column>
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
			<el-form ref="authority" :model="authority" label-position="left" size="small" :rules="rules">
				<el-form-item label="ID" prop="name">
					<el-input v-model="authority.name" />
				</el-form-item>
				<el-form-item label="名稱" prop="details">
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
						collapse-tags
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
    import { queryResources, saveAuthority, queryAuthorities } from '../../api/iot.js'
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
					details: '',
					menuIds: [],
					buttonIds: [],
					status: 0
				},
				cascader_props: {
					label: 'name',
					value: 'id',
					children: 'descendants',
                    checkStrictly: true,
                    multiple: true
				},
				cascader_props2: {
					label: 'name',
					value: 'id',
					children: 'descendants',
					multiple: true
				},
				rules: {
					name: [{ required: true, message: '請輸入ID', trigger: 'blur' }],
					details: [{ required: true, message: '請輸入名稱', trigger: 'blur' }]
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

			},
			saveClick: function (e) {
                this.$refs['authority'].validate(valid => {
                    if (valid) {
                        console.log(this.authority)
                        saveAuthority(!this.modify, this.authority).then(res => {
                            if (res.status === 200) {
                                this.$message({
                                    message: `${this.button}成功`,
									type: 'success',
									showClose: true
                                })
								this.queryAuthorities()
								this.clearForm()
								this.show_dialog = false
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
			editClick: function(val) {
				this.clearForm()
				this.authority = Object.assign({}, val)
				var buttonParent = ''
				console.log(this.authority.buttonList.length)
				console.log(this.buttons.length)
				for (var i = 0; i < this.buttons.length; i++) {
					buttonParent = this.buttons[i].id
					if (this.buttons[i].descendants !== undefined) {
						for (var j = 0; j < this.buttons[i].descendants.length; j++) {
							this.authority.buttonIds.append([buttonParent, this.buttons[i].descendants[j].id])
							if (this.authority.buttonIds.length === this.authority.buttonList.length) {
								break
							}
						}
					}
					if (this.authority.buttonIds.length === this.authority.buttonList.length) {
						break
					}
				}
				this.button = '修改'
				this.dialog_title = `${this.button}權限`
				this.show_dialog = true
                this.modify = false
                this.isResouceShow = 0
			},
			deleteClick: function(val) {

			}
		}
	}
</script>
