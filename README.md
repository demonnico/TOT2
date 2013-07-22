TOT2
====

New TOT project, use rails. developing..................so don't download me right now : D

Created in rails 3.2.13, tested in rails 3.2.13 and rails 4.0

Use devise 3.0.0
Use bootstrap
Use sqlite 3

#How to use

####1.Download TOT2 or clone it to your server.  

```
$ git clone https://github.com/OpenFibers/TOT2.git
```

####2.Run the rails server

```
$ cd TOT2
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed
$ rails server
```

A default admin account with email: tot@tot.com, password: totadmin will be generated.

####3.Upload ipa and dSYM files  

Open [http://localhost:3000/admin](http://localhost:3000/admin)  
Login use default admin account with email: tot@tot.com, password: totadmin.  
Click 'Upload' in the top of the admin page.  
Upload ipa and dSYM files.

***We suggest register a new user and award permissions to users, instead of manage apps use default admin account.

####4.Download apps in iOS devices