import axios from 'axios'

/**
 * 创建/修改部门
 * @param {*} modify true：修改，false：创建
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
export async function saveCompany(modify, company) {
    var _method = modify ? 'put' : 'post'
    return axios({
        url: `/api/company/`,
        data: company,
        method: _method
    })
}

/**
 * 启用/禁用部门
 * @param {\\d+} companyId 部门编号
 * @param {^[01]$} status 1：禁用，0启用
 */
export async function disableCompany(companyId, status) {
    return axios({
        url: `/api/company/disable/${companyId}/${status}`,
        method: `put`
    })
}

/**
 * 删除部门
 * @param {\\d+} companyId 部门编号
 */
export async function deleteCompany(companyId) {
    return axios({
        url: `/api/company/${companyId}`,
        method: `delete`
    })
}

/**
 * 获取所有的部门
 */
export async function queryCompanies() {
    return axios({
        url: `/api/company/descendants`,
        method: `get`
    })
}

/**
 * 获取部门信息
 * @param {\\d+} companyId 部门编号
 */
export async function getCompanyById(companyId) {
    return axios({
        url: `/api/company/${companyId}`,
        method: `get`
    })
}

/**
 * 获取该部门的下属部门
 * @param {\\d+} companyId 部门编号
 */
export async function queryCompanyDescendantsById(companyId) {
    return axios({
        url: `/api/company/descendants/${companyId}`,
        method: `get`
    })
}

/**
 * 获取该部门的层级关系
 * @param {*} companyId 部门编号
 */
export async function queryAncestorIds(companyId) {
    return axios({
        url: `/api/company/ancestors/${companyId}`,
        method: `get`
    })
}

/** */

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
        url: `/api/user/`,
        method: `post`,
        data: user
    })
}

/**
 * 查询用户
 * @param {*} companyId 部门编号
 * @param {*} status 0：正常用户，1：禁用用户，空：全部用户
 * @param {*} page 页码
 * @param {*} size 页面大小
 */
export async function queryUsers(companyId, page, size) {
    var _url = ''
    if (companyId === '' || companyId === null) {
        _url = `/api/user/?page=${page}&size=${size}`
    } else {
        _url = `/api/user/company/${companyId}/?page=${page}&size=${size}`
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
        url: `/api/user/disable/${userid}/${disable}`,
        method: `put`
    })
}

/**
 * 删除用户
 * @param {*} userid 用户编号
 */
export async function deleteUser(userid) {
    return axios({
        url: `/api/user/${userid}`,
        method: `delete`
    })
}

/**
 * 新增、修改用户信息
 * @param {*} modify true：修改，false：新增
 * @param {*} user  用户信息
 */
export async function saveUser(modify, user) {
    var _method = modify ? 'put' : 'post'
    return axios({
        url: `/api/user/`,
        method: _method,
        data: user
    })
}

/**
 * 重置密码
 * @param {*} userid 用户编号
 */
export async function resetPwd(userid) {
    return axios({
        url: `/api/user/reset_pwd/${userid}`,
        method: `put`
    })
}

/**
 * 设置角色
 * @param {*} userRoles 用户及角色
 */
export async function setUserRoles(userRoles) {
    return axios({
        url: `/api/user/set/role`,
        method: `put`,
        data: userRoles
    })
}

/**
 * 获取用户菜单
 * @param {*} userid 用户编号
 */
export async function queryUserResource(userid) {
    return axios({
        url: `/api/user/resources/${userid}`,
        method: `get`
    })
}

/** */

/**
 * 新增/保存资源
 * @param {*} modify true：修改，false：新增
 * @param {*} res 资源
 */
export async function saveResource(modify, res) {
    var _url = `/api/res/`
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
 * @param {*} type 资源类型,0菜单，1按钮
 * @param {*} all 显示所有，包含禁用
 */
export async function queryResources(type, all) {
    var _url = `/api/res/descendants/type/${type}`
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
 * @param {*} resid 资源编号
 * @param {*} status 状态，1：禁用，0：启用
 */
export async function disableResource(resid, status) {
    var _url = `/api/res/disable/${resid}/${status}`
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
export async function deleteResource(resid) {
    var _url = `/api/res/${resid}`
    return axios({
        url: _url,
        method: `delete`
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
        url: `/api/permission/`,
        method: _method,
        data: authority
    })
}

/**
 * 获取权限
 */
export async function queryAuthorities() {
    return axios({
        url: `/api/permission/all/`,
        method: 'get'
    })
}

/**
 * 启用禁用权限
 * @param {*} authorityId 权限编号
 * @param {*} status 1：禁用，0启用
 */
export async function disableAuthority(authorityId, status) {
    return axios({
        url: `/api/permission/disable/${authorityId}/${status}`,
        method: `put`
    })
}

/**
 * 删除权限
 * @param {*} authorityId 权限编号
 */
export async function deleteAuthority(authorityId) {
    return axios({
        url: `/api/permission/${authorityId}`,
        method: `delete`
    })
}

/**
 * 新增/修改角色
 * @param {*} modify false：新增，true：修改
 * @param {*} role 角色信息
 */
export async function saveRole(modify, role) {
    var _method = modify ? 'put' : 'post'
    return axios({
        url: `/api/role/`,
        method: _method,
        data: role
    })
}

/**
 * 获取所有角色
 */
export async function queryRoles() {
    return axios({
        url: `/api/role/`,
        method: `get`
    })
}

/**
 * 刪除角色
 * @param {*} roleId 角色编号
 */
export async function deleteRole(roleId) {
    return axios({
        url: `/api/role/${roleId}`,
        method: `delete`
    })
}

/**
 * 修改角色状态
 * @param {*} roleId 角色编号
 * @param {*} status 0：启用，1：禁用
 */
export async function disableRole(roleId, status) {
    return axios({
        url: `/api/role/disable/${roleId}/${status}`,
        method: `put`
    })
}

/**
 * 获取角色资源
 * @param {*} roleIds 资源编号
 */
export async function queryRoleResources(roleIds) {
    console.log(`123`)
    console.log(roleIds)
    return axios({
        url: `/api/role/resources`,
        method: 'post',
        data: roleIds
    })
}

/**
 * 新增/保存设备类型
 * @param {*} modify true：修改，false：新增
 * @param {*} deviceType 设备类型
 */
export async function saveDeviceType(modify, deviceType) {
    var _method = modify ? 'put' : 'post'
    return axios({
        url: `/api/device/type/`,
        method: _method,
        data: deviceType
    })
}

/**
 * 获取设备类型
 */
export async function queryDeviceTypes() {
    return axios({
        url: `/api/device/type/all`,
        method: `get`
    })
}

/**
 * 刪除设备型号
 * @param {*} typeId 设备型号编号
 */
export async function deleteDeviceType(typeId) {
    return axios({
        url: `/api/device/type/${typeId}`,
        method: `delete`
    })
}

/**
 * 根据设备型号查询版本号
 * @param {*} typeId 设备型号id
 */
export async function queryDeviceVersions(typeId) {
    return axios({
        url: `/api/device/version/type/${typeId}`,
        method: `get`
    })
}

/**
 * 新增、修改设备版本信息
 * @param {*} modify true：修改，false：删除
 * @param {*} version 版本信息
 */
export async function saveDeviceVersion(modify, version) {
    var _method = modify ? `put` : `post`
    return axios({
        url: `/api/device/version/`,
        method: _method,
        data: version
    })
}

/**
 * 删除版本信息
 * @param {*} versionId 版本信息编号
 */
export async function deleteDeviceVersion(versionId) {
    return axios({
        url: `/api/device/version/${versionId}`,
        method: `delete`
    })
}

/**
 * 录入设备
 * @param {*} device 设备信息
 */
export async function adminAddDevices(device) {
    return axios({
        url: `/api/admin/device/`,
        method: `post`,
        data: device
    })
}

/**
 * 根据设备型号查询设备
 * @param {*} type 设备型号编号
 * @param {*} page 页码
 * @param {*} size 页大小
 */
export async function adminQueryDeviceByType(type, page, size) {
    var _url = `/api/admin/device/by/type/${type}?page=${page}&size=${size}`
    return axios({
        url: _url,
        method: `get`
    })
}

/**
 * 根据设备版本编号查询设备
 * @param {*} versionId 设备版本编号
 * @param {*} page 页码
 * @param {*} size 页面大小
 */
export async function adminQueryDeviceByVersionId(versionId, page, size) {
    var _url = `/api/admin/device/by/version/${versionId}?page=${page}&size=${size}`
    return axios({
        url: _url,
        method: `get`
    })
}

/**
 * 给设备分配部门
 * @param {*} deviceCompany 设备部门信息
 */
export async function adminSetDeviceCompany(deviceCompany) {
    return axios({
        url: `/api/admin/device/set/company/`,
        method: `put`,
        data: deviceCompany
    })
}

/**
 * 根据应用查询设备
 * @param {*} appid 应用编号
 */
export async function adminQueryDeviceByApplication(appid) {
    return axios({
        url: `/api/admin/device/by/app/${appid}`,
        method: `get`
    })
}

/**
 * 查询所有应用
 */
export async function queryApps() {
    return axios({
        url: `/api/app/all`,
        method: `get`
    })
}

export async function queryMasterApps() {
    return axios({
        url: `/api/app/master`,
        method: `get`
    })
}

/**
 * 新增/修改应用
 * @param {*} modify true：修改，false：新增
 * @param {*} app 应用信息
 */
export async function saveApp(modify, app) {
    var _method = modify ? `put` : `post`
    return axios({
        url: `/api/app/`,
        method: _method,
        data: app
    })
}

/**
 * 启用、禁用应用
 * @param {*} appid 应用编号
 * @param {*} status 1：禁用，0：启用
 */
export async function disableApp(appid, status) {
    var _url = `/api/app/disable/${appid}/${status}`
    return axios({
        url: _url,
        method: `put`
    })
}

/**
 * 删除应用
 * @param {*} appid 应用编号
 */
export async function deleteApp(appid) {
    var _url = `/api/app/${appid}`
    return axios({
        url: _url,
        method: `delete`
    })
}

/**
 * 获取应用参数项
 * @param {*} appid 应用编号
 */
export async function getAppParameters(appid) {
    var _url = `/api/app/parameters/${appid}`
    return axios({
        url: _url,
        method: `get`
    })
}

/**
 * 设置应用参数
 * @param {*} appid 应用编号
 * @param {*} parameters 应用参数
 */
export async function setAppParameters(appid, parameters) {
    return axios({
        url: `/api/app/parameters/${appid}`,
        method: `put`,
        data: parameters
    })
}

/**
 * 新增、修改版本
 * @param {*} modify true：修改，false：新增
 * @param {*} version 版本信息
 */
export async function saveAppVersion(modify, version) {
    var _method = modify ? 'put' : 'post'
    return axios({
        url: `/api/app/version/`,
        method: _method,
        data: version
    })
}

/**
 * 获取应用的版本信息
 * @param {*} appid 应用编号
 */
export async function queryAppVersions(appid) {
    return axios({
        url: `/api/app/version/app/${appid}`,
        method: 'get'
    })
}

/**
 * 给设备设置应用
 * @param {*} devid 设备编号
 * @param {*} appid 应用编号
 */
export async function deviceSetApplication(devid, appid) {
    return axios({
        url: `/api/admin/device/set/app/${devid}/${appid}`,
        method: `put`
    })
}

/**
 * 给设备设置参数
 * @param {*} devid 设备编号
 * @param {*} parameter 参数
 */
export async function deviceSetParameter(devid, parameter) {
    return axios({
        url: `/api/device/set/parameter/${devid}`,
        method: `put`,
        data: parameter
    })
}

/**
 * 创建升级任务
 * @param {*} task 升级任务
 */
export async function createUpdateTask(task) {
    return axios({
        url: `/api/update/task`,
        method: `post`,
        data: task
    })
}

/**
 * 查询升级记录
 * @param {*} action ready：未升级，complete：已升级
 * @param {*} page 页码
 * @param {*} size 页面大小
 */
export async function queryUpdateRecords(action, page, size) {
    return axios({
        url: `/api/update/${action}?page=${page}&size=${size}`,
        method: `get`
    })
}