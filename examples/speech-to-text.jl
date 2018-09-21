using Sunyata

# Get the deepspeech-0.2.0-models.tar.gz in https://github.com/mozilla/DeepSpeech/releases
const modeldir = normpath(ENV["HOME"], "ipap/py/DeepSpeech_020")

ds = DeepSpeech.get_model(modeldir)
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
