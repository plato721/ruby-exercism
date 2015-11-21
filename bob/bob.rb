class Bob
  RESPONSES = {
    :question => "Sure.",
    :yelling => "Whoa, chill out!",
    :blank => "Fine. Be that way!",
    :default => "Whatever."
  }
  RESPONSE_CRITERIA = {
    :question => /(([a-z]+.*)|([a-z0-9]+))[?]$/,
    :yelling => /[A-Z]{2,}/,
    :not_yelling => /[a-z]+/,
    :blank =>  /^[\s]*$/
  }
  def initialize
  end
  def hey(remark)
    remark.delete!("\n")
    case
    when question?(remark) 
      respond_to(:question)
    when yelling?(remark)
      respond_to(:yelling)
    when blank?(remark)
      respond_to(:blank)
    else
      respond_to
    end
  end

  def respond_to(type=:default)
    RESPONSES[type]
  end

  # kinda ugly but not sure what the best approach is
  def yelling?(remark)
    remark.match(RESPONSE_CRITERIA[:yelling]) &&
    !(remark.match(RESPONSE_CRITERIA[:not_yelling]))
  end

  def question?(remark)
    remark.match(RESPONSE_CRITERIA[:question])
  end

  def blank?(remark)
    remark.match(RESPONSE_CRITERIA[:blank])
  end
end