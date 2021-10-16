class GPT3Davinci

  attr_reader :input

  ENGINE = "davinci" # code generation / stackoveflow-like answers / code completion

  MAX_TOKENS = 200
  STOP_TOKENS = [ # TODO: extract as options
    "Domanda:",
  ]

  def initialize(input:)
    @input = input
  end

  def complete
    bot_api = OpenAI::Client.new access_token: OPENAI_TOKEN
    # puts "Input Text"
    # p input
    # puts "---------"
    response = bot_api.completions(
      engine: ENGINE,
      parameters: {
        prompt: input,
        max_tokens: MAX_TOKENS,
        stop: STOP_TOKENS,
        # opts:
        temperature:       0.6,
        top_p:             1,
        frequency_penalty: 0,
        presence_penalty:  0,
      },
    )
    resp = response.body
    resp = JSON.parse resp
    # puts "RESP RAW:"
    # p resp
    resp = resp.f "choices"
    resp = resp.f 0
    resp = resp.f "text"
    puts "RESP:"
    p resp
    resp
  end
end
