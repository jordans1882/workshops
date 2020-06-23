if(file.exists("~/.Rprofile")){
  source("~/.Rprofile")
}

new_draft <- function(draftname = "new_draft") {
  destination_folder <- paste("_drafts/", draftname, sep = "")
  dir.create(destination_folder)
  template_location <- "assets/template/"
  template_files <- list.files(template_location)
  for(i in template_files) {
    file.copy(paste(template_location, i, sep = ""), destination_folder)
  }
}

gen_workshops <- function(
    input = c(".", list.dirs("_source")),
    output = c(".", rep("rmd_workshops/_posts", length(list.dirs("_source")))),
    command = "bundle exec jekyll build", ...) {
      dir.create(file.path("rmd_workshops"), showWarnings = FALSE)
      dir.create(file.path("rmd_workshops", "_posts"), showWarnings = FALSE)
      servr::jekyll(input = input, output = output, serve = FALSE,
                    command = command, ...)
}

serve_site <- function (
    input = c(".", list.dirs("_source")),
    output = c(".", rep("rmd_workshops/_posts", length(list.dirs("_source")))),
    command = "bundle exec jekyll build", ...) {
      dir.create(file.path("rmd_workshops"), showWarnings = FALSE)
      dir.create(file.path("rmd_workshops", "_posts"), showWarnings = FALSE)
      servr::jekyll(input = input, output = output, serve = TRUE,
                    command = command, script = "build.R", ...)
}

gen_drafts <- function(
    input = c(".", list.dirs("_drafts")),
    output = c(".", rep("rmd_drafts/_posts", length(list.dirs("_drafts")))),
    command = "bundle exec jekyll build", ...) {
      dir.create(file.path("rmd_drafts"), showWarnings = FALSE)
      dir.create(file.path("rmd_drafts", "_posts"), showWarnings = FALSE)
      servr::jekyll(input = input, output = output, serve = FALSE,
                    command = command, ...)
}

clean_website <- function() {
  unlink("_site", recursive=TRUE)
}

clean_drafts <- function() {
  files <- list.files("rmd_drafts/_posts/")
  files <- files[grep("md", files)]
  if(length(files)>1) {
    file.remove(paste("rmd_drafts/_posts/", files, sep = ""))
  }
}

clean_workshops <- function() {
  files <- list.files("rmd_workshops/_posts/")
  files <- files[grep("md", files)]
  if(length(files) > 1) {
    file.remove(paste("rmd_workshops/_posts/", files, sep = ""))
  }
}

use_package <- function(p) {
  if (!is.element(as.character(p), utils::installed.packages()[, 1]))
    utils::install.packages(p, dep = TRUE)
library(p, character.only = TRUE)
}

r <- getOption("repos")
r["CRAN"] <- "http://cran.wustl.edu/"
options(repos = r)
rm(r)

#use_package('TDA')
#use_package('servr')
