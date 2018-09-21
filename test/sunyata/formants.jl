using Test
using Sunyata
using WAV # wavread WAVE_FORMAT_PCM

# http://www.linguistics.ucla.edu/people/hayes/103/Charts/VChart/ae.wav
audiofile = normpath(@__DIR__, "ae.wav")
samples, fs, nbits, opt = wavread(audiofile, format=WAVE_FORMAT_PCM)
@test [288, 297, 295] == reinterpret(Int16, samples)[1:3]

frqs = DeepSpeech.get_formants(samples, fs)
@test [ 682.1892700891899,
       1886.304994341837,
       3518.8296699099437,
       6524.80862873618  ] ≈ frqs
