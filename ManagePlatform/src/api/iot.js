import axios from 'axios'

const host = 'http://127.0.0.1:8080'

/**
 * 获取所有部门
 */
export async function getCompany() {
    return axios({
        url: `${host}/api/company/query`,
        method: 'POST'
    })
}

/**
 * 获取下属部门
 * @param {*} id    部门id
 * @param {*} depth 下属部门深度，获取全部传入all
 */
export async function getCompanyById(id, depth) {
    return axios({
        url: `${host}/api/company/query?ancestor=${id}&depth=${depth}`,
        method: 'POST'
    })
}

/**
 * 创建部门
 * 
 * @param {*} act new,new_bo,new_bg,new_sg新增不同的部门
 *                edit, edit_bo, edit_bg, edit_sg修改部门的信息
 *                需要不同的权限的，或者后期可以修改成为一个，因为这个平台可以由我们自行维护
 * @param {*} json 
 */
export async function saveCompany(act, json) {
    return axios({
        url: `${host}/api/company/${act}`,
        data: json,
        method: 'POST'
    })
}

/**
 * 启用或禁用部门
 * @param {*} id 
 * @param {*} status 
 */
export async function disableCompany(id, status) {
    return axios({
        url: `${host}/api/company/disable?id=${id}&status=${status}`,
        method: 'POST'
    })
}

/**
 * 新增或修改用户
 * 
 * @param {*} isnew true新增，false修改
 * @param {*} json  用户信息
 */
export async function saveUser(isnew, json) {
    var act = isnew ? 'new' : 'edit'
    return axios({
        url: `${host}/api/user/${act}`,
        data: json,
        method: 'POST'
    })
}

/**
 * 获取用户
 * @param {*} ancestor 
 * @param {*} status 
 * @param {*} page 
 * @param {*} size 
 */
export async function getUsers(ancestor, status, page, size) {
    return axios({
        url: `${host}/api/user/query?ancestor=${ancestor}&page=${page}&size=${size}&status=${status}`,
        method: 'POST'
    })
}

/**
 *  启用/禁用用户
 * 
 * @param {*} no 
 * @param {*} disable 
 */
export async function disableUser(no, disable) {
    return axios({
        url: `${host}/api/user/disable?no=${no}&disable=${disable}`,
        method: 'POST'
    })
}

/**
 * 获取用户的组织关系
 * @param {*} no 
 */
export async function getUserCascadeIds(no) {
    return axios({
        url: `${host}/api/user/query/cascade?no=${no}`,
        method: 'POST'
    })
}

/**
 * 删除用户
 * 
 * @param {*} no 
 */
export async function deleteUser(no) {
    return axios({
        url: `${host}/api/user/delete?no=${no}`,
        method: 'POST'
    })
}

/**
 * 重置密码
 * @param {*} no 
 */
export async function resetPwd(no) {
    return axios({
        url: `${host}/api/user/reset_pwd?no=${no}`,
        method: 'POST'
    })
}

export async function getDeviceType() {
    return axios({
        url: `${host}/api/dev/query`,
        method: 'POST'
    })
}

export async function saveDeviceType(isnew, json) {
    var act = isnew ? 'new' : 'edit'
    return axios({
        url: `${host}/api/dev/${act}`,
        method: 'POST',
        data: json
    })
}

export async function newDeviceVersion(json) {
    return axios({
        url: `${host}/api/dev/new/version`,
        method: 'POST',
        data: json
    })
}

export async function deleteDevice(ids) {
    return axios({
        url: `${host}/api/dev/delete`,
        method: 'POST',
        data: ids
    })
}
export async function newDeviceItem(item) {
    return axios({
        url: `${host}/api/dev/item/new`,
        method: 'POST',
        data: item
    })
}
export async function getDeviceItems(deviceId, page, size) {
    return axios({
        url: `${host}/api/dev/item/query?device=${deviceId}&page=${page}&size=${size}`,
        method: 'POST'
    })
}