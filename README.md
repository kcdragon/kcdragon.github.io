# Setup
```
bundle install
bundle exec jekyll serve --watch
```

## Mac OSX troubleshooting

[bundle install Event Machine error](http://mikebian.co/fixing-bundler-issues-after-a-macos-sierra-upgrade/)

```
brew reinstall openssl
gem install eventmachine -v '1.0.4' -- --with-cppflags=-I/usr/local/opt/openssl/include
bundle install
```

# Deploy with Heroku
```
# http://andycroll.com/ruby/serving-a-jekyll-blog-using-heroku/

# Install Heroku Toolbelt - https://devcenter.heroku.com/articles/heroku-command-line#download-and-install

## Ubuntu
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

## Mac OSX
brew install heroku

# Log in to Heroku locally
heroku login # enter email and password

# Add heroku remote
git remote add heroku https://git.heroku.com/mikedalton-co.git

# Deploy!
git push heroku master
```
