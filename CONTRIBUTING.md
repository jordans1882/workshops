# Dependencies

This website is built using [Rmarkdown](https://rmarkdown.rstudio.com/)
documents for development of the workshops and [Jekyll](https://jekyllrb.com/)
for building and serving the website. As a dependency for building the website,
you will need:

 - [Git](https://git-scm.com/)
 - [Ruby](https://www.ruby-lang.org/en/)
 - [RubyGems](https://rubygems.org/)
 - [R](https://cran.r-project.org/)
 - [Jekyll](https://jekyllrb.com/)
 - [Bundler](https://bundler.io/)

Follow the instructions for your system on each of these sites to obtain the
first four dependencies. The last two are ruby gems and can be obtained by
running the commands

```bash
gem install bundler
gem install jekyll
```

in your terminal or command prompt.

Once you have each of these, you will need to make sure your `PATH` environment
variable is set so that it can find your ruby gems . This may have been done
automatically when you installed RubyGems, but double check via the method for
your operating system. On Linux or MacOS you can run `echo $PATH` in your
terminal to check what is in your path or put something like
`PATH='$PATH:/path/to/your/ruby/gems'` in your `.bashrc` file if you need to
ammend your `PATH` environment variable with the location of your ruby gems.

Whereas on windows you can follow the instructions [here](https://www.computerhope.com/issues/ch000549.htm).

You will also need to make sure that when R is loaded it also has access to this
`PATH` environment variable. Sometimes it might use a `PATH` associated to a
different shell, so it's important to double check this if you run into any
errors that says R can't find bundle or jekyll. You can double check what R
thinks your path environment variable is by running:

```r
Sys.getenv("PATH")
```

If you don't have your ruby gems folder set in your `PATH` environment variable
in R, find and copy your system `PATH` environment variable and in the
`.Rprofile` file in your **home** directory, put the following line of code:

```r
Sys.setenv(PATH = "your full PATH variable here")
```

The `.Rprofile` file in the project root will source this file. However, before
copying this path environment, double check that the ruby gems are currently in
your path by running

```bash
bundle install
bundle exec jekyll build
```

in the root directory of the project. If you don't get an error and bundle
installs the ruby gems and then runs jekyll build, it means that the location of
your ruby gems is indeed set in your PATH environment variable.

# Development

A number of helper functions for building and serving the website are loaded via
the `.Rprofile` file located in the project root directory. Use the
`new_draft()` function to create a skeleton of a workshop:

```r
new_draft("my_workshop_name.r")
```

This will create a folder named `my_workshop_name` with a skeleton of a workshop
in the `_drafts` folder.  Now, you can edit this file to make the workshop. But
before editing the file, make sure that you can build and serve the drafts.
First run

```r
gen_drafts()
```

and then run

```r
serve_site()
```

You should now either see the site in the lower right-hand pane of RStudio if
you are using that as an IDE or if you just running the commands in R console
you can copy the link that is output in the console into your browser to see the
updated site.

Take a look at the two examples in the drafts folder for examples of how to do
do certain things. Note that there is a `references.bib` file in the
bibliography folder of `_bibliography` folder that you can include .bib
references in and examples exist for how to reference them in the example
drafts.

When you are ready to post the workshop, you can move the folder from the
`_drafts` folder into the `_source` folder. When you commit and push, travis.ci
should automatically build the .Rmd file, run jekyll build in a temporary
directory and push the results to the gh-pages branch so that the workshops are
live on the [https://comptag.github.io/t4ds](site).

A couple of general notes:
 - If you use an external package, make sure to add it to as an import in the
   DESCRIPTION file, otherwise travis.ci will not have access to the (unless
   perhaps you are using the `use_package()` function defined in .Rprofile which
   automatically installs the package if it doesn't exist).
- Do not manually edit the gh-pages repo, travis.ci should be the only thing
  that pushes to this repo.
- If it doesn't appear that your push to the master branch is being updated to
  the website, double check that the build badge is passing on the README page
  in github. If the build is failing, ask Jordan to look into it to see what the
  error is.

