#!/usr/bin/env python
# -*- coding: utf-8 -*-

# code from https://github.com/mozilla/DeepSpeech/blob/master/native_client/python/client.py

from __future__ import absolute_import, division, print_function

import argparse
import numpy as np
import shlex
import subprocess
import sys
import wave

from deepspeech import Model, printVersions
from timeit import default_timer as timer

try:
    from shhlex import quote
except ImportError:
    from pipes import quote

# These constants control the beam search decoder

# Beam width used in the CTC decoder when building candidate transcriptions
BEAM_WIDTH = 500

# The alpha hyperparameter of the CTC decoder. Language Model weight
LM_WEIGHT = 1.50

# Valid word insertion weight. This is used to lessen the word insertion penalty
# when the inserted word is part of the vocabulary
VALID_WORD_COUNT_WEIGHT = 2.25


# These constants are tied to the shape of the graph used (changing them changes
# the geometry of the first layer), so make sure you use the same constants that
# were used during training

# Number of MFCC features to use
N_FEATURES = 26

# Size of the context window used for producing timesteps in the input vector
N_CONTEXT = 9

def convert_samplerate(audio_path):
    sox_cmd = 'sox {} --type raw --bits 16 --channels 1 --rate 16000 - '.format(quote(audio_path))
    try:
        output = subprocess.check_output(shlex.split(sox_cmd), stderr=subprocess.PIPE)
    except subprocess.CalledProcessError as e:
        raise RuntimeError('SoX returned non-zero status: {}'.format(e.stderr))
    except OSError as e:
        raise OSError(e.errno, 'SoX not found, use 16kHz files or install it: {}'.format(e.strerror))

    return 16000, np.frombuffer(output, np.int16)


class VersionAction(argparse.Action):
    def __init__(self, *args, **kwargs):
        super(VersionAction, self).__init__(nargs=0, *args, **kwargs)

    def __call__(self, *args, **kwargs):
        printVersions()
        exit(0)

from attrdict import AttrDict
from pathlib import Path
home = str(Path.home())

def get_model(modeldir):
    args = AttrDict({
        'model': str.join('/', (modeldir, "models/output_graph.pbmm")),
        'alphabet': str.join('/', (modeldir, "models/alphabet.txt")),
        'lm': str.join('/', (modeldir, "models/lm.binary")),
        'trie': str.join('/', (modeldir,"models/trie")),
    })
    print('Loading model from file {}'.format(args.model), file=sys.stderr)
    model_load_start = timer()
    ds = Model(args.model, N_FEATURES, N_CONTEXT, args.alphabet, BEAM_WIDTH)
    model_load_end = timer() - model_load_start
    print('Loaded model in {:.3}s.'.format(model_load_end), file=sys.stderr)

    if args.lm and args.trie:
        print('Loading language model from files {} {}'.format(args.lm, args.trie), file=sys.stderr)
        lm_load_start = timer()
        ds.enableDecoderWithLM(args.alphabet, args.lm, args.trie, LM_WEIGHT,
                               VALID_WORD_COUNT_WEIGHT)
        lm_load_end = timer() - lm_load_start
        print('Loaded language model in {:.3}s.'.format(lm_load_end), file=sys.stderr)
    return ds

def stt(ds, audiofile):
    fin = wave.open(audiofile, 'rb')
    fs = fin.getframerate()
    if fs != 16000:
        # print('Warning: original sample rate ({}) is different than 16kHz. Resampling might produce erratic speech recognition.'.format(fs), file=sys.stderr)
        fs, audio = convert_samplerate(audiofile)
    else:
        audio = np.frombuffer(fin.readframes(fin.getnframes()), np.int16)

    audio_length = fin.getnframes() * (1/16000)
    fin.close()

    #print('Running inference.', file=sys.stderr)
    inference_start = timer()
    text = ds.stt(audio, fs)
    inference_end = timer() - inference_start
    print('sound =', text)
    print('  %0.3fs seconds' % (inference_end), file=sys.stderr)
    return text


# Get the deepspeech-0.2.0-models.tar.gz in https://github.com/mozilla/DeepSpeech/releases
modeldir = str.join('/', (str(Path.home()), "ipap/py/DeepSpeech_020"))
ds = get_model(modeldir)
stt(ds, "hello.wav")
stt(ds, "hello.wav")
stt(ds, "hello.wav")
stt(ds, "hello.wav")
stt(ds, "hello.wav")
