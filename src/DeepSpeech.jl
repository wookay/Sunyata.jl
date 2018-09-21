module DeepSpeech # Sunyata

include("DeepSpeech/client.jl")

using Phonetics # code_similarity

"""
    DeepSpeech.similarity(ds::PyCall.PyObject, audiofile::String, groundtruth::String)
"""
function similarity(ds::PyCall.PyObject, audiofile::String, groundtruth::String)
    text = stt(ds, audiofile)
    ð = code_similarity(text, groundtruth)
    @info :similarity (text, ð)
    (text, ð)
end

end # module Sunyata.DeepSpeech
