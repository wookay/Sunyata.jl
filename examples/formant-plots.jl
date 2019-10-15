using Sunyata # Acoustic
using WAV # wavread WAVE_FORMAT_PCM

function get_samplebuf(samples::Vector{T}, sample_length, i, stop) where {T}
    sample_length > stop ? samples[i:stop] : vcat(samples[i:end], zeros(T, stop-sample_length))
end


audiofile = "hello.wav"
samples, fs, nbits, opt = wavread(audiofile, format=WAVE_FORMAT_PCM)
mono = samples[:,1]

step = 160 # 16000 * 0.01s
sample_length = length(mono)

x = Float64[]
y = Float64[]
for i in range(1, step=step, stop=sample_length)
    buf = get_samplebuf(mono, sample_length, i, i+step)
    frqs = Acoustic.get_formants(buf, fs)
    # @info :frqs (i, frqs)
    f1, f2 = frqs[1:2]
    if f1 > 0 && f2 > 0
        push!(x, f1)
        push!(y, f2)
    end
end


using UnicodePlots
plt = scatterplot(x, y; xlabel="F1", ylabel="F2")
show(stdout, MIME"text/plain"(), plt)
