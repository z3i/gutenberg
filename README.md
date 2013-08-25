Gutenberg
=========

[![Gem version](https://badge.fury.io/rb/gutenberg.png)](http://rubygems.org/gems/gutenberg)  
[![Dependency status](https://gemnasium.com/somu/gutenberg.png)](https://gemnasium.com/somu/gutenberg)  
[![Code readability](https://codeclimate.com/github/somu/gutenberg.png)](https://codeclimate.com/github/somu/gutenberg)

**Gutenberg** is a README.md lifesaver when you are writing it large.

It uses [semantic versioning](http://semver.org) and [Mustache](http://mustache.github.io),
both are cool and I appreciate their usage.

It generates static readme file from Mustache-powered markdown files,
which link automatically. It has a built-in library of mixins, which
you can port into your `view.rb` via including `Gutenberg::Mixins`
module. More on that later, now basic features and how to get it working.

Gutenberg is avaliable as a gem, working under Ruby 1.8...2.0:

    $ gem install gutenberg

So, I suppose you've installed it all right. Now let's continue
with configuring it in your project.

It has a built-in task for Rake, so you include it in your Rakefile:

```ruby
require 'gutenberg/task'
Gutenberg::Task.new
```

Then create book folder inside your project folder, and create
two files there: `structure.md` and `view.rb`.

Structure is hooked up first and should be a barebone of your README.
For example, this repo README's structure looks like this:

```md
{{header}}

{{gem_version}}  
{{gemnasium}}  
{{code_climate}}

{{introduction}}

{{installation}}

{{usage}}
```

As you see, `books/introduction.md` can be loaded just using Mustache's
`{{introduction}}` variable. So treat `structure.md` as a bookcover for
your book pages (I won't ever call it `bookcover.md`, I swear).

View is required for writing all the variables inside it. If you want to include
a mixin for Gutenberg, do it there. Your repo, your name — write there.
Everything you want to be stored in variable or be dynamic. Example:

```ruby
require 'gutenberg/mixins'

class View < Gutenberg::View
  def repo; 'sword' end
  def user; 'somu'  end

  include Gutenberg::Mixins
end
```

This one includes all built-in Gutenberg mixins and sets your repo to 'sword'
and user to 'somu'. Those two variables are very important in Gutenberg. After
setting them, you can easily generate a header, for example, using built-in
`{{head}}` variable, so in that case you'd receive something like this
for your `{{head}}`:

    Sword
    =====

After you've setup books folder, start creating pages inside it. They will be
automatically hooked and put into a variable with the same name: you can use
them in your `structure.md`.

To understand how to write all this template things, just look into this repo's
book folder. I love eating my own dog food. In fact, I cook it for myself.
Barkety bark.

When you are ready, run it!

    $ rake readme
