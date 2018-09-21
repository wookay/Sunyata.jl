# FIXME: it couldn't to import deepspeech using PyCall with precompile
__precompile__(false)
module DeepSpeech # Sunyata

include("DeepSpeech/client.jl")

using Phonetics # code_similarity
using DSP # filt hamming lpc LPCBurg
using PolynomialRoots # roots

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


# code from https://stackoverflow.com/questions/25107806/estimate-formants-using-lpc-in-python

function get_formants(samples, fs)
    data = reinterpret(Int16, samples[:,1])
    w = hamming(length(data))
    x1 = data .* w
    x2 = filt([1., -0.63], 1, x1)
    A, err = lpc(x2, 8, LPCBurg())
    pushfirst!(A, 1.)
    rts = filter(x -> imag(x) >= 0, roots(A))
    angz = atan.(imag.(rts), real.(rts))
    frqs = sort(angz .* (fs / 2pi))
    return frqs
end

function get_formants(audiofile::String)
    samples, fs, nbits, opt = wavread(audiofile, format=WAVE_FORMAT_PCM)
    get_formants(samples, fs)
end

end # module Sunyata.DeepSpeech
