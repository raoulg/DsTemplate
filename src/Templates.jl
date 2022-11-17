module Templates

export DEFAULT_TEMPLATE, README_TEMPLATE, BIBTEX, QMD
export julia_main, latex_template

const DEFAULT_TEMPLATE = [
                          "src",
                          "dev" => ["scripts", "notebooks"],
                          "data" => ["raw", "processed", "sim", "final"],
                          "docs",
                          "references",
                          "reports" => ["img"],
                         ]


function julia_main(name)
    
    """
    module $(uppercasefirst(name))

    end
    """
end



const README_TEMPLATE =  """
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

    For documentation, you can use
    - [documenter.jl](https://documenter.juliadocs.org/stable/) for julia
    - [sphinx](https://www.sphinx-doc.org/en/master/) for python

    For the report, you can either use
    - [Quarto](https://quarto.org/) which is relative easy
    - [latex](https://www.latex-project.org/get/) which is much more complex but gives better typesetting for more professional looking reports.

    """

function latex_template(title="Title"; 
                        author="Last, First",
                        email="name@email.com",
                       )
"""
\\documentclass[10pt]{article}
\\usepackage{hyperref}
\\usepackage{amssymb}
\\usepackage{amsmath}
\\usepackage{mathrsfs}

\\usepackage[shortlabels, inline]{enumitem}

\\title{$title}
\\author{$author , $email}
\\date{\\today}

\\begin{document}
\\maketitle
\\section{Section}
\\begin{enumerate}
\\item \$\\mathbb{N}\$ is the collection of natural numbers: 1, 2, 3, etc.
\\item \$\\mathbb{R}\$ is the collection of real numbers: -2.53, 0.1, 1.3, etc.
\\item \$\\in\$ means: "is part of". \$x \\in \\mathbb{R}\$ means \$x\$ is part of the collection of real numbers.
\\end{enumerate}


\\subsection{Subsection}
a formula 
\\begin{equation}
y = WX + b
\\end{equation}

A citation \\cite{attention2017} from the bibliography.bib file.


\\bibliographystyle{plain}
\\bibliography{ref.bib}
\\end{document}

"""
end

const BIBTEX = """
@article{attention2017,
  title={Attention is all you need},
  author={Vaswani, Ashish and Shazeer, Noam and Parmar, Niki and Uszkoreit, Jakob and Jones, Llion and Gomez, Aidan N and Kaiser, Lukasz and Polosukhin, Illia},
  journal={Advances in neural information processing systems},
  volume={30},
  year={2017}
}
"""

const QMD = """
---
title: "Title"
author: "Author"
format:
  pdf:
    toc: true
  revealjs:
    theme: solarized
    slide-number: true
    self-contained: true
---

# Section
an image
![](img/example.png)
	
## Subsection

- \$\\mathbb{N}\$ is the collection of natural numbers: 1, 2, 3, etc.
- \$\\mathbb{R}\$ is the collection of real numbers: -2.53, 0.1, 1.3, etc.
- \$\\in\$ means: "is part of". \$x \\in \\mathbb{R}\$ means \$x\$ is part of the collection of real numbers.

"""

end
