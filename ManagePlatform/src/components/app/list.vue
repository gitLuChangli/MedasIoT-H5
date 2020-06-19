<template>
	<div>
		<div class="toolbar">
			<p class="title">應用列表</p>
		</div>
		<div class="toolbar">
			<el-button
				size="mini"
				icon="el-icon-plus"
				type="primary"
				style="float: right"
				circle
				@click="newClick"
			/>
		</div>
		<el-dialog
			v-bind:title="dialog_title"
			:visible.sync="show_dialog"
			customer-class="dialog-w"
			center
			top="0px"
			:destroy-on-close="true"
			:close-on-click-modal="false"
		>
			<el-form ref="app" :model="app" label-position="left" size="small" :rules="rules">
				<el-form-item label="AppId" prop="appId">
					<el-input v-model="app.appId" />
				</el-form-item>
				<el-form-item label="Secret" prop="secret">
					<el-input v-model="app.secret" />
				</el-form-item>
				<el-form-item label="名稱" prop="name">
					<el-input v-model="app.name" />
				</el-form-item>
				<el-form-item label="一級應用">
					<el-select v-model="app.parentId" placeholder="請選擇" style="width: 100%">
						<el-option v-for="item in apps" :key="item.id" :label="item.name" :value="item.id"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="説明">
					<el-input v-model="app.details" />
				</el-form-item>
				<el-form-item label="參數"></el-form-item>
				<el-form-item v-for="(item, index) in app.properties" :key="index">
					<label>名稱：</label>
					<el-input v-model="item.name" style="width: 150px;" />
					<label>標題：</label>
					<el-input v-model="item.title" style="width: 150px;" />
					<label>説明：</label>
					<el-input v-model="item.details" style="width: 300px;" />
					<el-button type="primary" circle class="el-icon-minus" @click="minusParameterItemClick(index)" />
				</el-form-item>
				<el-form-item>
					<el-button type="primary" circle class="el-icon-plus" @click="addParameterItemClick" />
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
import { saveApp } from '../../api/iot.js'
export default {
    data() {
        return {
			dialog_title: '',
			show_dialog: false,
			button: '',
			app: {
				id: '',
				appId: '',
				secret: '',
				name: '',
				details: '',
				properties: []
			},
			apps: [],
			rules: {
				appId: [{ required: true, message: '請輸入AppId', trigger: 'blur' }],
				secret: [{ required: true, message: '請輸入密鑰', trigger: 'blur' }],
				name: [{required: true, message: '請輸入名稱', trigger: 'blur'}]
			}
        }
    },
    mounted() {
        
    },
    methods: {
        newClick: function(e) {
			this.app.properties = []
			this.button = '新增'
			this.dialog_title = `${this.button}應用`
			this.show_dialog = true
		},
		saveClick: function(e) {
			this.$refs['app'].validate(valid => {
				if (valid) {
					saveApp(this.modify, this.app).then(res => {
						if (res.status === 200) {
							this.$message({
								message: `${this.button}成功`,
								type: 'success',
								showClose: true
							})
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
		resetClick: function(e) {

		},
		minusParameterItemClick: function(val) {
			console.log(val)
			this.app.properties.splice(val, 1)
		},
		addParameterItemClick: function(e) {
			this.app.properties.push({
				id: '', name: '', title: '', details: ''
			})
		}
    }
}
</script>
