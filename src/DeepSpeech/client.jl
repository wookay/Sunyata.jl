# module Sunyata.DeepSpeech

using JSON2 # JSON2.read
using PyCall # @pyimport
using WAV # wavread wavwrite WAVE_FORMAT_PCM

#=
const package_manager = "pip3"
installed_packages = JSON2.read(read(`$package_manager list --format=json`, String))
speech_to_text_engine = "deepspeech"
if !any(x->x.name == speech_to_text_engine, installed_packages)
    run(`$package_manager install $speech_to_text_engine`)
end
=#


# code from https://github.com/mozilla/DeepSpeech/blob/master/native_client/python/client.py

@pyimport deepspeech # stt

# Beam width used in the CTC decoder when building candidate transcriptions
const BEAM_WIDTH = 500

# The alpha hyperparameter of the CTC decoder. Language Model weight
const LM_WEIGHT = 1.50

# Valid word insertion weight. This is used to lessen the word insertion penalty
# when the inserted word is part of the vocabulary
const VALID_WORD_COUNT_WEIGHT = 2.25

# These constants are tied to the shape of the graph used (changing them changes
# the geometry of the first layer), so make sure you use the same constants that
# were used during training

# Number of MFCC features to use
const N_FEATURES = 26

# Size of the context window used for producing timesteps in the input vector
const N_CONTEXT = 9

function get_model(modeldir::String)
    args = (
        model= normpath("models", "output_graph.pbmm"),
        alphabet= normpath("models", "alphabet.txt"),
        lm= normpath("models", "lm.binary"),
        trie= normpath("models", "trie"),
    )
    println("Loading model from file ", args.model)
    ds = deepspeech.Model(normpath(modeldir, args.model), N_FEATURES, N_CONTEXT, normpath(modeldir, args.alphabet), BEAM_WIDTH)
    println("Loading language model from files ", args.lm, " ", args.trie)
    ds[:enableDecoderWithLM](normpath(modeldir, args.alphabet), normpath(modeldir, args.lm), normpath(modeldir, args.trie), LM_WEIGHT, VALID_WORD_COUNT_WEIGHT)
    return ds
end

function convert_samplerate(samples, fs)
    buf = IOBuffer()
    wavwrite(samples, buf, Fs=fs, compression=WAVE_FORMAT_PCM)
    return reinterpret(Int16, buf.data)
end

function stt(ds, samples, fs)
    audio = convert_samplerate(samples[:,1], fs)
    return ds[:stt](audio, fs)
end

# module Sunyata.DeepSpeech
