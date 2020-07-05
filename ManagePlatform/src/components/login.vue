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
					/>
				</el-form-item>
				<el-form-item prop="vcode">
					<el-input
						v-model="form.vcode"
						placeholder="請輸入驗證碼"
						style="width: 150px; float: left"
						@keyup.enter.native="onSubmit"
					/>
					<img :src="verCode" style="margin: 5px 16px;" @click="newVerCode" />
				</el-form-item>
				<el-form-item>
					<el-button type="primary" class="login-button" @click="onSubmit" :loading="logining">{{login}}</el-button>
				</el-form-item>
			</el-form>
		</div>

        <div class="login" v-if="expired">
			<p class="title">修改密碼</p>
			<el-form ref="user" :model="user" :rules="rules2" size="middle">
				<el-form-item prop="password">
					<el-input
						v-model="user.password"
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
	padding: 32px;
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
                username: 'W0515366',
                password: '12345678',
                vcode: ''
            },
            verCode: '',
            rules: {
                username: [{required: true, message: '請輸入用戶名', trigger: 'blur'}],
                password: [{required: true, message: '請輸入密碼', trigger: 'blur'}],
                vcode: [{required: true, message: '請輸入驗證碼', trigger: 'blur'}]
            },
            rules2: {
                password: [{required: true, message: '請輸入密碼', trigger: 'blur'}],
                newpwd: [{required: true, message: '請輸入新密碼', trigger: 'blur'}],
                newpwd2: [{required: true, message: '再次輸入新密碼', trigger: 'blur'}]
            },
            needVerify: false,
            logining: false,
            login: '登入',
            user: {
                username: 'W0515366',
                password: '',
                newpwd: '',
                newpwd2: ''
            },
            expired: false
        }
	},
	mounted() {
		this.newVerCode()
	},
    methods: {
        newVerCode(e) {
			this.verCode = `http://127.0.0.1:8081/vcode?` + Date.parse(new Date())
        },
        onSubmit(e) {
            this.$refs.form.validate(valid => {
                if (valid) {
                    this.$axios({
						url: `/auth/login`,
                        method: `post`,
						data: this.form
                    }).then(res => {
                        console.log(res)
                        if (res.status === 200) {
                            switch (res.data.status) {
                                case 200:
                                    self.location = '/'
                                    break
                                case 1001:
                                    this.showError('需要修改密碼')
									this.user.username = this.form.username
									this.user.newpwd = ''
									this.user.newpwd2 = ''
                                    this.expired = true
                                    break
                                default:
                                    this.showError(res.data.msg)
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
					console.log(this.user)
                    if (this.user.newpwd !== this.user.newpwd2) {
                        this.showError('兩次輸入的新密碼不匹配，請重新輸入')
                    } else {
						this.$axios({
							url: `/auth/pwd`,
							method: `post`,
							data: this.user
						}).then(res => {
							console.log(res)
							if (res.status === 200 && res.data.status === 200) {
								this.showSuccess('修改成功')
								this.expired = false
							} else {
								this.showError(`修改失敗`);
							}
						})
                    }
                }
            })
        }
    }
}
</script>
