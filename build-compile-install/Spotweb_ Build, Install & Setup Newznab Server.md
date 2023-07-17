

* Install `apache2` webserver & `php`

  apache2 php7.3 curl php7.3-curl php7.3-gd php7.3-gmp php7.3-xml gettext php7.3-mbstring php7.3-zip zlib1g-dev openssl libapache2-mod-php7.3

* Set `php` timezone in `/etc/php/7.3/apache2/php.ini` and `/etc/php/7.3/cli/php.ini` to:

  ```
  date.timezone = "Europe/Amsterdam"
  ```

* Install `mysql`

  mysql-server mysql-client php7.3-mysql

* Restart apache2:

  ```
  sudo systemctl restart apache2.service
  ```

  or

  ```
  sudo /etc/init.d/apache2 restart
  ```

* Log-in to mysql:

  ```
  sudo mysql
  ```

* Create a database with user `spotweb`

  ```
  CREATE DATABASE spotweb;
  CREATE USER 'spotweb'@'localhost' IDENTIFIED BY '[insert_password_here]';
  GRANT ALL PRIVILEGES ON spotweb.* TO 'spotweb'@'localhost';
  \q
  ```

* Note that in Ubuntu systems running MySQL 5.7 (and later versions), the root MySQL user is set to authenticate using the `auth_socket` plugin by default rather than with a *password*.

  In order to use a password when spotweb connects to MySQL, you will need to switch its authentication method from `auth_socket` to `mysql_native_password`. To do this, open up the MySQL prompt from your terminal:

  ```
  sudo mysql
  ```

  And enter the following command

  ```
  ALTER USER 'spotweb'@'localhost' IDENTIFIED WITH mysql_native_password BY '[insert_password_here]';
  \q
  ```

* Clone the `spotweb` repo: `git clone https://github.com/spotweb/spotweb.git`

* Place the entire contents of the `spotweb` folder into `/var/www/html/`: `sudo mv spotweb-master /var/www/html/spotweb`

* Create spotweb's cache directory: `mkdir /var/www/html/spotweb/cache`

* Grant read/write access to everyone: `chmod 777 /var/www/html/spotweb/cache`

* For completeness, restart `apache2` again: `sudo systemctl restart apache2.service`

* Start your browser and go to http://localhost/spotweb/install.php

* Everything must be OK, except for these **4**:
  * Database support
    * PostgreSQL
    * SQLite
  * OpenSSL
    * bcmath
  *  Include files
    * Own settings file
  
* Click `Next` is everything else is OK.

* Do NOT put a password in the "*root password for create spotweb db/user*" field.

* Enter the password that you used to create the mysql user above, e.g., [*insert_password_here*].

* Then choose **Verify database**.

* Finally, populate the `spotweb` database by executing:

  ```
  php /var/www/html/spotweb/retrieve.php
  ```

  

## Set `spotweb` up as a `newznab` Provider



Make sure that `mod_rewrite` is enabled in `/var/www/html/spotweb/.htaccess`. The default settings created by recent versions of `spotweb` should be great.

```
<IfModule mod_rewrite.c>
	RewriteEngine on  
	RewriteCond %{REQUEST_URI} !api/  
	RewriteRule api/?$ index.php?page=newznabapi [QSA,L]  
</IfModule>
```

Then make the Apache server loads the RewriteEngine every server start:

```
sudo a2enmod rewrite && sudo systemctl restart apache2.service
```

Next, edit `/etc/apache2/sites-available/000-default.conf`. Add the following towards the end of the file:

```
<Directory /var/www/html/spotweb/>
	Options FollowSymLinks
	AllowOverride All
	Order deny,allow
	Allow from all
	Satisfy all
</Directory>
```

For example:

```
...
</VirtualHost>
<Directory /var/www/html/spotweb/>
	Options FollowSymLinks
	AllowOverride All
	Order deny,allow
	Allow from all
	Satisfy all
</Directory>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```



#### Apache

Make sure that **mod_rewrite** is enabled and **AllowOverride** is set ([more info](http://www.tildemark.com/enable-htaccess-on-apache/)). Create a file called *.htaccess* and enter the following:

```
RewriteEngine on  
RewriteCond %{REQUEST_URI} !api/  
RewriteRule api/?$ index.php?page=newznabapi [QSA]
RewriteRule details/([^/]+) index.php?page=getspot&messageid=$1 [L]
```

If your spotweb installation is not in your www-root dir, but in a  subfolder, you should add a line with the RewriteBase in your *.htaccess.*. It should look like the following (change the third line for your situation):

```
    RewriteEngine on  
    RewriteCond %{REQUEST_URI} !api/  
    RewriteBase /spotweb/
    RewriteRule api/?$ index.php?page=newznabapi [QSA]
    RewriteRule details/([^/]+) index.php?page=getspot&messageid=$1 [L]
```

If you made the installation with apt-get, the last line needs to look like this:

```
RewriteRule api/?$ /spotweb/index.php?page=newznabapi [QSA]  
RewriteRule details/([^/]+) /spotweb/index.php?page=getspot&messageid=$1 [L]  
```

If you already have a *.htaccess* file for other reasons, you can generally add the code at the top.

Then make the Apache server to load the RewriteEngine every server start: `sudo a2enmod rewrite && sudo /etc/init.d/apache2 restart`

Then check your data in your site that is enabled:

```
<Directory /var/www/spotweb/>
	Options FollowSymLinks
	AllowOverride All
	Order deny,allow
	Allow from all
	Satisfy all
</Directory>
```