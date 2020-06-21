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
						ref="multipleTable"
						@selection-change="handleSelectionChange"
					>
						<el-table-column type="selection" width="55" />
						<el-table-column prop="sn" label="設備編號" width="150" />
						<el-table-column prop="model" label="設備型號" width="150" />
						<el-table-column prop="name" label="設備名稱" width="200" />
					</el-table>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="taskClick">安排升級</el-button>
				</el-form-item>
			</el-form>
		</div>
	</div>
</template>
<script>
import { queryMasterApps, queryAppVersions } from '../../api/iot.js'
export default {
    data() {
        return {
            appid: '',
            apps: [],
            versions: [],
            task: {
                versionId: '',
                sns: []
            }
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
            this.task.versionId = ''
            queryAppVersions(val).then(res => {
                if (res.status === 200) {
                    this.versions = res.data.data
                }
            })
        },
        handleSelectionChange: function(e) {

        },
        taskClick: function(e) {

        }
    }
}
</script>
