require "digest/sha1"
require "bundler"
# Bundler.setup :default
Bundler.require :default

require_relative "lib/accents"
include Accents

# VOICE_CFG = {
#   language_code: "en-US",
#   ssml_gender:   "FEMALE",
#   name:          "en-US-Wavenet-E",
# }

# italian female not boring
# Italian (Italy)	WaveNet	it-IT	it-IT-Wavenet-A	FEMALE
# VOICE_CFG = {
#   language_code: "it-IT",
#   ssml_gender:   "FEMALE",
#   name:          "it-IT-Wavenet-A	FEMALE",
# }


# japanese female evangelion
# Japanese (Japan)	WaveNet	ja-JP	ja-JP-Wavenet-A	FEMALE
# VOICE_CFG = {
#   language_code: "ja-JP",
#   ssml_gender:   "FEMALE",
#   name:          "ja-JP-Wavenet-A	",
# }

# # italian male not boring
# # Italian (Italy)	WaveNet	it-IT	it-IT-Wavenet-C	MALE
VOICE_CFG = {
  language_code: "it-IT",
  ssml_gender:   "MALE",
  name:          "it-IT-Wavenet-C	MALE",
}

OUTPUT_FILE_PATH = "../../public/wavenet"

# TODO: load yaml (source configs) and convert it to json on the fly on app start
ENV["GOOGLE_CLOUD_KEYFILE"] = "./config/credentials.json"
