module Acoustic # Sunyata

using WAV # wavread WAVE_FORMAT_PCM
using DSP # filt hamming lpc LPCBurg
using PolynomialRoots # roots

# code from https://stackoverflow.com/questions/25107806/estimate-formants-using-lpc-in-python

function get_formants(samples, fs)
    data = reinterpret(Int16, samples[:,1])
    w = hamming(length(data))
    x1 = data .* w
    x2 = filt([1.], [1., 0.63], x1)
    ncoeff = trunc(Int, 2 + fs/1000)
    A, err = lpc(x2, ncoeff, LPCBurg())
    rts = filter(x -> imag(x) >= 0, roots(A))
    angz = atan.(imag.(rts), real.(rts))
    frqs = sort(angz .* (fs / 2pi))
    return frqs
end

function get_formants(audiofile::String)
    samples, fs, nbits, opt = wavread(audiofile, format=WAVE_FORMAT_PCM)
    get_formants(samples, fs)
end

end # module Sunyata.Acoustic
