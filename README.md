Gutenberg
=========

[![Gem version](https://badge.fury.io/rb/gutenberg.png)](http://rubygems.org/gems/gutenberg)
[![Dependency status](https://gemnasium.com/somu/gutenberg.png)](https://gemnasium.com/somu/gutenberg)
[![Code readability](https://codeclimate.com/github/somu/gutenberg.png)](https://codeclimate.com/github/somu/gutenberg)

**Gutenberg** dynamically compiles multiple templates into one README.

It generates a static README file from a bunch of [Mustache-powered](http://mustache.github.io) plain text
files combined together. It has a built-in library of mixins.
More on that later, now to basic features and how to get it working.

Everywhere
----------

You can use Gutenberg everywhere: your project doesn’t need to be written in Ruby.
Any language is OK, whether it is Python, PHP, or any other you prefer. If you’ve got
a Mac, you already have Ruby installed, so don’t even bother with it.

Get started
------------

Gutenberg is avaliable as a gem, working under Ruby 1.8...2.1:

    $ gem install gutenberg

Then you go to your project folder and say:

    $ gutenberg --init

It generates all the scaffolding: `book` folder, `context.yml` and `structure.md`.  
Now let's configure it for your project.

Context
-------

Context file is a file named `context`. It has `.json`, `.yml` or `.rb` extension.

Contexts contain variables — everything you need to write only once: your repo name, your project name,
pieces of code, et cetera. So, use it for everything that you want to store or to be dynamic.

Context is not required. You can delete your `context.yml` if you don’t need any variables.

Here are examples:

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

This one sets your repo to `"sword"` and user to `"somu"`. Those two variables are very
important in Gutenberg. They’re magical. After setting them, you can easily generate a header,
for example, using built-in `{{head}}` variable. This is what you’d get:

    Sword
    =====

It is a taste of what is called mixins. More on that later.


#### `context.rb`

Use `context.rb` if you need some advanced features, like putting your gem’s last version in a constant,  
putting your program’s help message inside of README, and so on. Get used to this DSL:

```ruby
Gutenberg.new do
  repo 'sword'
  user 'somu'
  version Gutenberg::VERSION
  lazy_ruby_version { RUBY_VERSION }
end
```

In fact, it is equivalent to this:

```ruby
Gutenberg.new do
  def user; 'somu' end
  def repo; 'gutenberg' end
  def version; 1.1.0 end
  def lazy_ruby_version; RUBY_VERSON end
end
```

This README itself uses this `context.rb`:

```ruby
Gutenberg.new do
  version Gutenberg::VERSION
  repo 'gutenberg'
  user 'somu'

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

Structure is the only obligatory file to have in Gutenberg.  
Structure is a file called `structure` in `book` folder with any extension.

Structure is hooked up first, it is the entry point and should be a barebone of your README.
For example, this very README's structure looks like this:

```md
{{header}}

{{gem_version}}
{{gemnasium}}
{{code_climate}}

{{introduction}}

{{everywhere}}

{{installation}}

{{on_context}}

{{on_structure}}

{{mixins}}

{{dog_food}}

{{rake}}

{{workarounds}}
```

As you see, `books/introduction.md` can be loaded just using Mustache's
`{{introduction}}` variable. So treat `structure.md` like you’d treat
a bookcover for your book pages.

And this is the default structure:

```md
{{header}}

{{gem_version}}
{{gemnasium}}
{{codeclimate}}

<!-- Your templates: -->
```

After you've setup books folder, start creating pages inside it. They will be
automatically hooked and put into corresponding variables with the same names: you can use
them in your `structure.md`.

Mixins
------

Full list of avaliable mixins:

#### Badges

+ `{{travis}}`
+ `{{gem_version}}`
+ `{{coveralls}}`
+ `{{gemnasium}}`
+ `{{codeclimate}}`

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
use Gutenberg. **Gutenberg rules.**

I love eating my own dog food. In fact, I cook it for myself. Barkety bark.

Rake integration
----------------

Gutenberg easily integrates with Rake. You include this portion of code in your Rakefile:

```ruby
require 'gutenberg/task'
Gutenberg::Task.new
```

And you’re pretty ready to use it! It adds two tasks:

```
rake readme      # Compile README.md
rake see_readme  # See README.md
```

Workarounds for non-Ruby projects
---------------------------------

Since Gutenberg can into JSON and YAML, you may generate a context automatically
using your own code so your version, your help information and these things are up-to-date.

Remember that `gutenberg` executable has a lot of options so you can fine-tune it for your needs:

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
