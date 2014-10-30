### File generated automatically by ServerGrove Control Panel. Do not edit manually as changes will be overwritten.
### If you need to enter custom directives do it below between the lines defined specially for this.
### If you want to avoid ServerGrove Control Panel writing to this file, change the following setting to 0 or remove the line completely.
### sgcontrol.enabled=1


<VirtualHost *:80>
	CustomLog /var/www/vhosts/favanon.com/logs/favanon.com-access_log combined
	DocumentRoot /var/www/vhosts/favanon.com/httpdocs
	ServerName favanon.com
	ServerAlias www.favanon.com

### sgcontrol.custom.config.start

### sgcontrol.custom.config.end
</VirtualHost>

