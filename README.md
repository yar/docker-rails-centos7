# Rails environments with CentOS 7

This docker image is used for testing rails application.

It includes:

* rvm
* ruby >= 2.3
* bundler >= 1.11
* common tools for compiling gem native extension, like gcc, make
* mariadb-devel (required for using [mysql2](https://rubygems.org/gems/mysql2/) gem)
* node >= 6.0
* npm >= 3.8

## License

MIT
