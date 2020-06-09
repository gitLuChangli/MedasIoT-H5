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
 * 新增用户
 * @param {
 *  no 工号，不为空
 *  name 姓名，不为空
 *  email 邮箱地址，不为空
 *  openId 微信公众工号ID
 *  icivetId 香信ID
 *  phone 手机号
 *  ext 分机
 *  companyIds 部门层级，不为空
 *  roles 权限
 * } user
 */
export async function newUser(user) {
    return axios({
        url: `${host}/api/user/`,
        method: `post`,
        data: user
    })
}

/**
 * 查询用户
 * @param {*} companyId 部门编号
 * @param {*} status
 * @param {*} page
 * @param {*} size
 */
export async function queryUsers(companyId, status, page, size) {
    var _url = ''
    if (companyId === '' || companyId == undefined) {
        _url = `${host}/api/user/status/${status}?page=${page}&size=${size}`
    } else {
        _url = `${host}/api/user/company/${companyId}/${status}?page=${page}&size=${size}`
    }
    return axios({
        url: _url,
        method: `get`
    })
}

/**
 *  启用/禁用用户
 * @param {*} userid  用户编号
 * @param {*} disable 1：禁用，0：启用
 */
export async function disableUser(userid, disable) {
    return axios({
        url: `${host}/api/user/disable/${userid}/${disable}`,
        method: `put`
    })
}

/**
 * 删除用户
 * @param {*} userid 用户编号
 */
export async function deleteUser(userid) {
    return axios({
        url: `${host}/api/user/${userid}`,
        method: `delete`
    })
}

/**
 * 查询该用户所属部门的层级关系
 * @param {*} userid 用户编号
 */
export async function queryCompanyRelations(userid) {
    return axios({
        url: `${host}/api/user/company/relations/${userid}`,
        method: `get`
    })
}

/**
 * 修改用户信息
 * @param {*} user  用户信息
 */
export async function updateUser(user) {
    return axios({
        url: `${host}/api/user/`,
        method: `put`,
        data: user
    })
}

/**
 * 重置密码
 * @param {*} userid 用户编号
 */
export async function resetPwd(userid) {
    return axios({
        url: `${host}/api/user/reset_pwd/${userid}`,
        method: `put`
    })
}

/**
 * 新增/保存资源
 * @param {*} modify true：修改，false：新增
 * @param {*} action 资源类型
 * @param {*} res 资源
 */
export async function saveResource(modify, action, res) {
    var _url = `${host}/api/${action}/`
    var _method = ''
    if (modify) {
        _method = `put`
    } else {
        _method = `post`
    }
    return axios({
        url: _url,
        method: _method,
        data: res
    })
}

/**
 * 获取资源
 * @param {*} action 资源类型
 * @param {*} all 显示所有，包含禁用
 */
export async function queryResources(action, all) {
    var _url = `${host}/api/${action}/descendants`
    if (all) {
        _url += '?all=true'
    }
    return axios({
        url: _url,
        method: `get`
    })
}

/**
 * 启用禁用资源
 * @param {*} action 资源类型
 * @param {*} resid 资源编号
 * @param {*} status 状态，1：禁用，0：启用
 */
export async function disableResource(action, resid, status) {
    var _url = `${host}/api/${action}/disable/${resid}/${status}`
    return axios({
        url: _url,
        method: `put`
    })
}

/**
 * 刪除资源
 * @param {*} action 资源类型
 * @param {*} resid 资源编号
 */
export async function deleteResource(action, resid) {
    var _url = `${host}/api/${action}/${resid}`
    return axios({
        url: _url,
        method: `delete`
    })
}

/**
 * 查看资源父级
 * @param {*} action 资源类型
 * @param {*} descendant 资源编号
 */
export async function queryAncestorsByDescendant(action, descendant) {
    var _url = `${host}/api/${action}/ancestors/${descendant}`
    return axios({
        url: _url,
        method: `get`
    })
}

/**
 * 新增、保存权限
 * @param {*} isnew true：新增，false
 * @param {*} authority 权限信息
 */
export async function saveAuthority(isnew, authority) {
    var _method = isnew ? 'post' : 'put'
    return axios({
        url: `${host}/api/permission/`,
        method: _method,
        data: authority
    })
}

/**
 * 获取权限
 */
export async function queryAuthorities() {
    return axios({
        url: `${host}/api/permission/all/`,
        method: 'get'
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