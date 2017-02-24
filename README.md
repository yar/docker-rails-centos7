# Rails environments with CentOS 7

This docker image is used for testing rails application.

It includes:

* ruby >= 2.3
* bundler >= 1.14
* common packages required for compiling ruby and gem native extension, like gcc, make
* mariadb-devel (required for using [mysql2](https://rubygems.org/gems/mysql2/) gem)
* postgresql-libs postgresql-devel (required for [pg](https://rubygems.org/gems/pg/) gem)
* node 6.x with npm

## License

MIT
