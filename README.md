# jiwiki-rails

## up and running

```
$ # install ruby, bundler gem, postgresql, pgroonga
$ bundle install --path vendor/bundle
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec ridgepole -E <environment> -c config/database.yml --apply
$ bundle exec rails server
```

## about schema

database's schema is managed by `ridgepole`. However, use just a migration file to enable pgroonga extension.
