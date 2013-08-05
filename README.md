TOT2
====

An Apple OTA server, includes a server to upload beta test ipa packages and a web app to let others download beta test ipa packages.

#Features
1.Dynamic manifest technology, sqlite and local file storage makes server migration be easy.  
2.Management of apps.  
3.Management of users and permissions.  

#What's new
App management.  
User and permission management.  

#It's a Rails app
Created in rails 3.2.13, tested in rails 3.2.13 and rails 4.0  

Use [devise](https://github.com/plataformatec/devise) 3.0.0  
Use [cancan](https://github.com/ryanb/cancan) 1.6.10  
Use [rubyzip](https://github.com/rubyzip/rubyzip) 0.9.9  
Use [CFPropertyList](https://github.com/ckruse/CFPropertyList) 2.2.0  
Use [bootstrap](http://getbootstrap.com/)  
Use [pngdefry](http://www.jongware.com/pngdefry.html)  
Use sqlite 3  

#How to use

####1.Download TOT2 or clone it to your server.  

```
$ git clone https://github.com/OpenFibers/TOT2.git
```

####2.Init the rails server

```
$ cd TOT2
$ ./tot.sh setup
```

A default admin account with email: ***tot@tot.com***, password: ***totadmin*** will be generated.

####3.Start the rails server

```
$ ./tot.sh
```

####4.Upload ipa and dSYM files  

Open [http://your-ip-or-host-of-rails-server:3000/admin](http://your-ip-or-host-of-rails-server:3000/admin)  
Login use default admin account with email: ***tot@tot.com***, password: ***totadmin***.  
Click '**Upload**' in the top of the admin page.  
Upload ipa and dSYM files.

***We strongly suggest that register a new user and award permissions to users, instead of manage apps use default admin account.***  

####5.Download apps in iOS devices

Open [http://your-ip-or-host-of-rails-server:3000](http://your-ip-or-host-of-rails-server:3000) on iOS devices.  
Download apps.

####6.Reset admin account if forgot

Just run ***rake db:seed*** to reset default account:

```
$ cd TOT2
$ ./tot.sh reset rootuser
```

Restart server, then you can login the TOT2 admin page, [http://your-ip-or-host-of-rails-server:3000/admin] with email: ***tot@tot.com***, password: ***totadmin***.

####7.Reset data base.  

```
$ cd TOT2
$ ./tot.sh reset db
```
Database will be reseted after restart, including apps and users data.

#Other choice

Web Service:  
1.[Test Flight](http://testflightapp.com)  
2.[diawi](http://www.diawi.com)  
3.[AppSendr](http://www.appsendr.com)  
4.[HockeyApp](http://www.hockeyapp.net)  
  
Open Sourced project:  
1.[HockeyKit](https://github.com/TheRealKerni/HockeyKit) : Open sourced PHP5 project.  
2.[BetaBuilder for iOS](http://www.hanchorllc.com/betabuilder-for-ios/) : Open sourced native MAC app. It should be used with a static web server.  
