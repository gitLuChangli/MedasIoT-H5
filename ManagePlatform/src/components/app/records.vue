<template>
	<div>
		<div class="toolbar">
			<p class="title">升級記錄</p>
		</div>
		<div class="toolbar" style="text-align: center">
			<el-radio-group v-model="action" size="mini" @change="actionChange">
				<el-radio-button label="ready">未升級</el-radio-button>
				<el-radio-button label="complete">已升級</el-radio-button>
			</el-radio-group>
		</div>
		<div class="content">
			<el-table
				:data="records"
				stripe
                border
				size="mini"
			>
				<el-table-column prop="sn" label="設備編號" />
				<el-table-column prop="appId" label="應用" />
                <el-table-column prop="applicationName" label="應用名稱" />
				<el-table-column prop="version" label="版本號" align="center" />
                <el-table-column prop="link" label="鏈接" width="100" align="center">
                    <template slot-scope="scope">
                        <el-link type="primary" :href="RES_URL + scope.row.link"><i class="el-icon-download" /></el-link>
                    </template>
                </el-table-column>
                <el-table-column prop="createOn" label="安排時間" v-if="action === 'ready'" align="center" />
                <el-table-column prop="createOn" label="升級時間" v-if="action === 'complete'" align="center" />
			</el-table>
			<el-pagination
				style="margin-top: 16px"
				@size-change="actionChange"
				@current-change="actionChange"
				:current-page.sync="current_page"
				:page-sizes="[10, 20, 30, 50]"
				:page-size="page_size"
				layout="total, prev, pager, next"
				:hide-on-single-page="false"
				:total="total"
			/>
		</div>
	</div>
</template>
<script>
import { queryUpdateRecords } from '../../api/iot.js'
export default {
    data() {
        return {
            action: 'ready',
            records: [],
            current_page: 1,
			page_size: 10,
			total: 0
        }
    },
    mounted() {
        this.actionChange()
    },
    methods: {
        actionChange: function(e) {
            queryUpdateRecords(this.action, this.current_page - 1, this.page_size).then(res => {
                if (res.status === 200) {
                    this.records = res.data.data.content
                    this.total = res.data.data.totalElements
                } else {
                    this.showError(`查询失败`)
                }
            })
        }
    }
}
</script>
