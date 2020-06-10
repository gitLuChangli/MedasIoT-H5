<template>
	<div>
		<div class="toolbar">
			<p class="title">角色管理</p>
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
				:data="roles"
				style="width: 100%; margin-bottom: 20px;"
				border
				stripe
				size="mini"
			>
                <el-table-column prop="name" label="ID" width="300" sortable />
				<el-table-column prop="title" label="標題" />
				<el-table-column prop="details" label="詳情" />
				<el-table-column label="菜單">
            </el-table>
        </div>
	</div>
</template>
<script>
	export default {
		data() {
			return {
                roles: [],
			}
		},
		mounted() {

		},
		methods: {
            showNewClick: function(e) {

            }
		},
	}
</script>