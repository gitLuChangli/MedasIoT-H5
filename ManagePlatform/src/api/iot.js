import axios from 'axios'

const host = 'http://127.0.0.1:8080'

/**
 * 创建部门
 * @param {
 *  code 费用代码，不为空
 *  name 部门名称，不为空
 *  details 部门详情
 *  region 地区
 *  province 省
 *  city 市
 *  county 县
 *  address 地址
 *  area 园区
 *  ancestor 所属部门，从最高层级开始，逗号隔开
 * } company 部门信息
 */
export async function newCompany(company) {
    return axios({
        url: `${host}/api/company/`,
        data: company,
        method: `post`
    })
}

/**
 * 修改部门信息
 * @param {
 *  code 费用代码，不为空
 *  name 部门名称，不为空
 *  details 部门详情
 *  region 地区
 *  province 省
 *  city 市
 *  county 县
 *  address 地址
 *  area 园区
 *  ancestor 所属部门，从最高层级开始，逗号隔开
 * } company 部门信息
 */
export async function editCompany(company) {
    return axios({
        url: `${host}/api/company/`,
        data: company,
        method: `put`
    })
}

/**
 * 启用/禁用部门
 * @param {\\d+} companyId 部门编号
 * @param {^[01]$} status 1：禁用，0启用
 */
export async function disableCompany(companyId, status) {
    return axios({
        url: `${host}/api/company/disable/${companyId}/${status}`,
        method: `put`
    })
}

/**
 * 删除部门
 * @param {\\d+} companyId 部门编号
 */
export async function deleteCompany(companyId) {
    return axios({
        url: `${host}/api/company/delete/${companyId}`,
        method: `delete`
    })
}

/**
 * 获取所有的部门
 */
export async function getCompanies() {
    return axios({
        url: `${host}/api/company/descendants`,
        method: `get`
    })
}

/**
 * 获取部门信息
 * @param {\\d+} companyId 部门编号
 */
export async function getCompanyById(companyId) {
    return axios({
        url: `${host}/api/company/${companyId}`,
        method: `get`
    })
}

/**
 * 获取该部门的下属部门
 * @param {\\d+} companyId 部门编号
 */
export async function getCompanyDescendantsById(companyId) {
    return axios({
        url: `${host}/api/company/ancestor/${companyId}`,
        method: `get`
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