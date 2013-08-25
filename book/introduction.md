**{{name}}** is a README.md lifesaver when you are writing it large.

It uses {{semver}} and [Mustache](http://mustache.github.io), both
are cool and I appreciate their usage.

It generates static readme file from Mustache-powered markdown files,
which link automatically. It has a built-in library of mixins, which
you can port into your view.rb via including `Gutenberg::Mixins` module.
More on that later, now basic features and how get it working.

It has a built-in task for Rake, so you include it in your Rakefile:

```ruby
{{include_into_rakefile}}
```

Then you create book folder inside your gem, and create two files
there: `structure.md` and `view.rb`.

Structure is hooked up first and should be a barebone of your README.
For example, this repo README's structure looks like this:

```md
{{structure}}
```

As you see, `books/introduction.md` can be loaded just using Mustache's
{{introduction_variable}} variable. So treat `structure.md` as a bookcover for
your book pages (I won't ever call it `bookcover.md`, I swear).

View is required for writing all the variables inside it. If you want to include
a mixin for Gutenberg, do it there. Your repo, your name — write there.
Everything you want to be stored in variable or be dynamic. Example:

```ruby
{{view}}
```

This one includes all built-in Gutenberg mixins and sets your repo to 'sword'
and user to 'somu'. Those two variables are very important in Gutenberg. After
setting them, you can easily generate a header, for example, using built-in
{{header_variable}} variable, so in that case you'd receive something like this
for your {{header_variable}}:

    Sword
    =====

After you've setup books folder, start creating pages inside it. They will be
automatically hooked and put into a variable with the same name: you can use
them in your `structure.md`.
