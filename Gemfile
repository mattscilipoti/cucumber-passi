source "http://rubygems.org"

# Specify your gem's dependencies in cucumber-passo.gemspec
gemspec

group :development, :test do
  gem 'awesome_print'
  gem 'ruby-debug19', :platforms => :mri_19, :require => 'ruby-debug'
    # as of 02/12 must name rubydebug-19 dependencies
    # install w/
    #     $ bash < <(curl -L https://raw.github.com/gist/1333785)
    gem 'linecache19', '>= 0.5.11', :platforms => :mri_19
    gem 'ruby-debug-base19', '>= 0.11.19', :platforms => :mri_19

end
