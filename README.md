# Sunyata 💋

Speech to Text using DeepSpeech


### Examples

 * DeepSpeech
```
~/.julia/dev/Sunyata/examples$ julia speech-to-text.jl
Loading model from file models/output_graph.pbmm
TensorFlow: v1.13.1-10-g3e0cc5374d
DeepSpeech: v0.5.1-0-g4b29b78
2019-10-16 01:49:46.728203: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
2019-10-16 01:49:46.734151: E tensorflow/core/framework/op_kernel.cc:1325] OpKernel ('op: "UnwrapDatasetVariant" device_type: "GPU" host_memory_arg: "input_handle" host_memory_arg: "output_handle"') for unknown op: UnwrapDatasetVariant
2019-10-16 01:49:46.734172: E tensorflow/core/framework/op_kernel.cc:1325] OpKernel ('op: "UnwrapDatasetVariant" device_type: "CPU"') for unknown op: UnwrapDatasetVariant
2019-10-16 01:49:46.734183: E tensorflow/core/framework/op_kernel.cc:1325] OpKernel ('op: "WrapDatasetVariant" device_type: "GPU" host_memory_arg: "input_handle" host_memory_arg: "output_handle"') for unknown op: WrapDatasetVariant
2019-10-16 01:49:46.734203: E tensorflow/core/framework/op_kernel.cc:1325] OpKernel ('op: "WrapDatasetVariant" device_type: "CPU"') for unknown op: WrapDatasetVariant
Loading language model from files models/lm.binary models/trie
┌ Info: similarity
└   (text, ð) = ("hello", 1.0)
  2.492678 seconds (6.05 M allocations: 301.573 MiB, 4.25% gc time)
┌ Info: similarity
└   (text, ð) = ("hello", 1.0)
  0.190070 seconds (21.86 k allocations: 424.094 KiB)
┌ Info: similarity
└   (text, ð) = ("hello", 1.0)
  0.183726 seconds (21.84 k allocations: 423.188 KiB)
┌ Info: similarity
└   (text, ð) = ("hello", 1.0)
  0.181370 seconds (21.84 k allocations: 423.188 KiB)
┌ Info: similarity
└   (text, ð) = ("hello", 1.0)
  0.185686 seconds (21.84 k allocations: 423.188 KiB)
```


 * Acoustic
```
~/.julia/dev/Sunyata/examples$ julia formant-plots.jl
           ┌────────────────────────────────────────┐
      2000 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀│
           │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⣠⡀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠢⢈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⡁⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠄⠀⠀⣀⠁⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
   F2      │⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
         0 │⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
           └────────────────────────────────────────┘
           0                                     1000
                              F1
```


### Requirements
  - A TensorFlow implementation of Baidu's DeepSpeech architecture https://github.com/mozilla/DeepSpeech
  - [Julia](https://julialang.org) and packages
    - [Phonetics.jl](https://github.com/Betawolf/Phonetics.jl)
    - [DSP.jl](https://github.com/JuliaDSP/DSP.jl)
    - [PolynomialRoots.jl](https://github.com/giordano/PolynomialRoots.jl)
    - [WAV.jl](https://github.com/dancasimiro/WAV.jl)
    - [JSON2.jl](https://github.com/quinnj/JSON2.jl)
    - [PyCall.jl](https://github.com/JuliaPy/PyCall.jl)
