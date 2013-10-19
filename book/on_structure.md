Structure
---------

Structure is the only obligatory file in Gutenberg.  
Structure is a file called `structure` in `book` folder with any extension.

Structure extension desides what extension to use for `README`. So,
if you have a `structure.md`, the generated file will be `README.md`. If it is
`structure.txt`, {{name}} will generate `README.txt`.

Structure is hooked up first, it is the entry point and should be a barebone of your README.
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
automatically hooked and put into corresponding variables with the same names: you can use
them in your `structure.md`.
