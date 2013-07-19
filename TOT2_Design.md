#Models

###App

```
bundleId 		:string
lastVersion 	:int
version 		:references  -->> Version
```

###Version

```
versionString 	:string
betaVersion		:int
appName			:string
iconURL			:string
changeLog		:text
releaseDate		:long long //unix timestamp
app				:reference  -->App
```

###Comment

```
userName		:string //可以存user name或email
comment			:text
commentDate		:long long //unix timestamp
```

###User

```
name			:string
password		:password //MD5 hashed
type			:int //0:admin 1:user
```

#Controllers

###Download

```
permission: everyone
routes:
	root				download :list
	root/detail			download :detail
	root/getManifest	download :getManifest
```

###Login

```
permission: everyone
routes:
	root/login			login
```

###Manage

```
permission: admin
routes:
	root/manage						manage:appList
	root/manage/app					manage:versionList
	root/manage/app/id/delete		manage:deleteList
	root/manage/version/id/delete	manage:deleteVersion
	root/manage/comment/id/delete	manage:deleteComment
```