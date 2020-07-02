<template>
	<div class="login-view">
		<div class="header">
			<img src="../../static/ic_logo.png" class="logo" />
		</div>

		<div class="login" v-if="!expired">
			<p class="title">登入</p>
			<el-form ref="form" :model="form" :rules="rules" size="middle">
				<el-form-item prop="username">
					<el-input v-model="form.username" placeholder="請輸入用戶名" />
				</el-form-item>
				<el-form-item prop="password">
					<el-input
						v-model="form.password"
						type="password"
						placeholder="請輸入密碼"
						@keyup.enter.native="onSubmit"
					/>
				</el-form-item>
				<el-form-item v-if="needVerify">
					<el-input
						v-model="form.vercode"
						placeholder="請輸入驗證碼"
						style="width: 150px; float: left"
						@keyup.enter.native="onSubmit"
					/>
					<img :src="verCode" style="margin-top: 5px;" @click="newVerCode" />
				</el-form-item>
				<el-form-item>
					<el-button type="primary" class="login-button" @click="onSubmit" :loading="logining">{{login}}</el-button>
				</el-form-item>
			</el-form>
		</div>

        <div class="login" v-if="expired">
			<p class="title">修改密碼</p>
			<el-form ref="user" :model="user" :rules="rules2" size="middle">
				<el-form-item prop="pwd">
					<el-input
						v-model="user.pwd"
						type="password"
						placeholder="請輸入密碼"
					/>
				</el-form-item>
                <el-form-item prop="newpwd">
					<el-input
						v-model="user.newpwd"
						type="password"
						placeholder="請輸入新密碼"
					/>
				</el-form-item>
                <el-form-item prop="newpwd2">
					<el-input
						v-model="user.newpwd2"
						type="password"
						placeholder="請再次輸入新密碼"
						@keyup.enter.native="setPwdClick"
					/>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" class="login-button" @click="setPwdClick">修改</el-button>
				</el-form-item>
			</el-form>
		</div>

		<p class="note">此網頁最好使用IE11瀏覽器、Edge瀏覽器、谷歌瀏覽器、蘋果瀏覽器、火狐瀏覽器等新式瀏覽器進行瀏覽。</p>
	</div>
</template>
<style scoped>
.login-view {
	position: absolute;
	width: 100%;
	height: 100%;
	overflow-y: auto;
	background-image: linear-gradient(to top, #dfe9f3 0%, white 100%);
}
.header {
	width: 100%;
	height: 60px;
	background: #393f4c;
	line-height: 60px;
	box-shadow: 0 3px 6px #00000016;
}
.logo {
	padding: 6px 16px;
	height: 48px;
}
.login {
	-webkit-border-radius: 5px;
	border-radius: 5px;
	-moz-border-radius: 5px;
	background-clip: padding-box;
	margin: 100px auto;
	width: 350px;
	padding: 32px 32px 64px 32px;
	background: #fff;
	border: 1px solid #eaeaea;
	box-shadow: 0 3px 6px #00000016;
}
.title {
	font-size: 18px;
	font-weight: bold;
	text-align: center;
	height: 64px;
}
.login-button {
	width: 100%;
	background: #6699ff;
	border: none;
}
.login-button:hover {
	background: #0252db;
}
.note {
	text-align: center;
	color: #00000090;
	font-size: 12px;
	font-weight: bolder;
	position: fixed;
	bottom: 80px;
	width: 100%;
	overflow: hidden;
}
</style>
<script>
export default {
    data() {
        return {
            form: {
                username: '',
                password: '',
                vercode: ''
            },
            verCode: '',
            rules: {
                username: [{required: true, message: '請輸入用戶名', trigger: 'blur'}],
                password: [{required: true, message: '請輸入密碼', trigger: 'blur'}],
                vercode: [{required: true, message: '請輸入驗證碼', trigger: 'blur'}]
            },
            rules2: {
                pwd: [{required: true, message: '請輸入密碼', trigger: 'blur'}],
                newpwd: [{required: true, message: '請輸入新密碼', trigger: 'blur'}],
                newpwd2: [{required: true, message: '再次輸入新密碼', trigger: 'blur'}]
            },
            needVerify: false,
            logining: false,
            login: '登入',
            user: {
                username: '',
                pwd: '',
                newpwd: '',
                newpwd2: ''
            },
            expired: false
        }
    },
    methods: {
        newVerCode(e) {

        },
        onSubmit(e) {
            this.$refs.form.validate(valid => {
                if (valid) {
                    this.$axios({
                        url: `/form/login?username=${this.form.username}&password=${this.form.password}`,
                        method: `post`
                    }).then(res => {
                        console.log(res)
                        if (res.status === 200) {
                            switch (res.data.code) {
                                case 1:
                                    self.location = '/'
                                    break
                                case 100:
                                    this.showError('用戶名或密碼錯誤')
                                    break
                                case 101:
                                    this.showError(`已被鎖定，請解鎖后再使用`)
                                    break
                                case 102:
                                    this.showError('需要修改密碼')
                                    this.user.username = this.form.username
                                    this.$refs.form.resetFields()
                                    this.expired = true
                                    break
                                case 103:
                                    this.showError('用戶已停用')
                                    break
                                default:
                                    this.showError(`登录失败`)
                                    break
                            }
                        } else {
                            this.showError(`登录失败`)
                        }
                    })
                }
            })
        },
        setPwdClick: function(e) {
            this.$refs.user.validate(valid => {
                if (valid) {
                    if (this.user.newpwd !== this.user.newpwd2) {
                        this.showError('兩次輸入的新密碼不匹配，請重新輸入')
                    } else {

                    }
                }
            })
        }
    }
}
</script>
