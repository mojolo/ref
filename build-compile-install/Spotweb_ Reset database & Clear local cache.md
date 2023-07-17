## Build/Populate your database

```
php /var/www/html/spotweb/retrieve.php
```



## Reset your database

You will be able to reset the DB, using the command

```
php /var/www/html/spotweb/bin/upgrade-db.php --reset-db
```

This will reset the following table's: spots, spotsfull, spotsposted, spotstatelist, commentsfull, commentsposted, commentsxover,  moderatedringbuffer, reportsposted, reportsxover, usenetstate, cache

Table's: users, usergroups, usersettings, sessions, settings, grouppermissions, security groups and filters are left intact.

Everything else get's truncated



## Clear your local cache

To clear your local cache use the following command:

```
php /var/www/html/spotweb/bin/upgrade-db.php --clear-cache
```

This will truncate the cache table and empty cache folder on-disk. This could save a lot of data.

Or pass `-yes` to auto confirm, this will bypass manual confirmation so clearing cache can be scheduled using cron.

`php upgrade-db.php --clear-cache -yes` Bypass the manual confirmation so clearing cache can be scheduled using cron. 



# Handy SQL Queries

> 2015

The purpose of this page is to keep a collection of SQL query's that  you could use to cleanup your database, as of now maintanance tab's  aren't yet implemented into spotweb which you could use to remove pr0n  or filter out spam.

### How do i run a query?

There are multiple way's one could run a query on a database.  normally i use phpMyAdmin and save all query's inside for easy access  later, feel free to add any comment if you have an easier way.

### phpMyAdmin

Login on phpMyAdmin, if you have followed the spotweb install guide  on the tweakers forum then probably you have a XAMPP server running, if  so phpMyAdmin is already pre-installed by default. follow the steps to  run a query into your database.

***WARNING, Do not execute every query without having a proper  backup!, if you run a bad query you could lose data in your database,  once removed, it's gone forever. incase of error, you might have to  start all over again so backing up before continuing is crucial! ***

1. Login to phpMyAdmin by typing http://localhost/phpmyadmin/ into your browser. it is possible that your spotweb installation is  installed on a server and/or phpMyAdmin is located on a different  location. for now we shall assume phpMyAdmin is located in your webroot.
2. On the left side you will notice a few (default) databases, if you  have been running spotweb for a while then you would find the spotweb  database in there, click on it to open the database.
3. At the top of the page you see "SQL", click on that, this is te page  where a SQL query can be run. by cpoy/pasting and clicking "Go" the  query will be executed.
4. By using "Bookmark this SQL query:" and filling in a name for the  query you could save the query for later and select it from a dropdown  menu which would appear in that TAB after saving.

### Remove pr0n

A check query:

```
SELECT title FROM spots 
WHERE category = '0' and subcatz = 'z3|';
```

Delete (after checking):

```
DELETE FROM spots, spotsfull, commentsxover, reportsxover, spotstatelist, reportsposted, cache USING spots
LEFT JOIN spotsfull ON spots.messageid=spotsfull.messageid
LEFT JOIN commentsxover ON spots.messageid=commentsxover.nntpref
LEFT JOIN reportsxover ON spots.messageid=reportsxover.nntpref
LEFT JOIN spotstatelist ON spots.messageid=spotstatelist.messageid
LEFT JOIN reportsposted ON spots.messageid=reportsposted.inreplyto
LEFT JOIN cache ON spots.messageid=cache.resourceid
WHERE category = '0' and subcatz = 'z3|';
```

### Remove genre

This query is a template to delete a certain genre from a category.  An example on how to remove the genre "Regelion" from category "Sound".  Notice "Where" clause in the "SELECT" and "DELETE" query is equall in  order to make the selection.

A check query:

```
SELECT title FROM spots
WHERE category = '1' and subcatd LIKE '%d17%';
```

Delete (after checking):

```
DELETE FROM spots, spotsfull, commentsxover, reportsxover, spotstatelist, reportsposted, cache USING spots
LEFT JOIN spotsfull ON spots.messageid=spotsfull.messageid
LEFT JOIN commentsxover ON spots.messageid=commentsxover.nntpref
LEFT JOIN reportsxover ON spots.messageid=reportsxover.nntpref
LEFT JOIN spotstatelist ON spots.messageid=spotstatelist.messageid
LEFT JOIN reportsposted ON spots.messageid=reportsposted.inreplyto
LEFT JOIN cache ON spots.messageid=cache.resourceid
WHERE category = '1' and subcatd LIKE '%d17%';
```

### Delete spam.

```
DELETE FROM spots, spotsfull, commentsxover, reportsxover, spotstatelist, reportsposted, cache USING spots
LEFT JOIN spotsfull ON spots.messageid=spotsfull.messageid
LEFT JOIN commentsxover ON spots.messageid=commentsxover.nntpref
LEFT JOIN reportsxover ON spots.messageid=reportsxover.nntpref
LEFT JOIN spotstatelist ON spots.messageid=spotstatelist.messageid
LEFT JOIN reportsposted ON spots.messageid=reportsposted.inreplyto
LEFT JOIN cache ON spots.messageid=cache.resourceid
WHERE MATCH (title) AGAINST ('xxxxxxx');
```

*Replace xxxxxx with a word like (FTDworld) this will delete all spots with that word.*

To delete spots with more than 5 spam reports:

```
DELETE FROM spots WHERE messageid IN (SELECT nntpref FROM reportsxover)
GROUP BY nntpref
HAVING ( COUNT(nntpref) > 5 );
```

Since the above does not seem to work any longer i'm using this to remove spots with 5 or higher reports: You could change the number to anything you like and put this in a cronjob to automatically remove spots that have 5+ reports.

```
DELETE FROM spots WHERE reportcount >= 5;
```

### Delete spots from poster that are on the external blacklist.

```
DELETE FROM spots, spotsfull, commentsxover, reportsxover, spotstatelist, reportsposted, cache USING spots
LEFT JOIN spotsfull ON spots.messageid=spotsfull.messageid
LEFT JOIN commentsxover ON spots.messageid=commentsxover.nntpref
LEFT JOIN reportsxover ON spots.messageid=reportsxover.nntpref
LEFT JOIN spotstatelist ON spots.messageid=spotstatelist.messageid
LEFT JOIN reportsposted ON spots.messageid=reportsposted.inreplyto
LEFT JOIN cache ON spots.messageid=cache.resourceid
WHERE spots.spotterid IN (SELECT spotterid FROM spotteridblacklist WHERE ouruserid = -1 AND origin = 'external');
```

### Remove spots from specific poster

```
DELETE FROM spots, spotsfull, commentsxover, reportsxover, spotstatelist, reportsposted, cache USING spots
LEFT JOIN spotsfull ON spots.messageid=spotsfull.messageid
LEFT JOIN commentsxover ON spots.messageid=commentsxover.nntpref
LEFT JOIN reportsxover ON spots.messageid=reportsxover.nntpref
LEFT JOIN spotstatelist ON spots.messageid=spotstatelist.messageid
LEFT JOIN reportsposted ON spots.messageid=reportsposted.inreplyto
LEFT JOIN cache ON spots.messageid=cache.resourceid
WHERE MATCH (poster) AGAINST ('xxxxxxx');
```

*Replace xxxxxx with the name of the poster from which you would like to remove spots*

### Optimize database, to save diskspace.

```
OPTIMIZE TABLE `commentsxover` , `spotsstatelist` , `nntp` , `spots` , `spotsfull`;
```

### Remove comments from non-existing spots. BE AWARE: Can potentionally remove comments from not retrieved spots.

```
DELETE commentsxover FROM commentsxover
LEFT JOIN spots ON commentsxover.nntpref=spots.messageid
WHERE spots.messageid IS NULL;
```

### Finding inactive users.

Excludes users who have posted spots, reports or spam reports.

```
SELECT *
FROM users u
LEFT JOIN commentsposted cp ON cp.ouruserid = u.id
LEFT JOIN spotsposted sp ON sp.ouruserid = u.id
LEFT JOIN reportsposted rp ON rp.ouruserid = u.id
WHERE
    u.lastvisit < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 60 DAY)) AND
    cp.ouruserid IS NULL AND
    sp.ouruserid IS NULL AND
    rp.ouruserid IS NULL AND
    u.id NOT IN(1, 2);
```

### Deleting inactive users.

Excludes users who have posted spots, reports or spam reports.

```
DELETE u.*, cp.*, sp.*, rp.*
FROM users u
LEFT JOIN commentsposted cp ON cp.ouruserid = u.id
LEFT JOIN spotsposted sp ON sp.ouruserid = u.id
LEFT JOIN reportsposted rp ON rp.ouruserid = u.id
WHERE
    u.lastvisit < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 60 DAY)) AND
    cp.ouruserid IS NULL AND
    sp.ouruserid IS NULL AND
    rp.ouruserid IS NULL AND
    u.id NOT IN(1, 2);
```