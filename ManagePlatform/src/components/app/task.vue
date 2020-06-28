<template>
	<div>
		<div class="toolbar">
			<p class="title">安排升級</p>
		</div>
		<div class="content">
			<el-form ref="task" :model="task" label-position="right" size="small" label-width="200px">
				<el-form-item label="選擇應用">
					<el-select
						v-model="appid"
						size="small"
						placeholder="請選擇應用"
						@change="appChange(appid)"
						style="width: 300px"
					>
						<el-option v-for="item in apps" :key="item.id" :label="item.name" :value="item.id" />
					</el-select>
				</el-form-item>
				<el-form-item label="選擇版本">
					<el-select
						v-model="task.versionId"
						size="small"
						placeholder="請選擇應用版本"
						@change="versionChange(task.versionId)"
						style="width: 300px"
					>
						<el-option v-for="item in versions" :key="item.id" :label="item.version" :value="item.id" />
					</el-select>
				</el-form-item>
				<el-form-item label="設備列表">
					<el-table
						:data="devices"
						stripe
						size="mini"
						border
						ref="multipleTable"
						@selection-change="handleSelectionChange"
					>
						<el-table-column type="selection" width="55" />
						<el-table-column prop="sn" label="設備編號" align="center" />
						<el-table-column prop="model" label="設備型號" align="center" />
						<el-table-column prop="name" label="設備名稱" align="center" />
					</el-table>
					<el-pagination
						style="margin-top: 16px"
						@size-change="queryByApplication"
						@current-change="queryByApplication"
						:current-page.sync="current_page"
						:page-sizes="[10, 20, 30, 50]"
						:page-size="page_size"
						layout="total, prev, pager, next"
						:hide-on-single-page="false"
						:total="total"
					/>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="taskClick">安排升級</el-button>
				</el-form-item>
			</el-form>
		</div>
	</div>
</template>
<script>
import { queryMasterApps, queryAppVersions, adminQueryDeviceByApplication, createUpdateTask } from '../../api/iot.js'
export default {
    data() {
        return {
            appid: '',
            apps: [],
            versions: [],
            task: {
                versionId: '',
                sns: []
			},
			devices: [],
			current_page: 1,
			page_size: 10,
			total: 0
        }
    },
    mounted() {
        queryMasterApps().then(res => {
            if (res.status === 200) {
                this.apps = res.data.data
            }
        })
    },
    methods: {
        appChange: function(val) {
			console.log(this.appid)
            this.task.versionId = ''
            queryAppVersions(val).then(res => {
                if (res.status === 200) {
                    this.versions = res.data.data
                }
			})
			this.queryByApplication()
        },
        handleSelectionChange: function(val) {
			this.task.sns = []
			for (var i = 0; i < val.length; i++) {
				this.task.sns.push(val[i].sn)
			}
			console.log(this.task.sns)
        },
        taskClick: function(e) {
			this.$refs['task'].validate(valid => {
				if (valid) {
					createUpdateTask(this.task).then(res => {
						if (res.status === 200) {
							this.showSuccess(`安排成功`)
							this.task.sns = []
							this.$refs.multipleTable.clearSelection()
						} else {
							this.showError(`安排失敗`)
						}
					})
				}
			})
		},
		queryByApplication() {
			adminQueryDeviceByApplication(this.appid, this.current_page - 1, this.page_size).then(res => {
				if (res.status === 200) {
					this.devices = res.data.data.content
					this.total = res.data.data.totalElements
				}
			})
		}
    }
}
</script>
