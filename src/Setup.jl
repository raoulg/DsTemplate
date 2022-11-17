module Setup

using LibGit2

using ..Templates
export initialize_project


function check_path(path)
    rd = readdir(path)
    if length(rd) != 0
        error("Path $(path) is not empty, found $(rd)")
    end
end

function make_folders(path, template)
    @info "Creating folders from template"
    folders = String[]
    for p in template
        add_folder!(path, p, folders)
    end
end

function add_folder!(path, p::String, folders)
    folder = joinpath(path, p)
    mkpath(folder)
    push!(folders, folder)
    touch(joinpath(folder, ".gitkeep"))
end

function add_folder!(path, p::Pair{String, <:Any}, folders)
    path = joinpath(path, p[1])
    for child in p[2]
        add_folder!(path, child, folders)
    end
end

"""
Adds all files in a repo, and commits them with msg
"""
function git_add_commit(repo, msg)
        LibGit2.add!(repo, ".")
        sig = LibGit2.Signature("DsTemplate", "no@email.com", round(Int, time()), 0)
        LibGit2.commit(repo, msg; author=sig, committer=sig)
end

function flatten_temp(template, flat = String[])
    if isempty(flat)
        flat = String[]
    end
    for t in template
        if typeof(t) <: String
            push!(flat, t)
        end
        if typeof(t) <: Pair
            push!(flat, t[1])
            # flatten_temp(t[2], flat)
        end
    end
    return flat
end

"""
```julia
initialize_project(path;
                   git=true, 
                   template=DEFAULT_TEMPLATE,
                   name="",
                   lang="julia",
                   report="tex",
                   force=false)
``` 

path (String)   eg "MyProject" will make a folder "MyProject" and initialize all other subfolders there.

git (bool)      default true. If the folder should be initialized as a git folder 

name (String)   defaults to the name of the path. Used when creating a main julia module with an uppercased first letter

lang (String)   default "julia". Can be "python" too.

report (String) default "tex". Will create a latex file plus bibliography. can also be "qmd" for quarto reports.
    
"""
function initialize_project(path; 
                            git=true, 
                            template=DEFAULT_TEMPLATE,
                            name="",
                            lang="julia",
                            report="tex",
                            force=false)
    mkpath(path)
    if !force
        check_path(path)
    end
    @info "Created $(path)"

    if isempty(name)
        name = split(path, "/")[end]
    end
    

    make_folders(path, template)

    if git
        repo = LibGit2.init(path)
        git_add_commit(repo, "template folders")
    end

    write(joinpath(path, "README.md"), README_TEMPLATE)

    if "reports" ∈ template
        touch(joinpath(path, "reports", "report.qmd"))
    end

    if "reports" ∈ template
        touch(joinpath(path, "reports", "report.qmd"))
    end

    if lang == "julia"
        add_julia_files(path, template, name)
    end

    if report == "tex"

        write(joinpath(path, "reports", "report.tex"), latex_template())
        write(joinpath(path, "reports", "ref.bib"), BIBTEX)
    else
        write(joinpath(path, "reports", "report.qmd"), QMD)
    end


end

function add_julia_files(path, template, name)
    folders = flatten_temp(template) # returns first level of folders
    if "src" ∈ folders
        write(joinpath(path, "src", uppercasefirst(name) * ".jl"), julia_main(name))
    end
end


function add_python_files(path, template, name)
    folders = flatten_temp(template) # returns first level of folders
    if "src" ∈ folders
        touch(joinpath(path, "src", "main.py"))
        touch(joinpath(path,  "settings.py"))
    end
end

end
