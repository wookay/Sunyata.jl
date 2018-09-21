# FIXME: it couldn't to import deepspeech using PyCall with precompile
__precompile__(false)

module Sunyata

export DeepSpeech
include("DeepSpeech.jl")

end # module Sunyata
