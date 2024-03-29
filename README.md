# DsTemplate
This is a small julia package that creates a template for data science projects.
It is inspired by https://drivendata.github.io/cookiecutter-data-science/ but stripped down to my own preferences.
It will create a directory framework like this:
```
├── README.md       <- this file
├── data            <- store your data here
│   ├── final         <- results
│   ├── processed     <- preprocessed data
│   ├── raw           <- raw, initial data
│   └── sim           <- simulated data
├── dev             <- used during development
│   ├── notebooks     <- jupyter / pluto notebooks
│   └── scripts       <- demo scripts
├── docs            <- documentation
├── references      <- other research papers
├── reports         <- your report, presentation, etc
│   ├── img           <- image folder for report
│   └── report.qmd    <- empty reportfile. You can use .qmd or .tex
└── src
 ```

Copy-pasting the motivation for this from cookiecutter:
>A well-defined, standard project structure means that a newcomer can begin to understand an analysis without digging in to extensive documentation. It also means that they don't necessarily have to read 100% of the code before knowing where to look for very specific things.
>Well organized code tends to be self-documenting in that the organization itself provides context for your code without much overhead. People will thank you for this because they can:
> (1) Collaborate more easily with you on this analysis (2) Learn from your analysis about the process and the domain. (3) Feel confident in the conclusions at which the analysis arrives

## Installation

Install it in your julia environment by starting up a julia repl and doing:

`]add https://github.com/raoulg/DsTemplate/`

This will install it in your general environment. 

## Usage:

```julia
using DsTemplate
initialize_project("myproject") 
# this will create a "myproject" folder with the structure.
```

Full options:
```julia
initialize_project(path;
                   git=true, 
                   template=DEFAULT_TEMPLATE,
                   name="",
                   lang="julia",
                   report="tex",
                   force=false)
``` 

- path (String)   eg "MyProject" will make a folder "MyProject" and initialize all other subfolders there.
- git (bool)      default true. If the folder should be initialized as a git folder 
- name (String)   defaults to the name of the path. Used when creating a main julia module with an uppercased first letter
- lang (String)   default "julia". Can be "python" too.
- report (String) default "tex". Will create a latex file plus bibliography. can also be "qmd" for quarto reports.

You can get this by doing `?initialize_project`

## dependencies
For documentation, you can use
- [documenter.jl](https://documenter.juliadocs.org/stable/) for julia
- [sphinx](https://www.sphinx-doc.org/en/master/) for python

For the report, you can either use
- [Quarto](https://quarto.org/) which is relative easy
- [latex](https://www.latex-project.org/get/) which is much more complex but gives better typesetting for more professional looking reports.
