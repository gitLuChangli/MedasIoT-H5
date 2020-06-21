<template>
	<div>
		<div class="toolbar">
			<p class="title">應用版本</p>
		</div>
		<div class="toolbar" style="text-align: center">
            選擇應用：
			<el-select v-model="appid" clearable placeholder="請選擇应用" size="small" @change="queryVersions" style="width: 300px">
				<el-option v-for="item in masterApps" :key="item.id" :label="item.name" :value="item.id"></el-option>
			</el-select>

			<el-button
				size="mini"
				icon="el-icon-plus"
				type="primary"
				style="float: right"
				circle
				@click="newClick"
			/>
		</div>
		<div class="content">
			<el-table :data="versions" border stripe size="mini">
				<el-table-column prop="version" label="版本號" width="150" />
				<el-table-column label="下載地址">
                    <template slot-scope="scope">
                        {{RES_URL + scope.row.link}}
                    </template>
				</el-table-column>
				<el-table-column prop="details" label="升級説明" />
				<el-table-column prop="createOn" label="上傳時間" width="200" />
                <el-table-column label="操作" align="center" width="100px" fixed="right">
					<template slot-scope="scope">
						<el-button size="mini" type="text" @click="editClick(scope.row)">修改</el-button>
					</template>
                </el-table-column>
			</el-table>
		</div>
		<el-dialog
			v-bind:title="dialog_title"
			:visible.sync="show_dialog"
			custom-class="dialog-n"
			center
			:destroy-on-close="true"
			:close-on-click-modal="false"
            @close="clearCache"
		>
			<el-form ref="version" :model="version" label-position="left" size="small" :rules="rules">
				<el-form-item label="應用" prop="appid">
					<el-select
						v-model="version.applicationId"
						clearable
						placeholder="請選擇应用"
						size="small"
						style="width: 100%"
					>
						<el-option v-for="item in masterApps" :key="item.id" :label="item.name" :value="item.id"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="版本號" prop="version">
					<el-input v-model="version.version" />
				</el-form-item>
				<el-form-item label="升級説明">
					<el-input v-model="version.details" maxlength="512" type="textarea" rows="3" show-word-limit />
				</el-form-item>
				<el-form-item label="鏈接">
					<el-input v-model="version.link" />
				</el-form-item>
				<el-upload
					ref="upload"
					:fileList="files"
					:action="this.RES_URL + '/upload'"
					list-type="picture-card"
					:multiple="false"
					:limit="1"
					accept=".msi, .exe, .zip, .apk, .rar, .7z"
					style="margin-bottom: 16px;"
					:on-success="uploadSuccess"
					:on-error="uploadError"
					:with-credentials="true"
				>
					<i class="el-icon-plus"></i>
				</el-upload>
				<el-form-item>
					<el-button type="primary" @click="saveClick">{{button}}</el-button>
					<el-button @click="resetClick" v-if="!modify">重置</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>
<script>
import { queryMasterApps, saveAppVersion, queryAppVersions } from '../../api/iot.js'
export default {
    data() {
        return {
            masterApps: [],
            appid: '',
            versions: [],
            dialog_title: '',
            show_dialog: false,
            version: {
                id: '',
                applicationId: '',
                version: '',
                link: '',
                details: ''
            },
            button: '',
            modify: false,
            files: [],
            rules: {
                applicationId: [{ required: true, message: '請選擇應用', trigger: 'change' }],
                version: [{ required: true, message: '請輸入版本號', trigger: 'blur' }],
                link: [{ required: true, message: '請上傳應用', trigger: 'blur' }]
			}
        }
    },
    mounted() {
        queryMasterApps().then(res => {
            if (res.status === 200) {
                this.masterApps = res.data.data
            }
        })
    },
    methods: {
        queryVersions: function(e) {
            if (this.appid === '') {
                this.versions = []
            } else {
                queryAppVersions(this.appid).then(res => {
                    if (res.status === 200) {
                        this.versions = res.data.data
                    }
                })
            }
        },
        clearCache() {
            this.version.id = ''
            this.version.version = ''
            this.version.applicationId = ''
            this.version.link = ''
            this.version.details = ''
            this.files = []
        },
        newClick: function(e) {
            this.clearCache()
            this.button = '新增'
            this.dialog_title = `${this.button}版本`
            this.show_dialog = true
            this.modify = false
        },
        uploadSuccess: function (res, file) {
            if (res.code === 1) {
                this.version.link = res.filePath
            }
        },
        uploadError: function (res, file) {
            this.$message.error('文件上傳失敗')
        },
        saveClick: function(e) {
            this.$refs['version'].validate(valid => {
                if (valid) {
                    saveAppVersion(this.modify, this.version).then(res => {
                        if (res.status === 200) {
                            this.$message({
                                message: `${this.button}成功`,
                                type: 'success',
                                showClose: true
                            })
                            if (this.appid === this.version.applicationId) {
                                this.queryVersions()
                            }
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
            this.$refs['version'].resetFields()
            this.clearCache()
        },
        editClick: function(val) {
            this.version = Object.assign({}, val)
            this.files.push({name: val.version.version, url: this.RES_URL + val.version.link})
            this.button = '修改'
            this.dialog_title = `${this.button}版本`
            this.show_dialog = true
            this.modify = true
        }
    }
}
</script>
