It has a built-in task for Rake, so you include it in your Rakefile:

```ruby
{{include_into_rakefile}}
```

Then you create book folder inside your project folder, and create
two files there: `structure.md` and `view.rb`.

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

To understand how to write all this template things, just look into this repo's
book folder. I love eating my own dog food. In fact, I cook it for myself.

When you are ready, run it!

    $ rake readme
