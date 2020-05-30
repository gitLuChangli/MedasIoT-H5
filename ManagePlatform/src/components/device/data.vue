<template>
    <div>
        <div class="toolbar">
			<p class="title">生产数据</p>
		</div>
        <div class="toolbar" style="text-align: center">
			请选择设备类型：
			<el-select v-model="deviceId" size="small" placeholder="请选择设备类型" @change="getDeviceItems">
				<el-option
					v-for="item in devices"
					:key="item.id"
					:label="item.no + item.name"
					:value="item.id"
				/>
			</el-select>
		</div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            devices: [],
            deviceId: ''
        }
    },
    methods: {
        getDeviceItems: function(e) {

        }
    }
}
</script>