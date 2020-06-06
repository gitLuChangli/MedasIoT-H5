<template>
	<div>
		<div class="toolbar">
			<p class="title">菜單管理</p>
		</div>

		<el-tree :data="menus" :props="props" @node-click="handleNodeClick"></el-tree>
	</div>
</template>
<script>
	import { queryResources } from '../../api/iot.js'
	export default {
		data() {
			return {
				menus: [],
                props: {
                    label: 'name',
                    children: 'descendants',                    
                },
			}
		},
		mounted() {
			queryResources('menu').then(res => {
				if (res.status == 200) {
					this.menus = res.data.data
				}
			})
		},
		methods: {
			handleNodeClick: function (e) {

			}
		}
	}
</script>