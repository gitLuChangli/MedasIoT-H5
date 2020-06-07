<template>
	<div>
		<div class="toolbar">
			<p class="title">新增資源</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<el-radio-group v-model="action" size="mini" @change="getResources">
				<el-radio-button label="menu">菜單</el-radio-button>
				<el-radio-button label="button">按鈕</el-radio-button>
			</el-radio-group>
		</div>
		<el-form
			class="form"
			ref="resource"
			:model="resource"
			label-position="left"
			size="small"
			:rules="rules"
		>
			<el-form-item label="名稱" prop="name">
				<el-input v-model="resource.name" />
			</el-form-item>
			<el-form-item label="說明" prop="details">
				<el-input v-model="resource.details" />
			</el-form-item>
			<el-form-item label="地址" prop="url">
				<el-input v-model="resource.url" />
			</el-form-item>
			<el-form-item label="圖標">
				<el-input v-model="resource.icon" />
			</el-form-item>
			<el-form-item label="資源分組">
				<el-cascader
					v-model="resource.ancestor"
					:options="resources"
					style="width: 100%"
					:props="cascader_props"
                    clearable
				></el-cascader>
			</el-form-item>
			<el-form-item>
				<el-button type="primary" @click="newClick">新增</el-button>
				<el-button @click="resetClick">重置</el-button>
			</el-form-item>
		</el-form>
	</div>
</template>
<script>
    import { queryResources, newResource } from '../../api/iot.js'
export default {
    data() {
        return {
            action: 'menu',
            resource: {
                name: '',
                details: '',
                icon: '',
                url: '',
                ancestor: []
            },
            rules: {
                name: [{required: true, message: '請輸入名稱', trigger: 'blur'}],
                details: [{required: true, message: '請輸入說明', trigger: 'blur'}],
                url: [{required: true, message: '請輸入請求地址', trigger: 'blur'}]
            },
            resources: [],
            cascader_props: {
                label: 'name',
                value: 'id',
                children: 'descendants',
                checkStrictly: true
            }
        }
    },
    mounted() {
        this.getResources()
    },
    methods: {
        newClick: function(e) {
            this.$refs[`resource`].validate(valid => {
                if (valid) {
                    newResource(this.action, this.resource).then(res => {
                        if (res.status === 200) {
                            this.$message({
                                message: '新增成功',
                                type: 'success',
                                showClose: true
                            })
                            this.resetClick(e)
                        } else {
                            this.$message({
                                message: '新增失敗',
                                type: 'error',
                                showClose: true
                            })
                        }
                    })   
                }
            })
        },
        resetClick: function(e) {
            this.$refs['resource'].resetFields()
            this.resource.name = ''
            this.resource.details = ''
            this.resource.url = ''
            this.resource.icon = ''
            this.resource.ancestor = []
        },
        getResources() {
            queryResources(this.action, true).then(res => {
                if (res.status === 200) {
                    this.resources = res.data.data
                }
            })
        }
    }
}
</script>
