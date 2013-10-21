Gutenberg
=========

[![Gem version](https://badge.fury.io/rb/gutenberg.png)](http://rubygems.org/gems/gutenberg)
[![Dependency status](https://gemnasium.com/somu/gutenberg.png)](https://gemnasium.com/somu/gutenberg)
[![Code readability](https://codeclimate.com/github/somu/gutenberg.png)](https://codeclimate.com/github/somu/gutenberg)

**Gutenberg** dynamically compiles multiple templates into one README.

It generates a static `README` for your GitHub repository from a bunch of [Mustache-powered](http://mustache.github.io)
plain-text files. It has a built-in library of mixins.
More on mixins later, but now let’s start with the basic features and how to get it working.

What for
--------

With Gutenberg you can divide your `README` into smaller parts to make it easier to read and maintain.
You can take your code constants (the version number, for instance) and inject them right into your `README`, so that you don’t have to manually change the text after each release.

You can unleash your metaprogramming skills in `README`. You can even build a `README` for your piece of code that writes itself automatically.

It is just the same as using SASS with CSS.

Getting started
---------------

Gutenberg is avaliable as a gem, working under Ruby 1.8...2.1:

    $ gem install gutenberg

You can use Gutenberg in a project written in any language, not only
Ruby. You must have Ruby installed, though. If you’re
on Mac, you already have it built in. Otherwise, see [install Ruby](https://www.ruby-lang.org/en/downloads/).

Then go to your project folder and type:

    $ gutenberg --init

It generates all the scaffolding: the `book` folder, `context.yml`, and `structure.md`.  
То generate `README.md` type:

    $ gutenberg

You can get the list of available options using the `-h` flag:

    $ gutenberg -h

Now let’s configure it for your project.

Context
-------

Context file is a file named `context`. It has a `.json`, `.yml`, or `.rb` extension.

Contexts contain variables — everything you need to write only once: your repo name, your project name,
pieces of code, etc. Use it for everything you want to store and for everything you want to be dynamic.

Context is not required. You can delete your `context.yml` if you don’t need any variables.

Here are some examples:

#### `context.yml`

```yaml
version: 4.0.0
user: rails
repo: rails

mvc: "[MVC](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)"
mit: "[MIT](http://www.opensource.org/licenses/MIT)"
```

#### `context.json`

```json
{
  "user": "somu",
  "repo": "sword",
  "contributors": "Josh Kauffman and Jackson Gariety"
}
```

This one sets your repo to `"sword"` and user to `"somu"`. These two variables are magical in Gutenberg.
After they are set, you can easily generate a header, for example, using the built-in `{{head}}` variable.
This is what you’ll get:

    Sword
    =====

It is a taste of what is called mixins. More on that later.


#### `context.rb`

Use `context.rb` if you need some advanced features, like putting your gem’s last version into a constant,  
putting your program’s help message inside README, and so on. Get used to this DSL:

```ruby
Gutenberg.new do
  repo 'sword'
  user 'somu'
  version Gutenberg::VERSION
  lazy_ruby_version { RUBY_VERSION }
end
```

In fact, it is equivalent to:

```ruby
Gutenberg.new do
  def user; 'somu' end
  def repo; 'gutenberg' end
  def version; 1.1.2 end
  def lazy_ruby_version; RUBY_VERSON end
end
```

This README itself uses this `context.rb`:

```ruby
Gutenberg.new do
  version Gutenberg::VERSION
  repo 'gutenberg'
  user 'somu'

  mixins_template   { read 'examples/mixins_example.md' }
  default_structure { read 'lib/structure.md'   }
  self_structure    { read 'book/structure.md'  }
  self_context      { read 'book/context.rb'    }

  describe_mixins do
    meths = Hash.new
    Dir['lib/gutenberg/mixins/*.rb'].each do |f|
      name = nil
      file = File.read(f)
      file.gsub(/module (\w+)\n/) { name = $1 }
      meths[name] = Array.new
      file.gsub(/def (\w+)\n/) { meths[name] << $1 }
    end
    output = ''
    meths.each do |n,ms|
      next if ms.empty?
      output << "#### #{n}\n\n"
      ms.each { |m| output << "+ `{{#{m}}}`\n"}
      output << "\n"
    end
    output
  end

  options `./bin/gutenberg -h`.chomp
  rake_tasks `rake -f examples/Rakefile -T`.chomp

  mustache_introduction '`{{introduction}}`'
  mustache_header       '`{{head}}`'

  load 'examples/*'
end
```

Structure
---------

Structure is the only obligatory file in Gutenberg.  
Structure is a file called `structure` in the `book` folder with any extension.

Structure extension desides what extension to use for `README`. So,
if you have a `structure.md` the generated file will be `README.md`. If it is
`structure.txt` Gutenberg will generate `README.txt`.

Structure is hooked up first, it is the entry point and should be the skeleton of your README.
For example, this very README’s structure looks like this:

```md
{{header}}

{{gem_version}}
{{gemnasium}}
{{code_climate}}

{{introduction}}

{{what_for}}

{{get_started}}

{{on_context}}

{{on_structure}}

{{mixins}}

{{dog_food}}

{{rake}}

{{workarounds}}
```

As you see, `books/introduction.md` can be loaded just using Mustache’s
`{{introduction}}` variable. So treat `structure.md` like you’d treat
a TOC for your book.

This is the default structure:

```md
{{header}}

{{gem_version}}
{{gemnasium}}
{{codeclimate}}

<!-- Your templates: -->
```

After you’ve setup the books folder, start creating pages inside it. They will be
automatically hooked and put into corresponding variables with the same names. You can use
them in your `structure.md`.

Mixins
------

You can define mixins just by defining a method which lazily takes
a variable and does something with it:

```ruby
Gutenberg.new do
  user 'somu'

  def name_caps
    user.upcase
  end

  def profile
    "https://github.com/#{user}"
  end
end
```

Then you can use it in your templates:

```
# {{name_caps}}

[Check my GitHub profile]({{profile}})
```

Full list of avaliable built-in mixins:

#### Badges

+ `{{travis}}`
+ `{{gem_version}}`
+ `{{coveralls}}`
+ `{{gemnasium}}`
+ `{{codeclimate}}`
+ `{{gittip}}`

#### Links

+ `{{documentation}}`
+ `{{rubygems}}`
+ `{{header}}`
+ `{{semver}}`
+ `{{repo_url}}`



Eating my own dog food
----------------------

Gutenberg loves using Gutenberg. Take a look at the [`book` folder](https://github.com/somu/gutenberg/tree/master//book) in this repo,
you will see a good example of Gutenberg usage, just how Gutenberg authors
use Gutenberg.

I love eating my own dog food. In fact, I cook it for myself. Barkety bark.

Rake integration
----------------

Gutenberg easily integrates with Rake. Just include this portion of code in your Rakefile:

```ruby
require 'gutenberg/task'
Gutenberg::Task.new
```

and you’re pretty ready to use it! It adds two tasks:

```
rake readme      # Compile README
rake see_readme  # Preview README
```

Workarounds for non-Ruby projects
---------------------------------

Since Gutenberg can use JSON and YAML, you may generate a context automatically
using your own code. Your version number, help information, etc. will be up-to-date.

Remember that `gutenberg` executable has a lot of options, so you can fine-tune it for your needs:

```
Usage: gutenberg [options]
    -c, --context <path>             Specify context file
    -d, --directory <path>           Specify documentation directory
    -f, --file <path>                Change resulting file name, README.md by default
    -h, --help                       Prints this message out
    -i, --init                       Initialize a project
        --no-mixins                  Do not include mixins
    -p, --pattern <pattern>          Specify including file matching pattern
    -s, --structure <pattern>        Specify structure pattern
    -v, --version                    Prints Gutenberg version
```
