using Test
using Sunyata # Acoustic
using WAV # wavread WAVE_FORMAT_PCM

# http://www.linguistics.ucla.edu/people/hayes/103/Charts/VChart/ae.wav
audiofile = normpath(@__DIR__, "ae.wav")
samples, fs, nbits, opt = wavread(audiofile, format=WAVE_FORMAT_PCM)
@test [288, 297, 295] == reinterpret(Int16, samples)[1:3]

frqs = Acoustic.get_formants(samples[1:160], fs)
@test [0.0, 667.09, 1613.75] ≈ frqs[1:3] atol=0.01
