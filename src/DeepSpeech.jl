# FIXME: it couldn't to import deepspeech using PyCall with precompile
__precompile__(false)
module DeepSpeech # Sunyata

include("DeepSpeech/client.jl")
using Phonetics # code_similarity

"""
    DeepSpeech.similarity(ds::PyCall.PyObject, samples, groundtruth::String)
"""
function similarity(ds::PyCall.PyObject, samples, groundtruth::String)
    text = stt(ds, samples, 16000)
    ð = code_similarity(text, groundtruth)
    @info :similarity (text, ð)
    (text, ð)
end

"""
    DeepSpeech.similarity(ds::PyCall.PyObject, audiofile::String, groundtruth::String)
"""
function similarity(ds::PyCall.PyObject, audiofile::String, groundtruth::String)
    samples, fs, nbits, opt = wavread(audiofile, format=WAVE_FORMAT_PCM)
    similarity(ds, samples, groundtruth)
end

end # module Sunyata.DeepSpeech
