<template>
	<div>
		<div class="toolbar">
			<p class="title">停用用户</p>
		</div>
		<div class="content">
			<el-table :data="users" border stripe size="mini">
				<el-table-column prop="no" label="工号" width="100" />
				<el-table-column prop="name" label="姓名" align="center" width="130" />
				<el-table-column prop="mail" label="邮箱" align="center" />
				<el-table-column prop="phone" label="电话" align="center" width="120" />
				<el-table-column prop="ext" label="分机" align="center" width="100" />
				<el-table-column label="恢复" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button
							size="mini"
							type="warning"
							icon="el-icon-plus"
							circle
							@click="recoverClick(scope.row)"
						/>
					</template>
				</el-table-column>
				<el-table-column label="删除" width="60px" align="center" fixed="right">
					<template slot-scope="scope">
						<el-button
							size="mini"
							type="danger"
							icon="el-icon-delete"
							circle
							@click="deleteClick(scope.row)"
						/>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				style="margin-top: 16px"
				@size-change="getUsers"
				@current-change="getUsers"
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
	import { getUsers, disableUser, deleteUser } from '../../api/iot.js'
	export default {
		data() {
			return {
				users: [],
				current_page: 1,
				page_size: 10,
				total: 0
			}
		},
		mounted() {
			this.getUsers()
		},
		methods: {
			recoverClick: function (val) {
				this.$confirm(`此操作将恢复 ' ${val.no} ${val.name} ' 的使用，是否继续？`, '提示', {
					confirmButtonText: '恢复',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					disableUser(val.no, 0).then(res => {
						if (res.data.code == 1) {
							this.$message({
								message: '启用成功',
								type: 'success',
								showClose: true
							})
							this.getUsers()
						} else {
							this.$message({
								message: '启用失败',
								type: 'error',
								showClose: true
							})
						}
					})
				})
			},
			deleteClick: function (val) {
				this.$confirm(`此操作将彻底删除 ' ${val.no} ${val.name} ' ，是否继续？`, '提示', {
					confirmButtonText: '删除',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					deleteUser(val.no).then(res => {
						if (res.data.code == 1) {
							this.$message({
								message: '删除成功',
								type: 'success',
								showClose: true
							})
							this.getUsers()
						} else {
							this.$message({
								message: '删除失败',
								type: 'error',
								showClose: true
							})
						}
					})
				})
			},
			getUsers() {
				getUsers('', 1, this.current_page, this.page_size).then(res => {
					if (res.data.code == 1) {
						this.users = res.data.users
						this.total = res.data.total
					}
				})
			}
		}
	}
</script>