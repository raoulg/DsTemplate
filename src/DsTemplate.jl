module DsTemplate

include("Templates.jl")

using .Templates

include("Setup.jl")
using .Setup

export initialize_project

end
