create user everything_app identified by 'password';
create user everything_identity identified by 'password';
create database everything_identity;
grant all on everything_identity.* to everything_identity@'%';
use everything_identity;
CREATE TABLE __EFMigrationsHistory ( MigrationId nvarchar(150) NOT NULL, ProductVersion nvarchar(32) NOT NULL, PRIMARY KEY (MigrationId) );
create database everything_app;
use everything_app;
CREATE TABLE __EFMigrationsHistory ( MigrationId nvarchar(150) NOT NULL, ProductVersion nvarchar(32) NOT NULL, PRIMARY KEY (MigrationId) );
grant all on everything_app.* to everything_app@'%';
