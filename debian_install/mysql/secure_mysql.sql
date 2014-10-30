DELETE FROM user WHERE User = 'debian-sys-maint';
DELETE FROM user WHERE Host != 'localhost' AND User = 'root';
UPDATE user SET User = 'dbadmin' WHERE User = 'root';
FLUSH PRIVILEGES;
