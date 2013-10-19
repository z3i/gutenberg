Structure
---------

Structure is the only obligatory file to have in Gutenberg.  
Structure is a file called `structure` in `book` folder with any extension.

Structure is hooked up first and should be a barebone of your README.
For example, this very README's structure looks like this:

```md
{{self_structure}}
```

As you see, `books/introduction.md` can be loaded just using Mustache's
{{mustache_introduction}} variable. So treat `structure.md` like you’d treat
a bookcover for your book pages.

And this is the default structure:

```md
{{default_structure}}
```

After you've setup books folder, start creating pages inside it. They will be
automatically hooked and put into a variable with the same name: you can use
them in your `structure.md`.
