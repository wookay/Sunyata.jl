using Sunyata

# Get the deepspeech-0.5.1-models.tar.gz in https://github.com/mozilla/DeepSpeech/releases
const modeldir = normpath(ENV["HOME"], "ipap/py/DeepSpeech_051")

ds = DeepSpeech.get_model(modeldir)
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
@time DeepSpeech.similarity(ds, "hello.wav", "hello")
