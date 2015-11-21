require 'pry'

class Array
  def chop
    self.slice(0..-2)
  end
end

class Proverb
  attr_accessor :proverb, :raw

  def initialize(*args)
    @raw = args.clone
    @proverb = generate_proverb(raw)
  end

  def generate_proverb(raw)
    last = last_line(raw)
    body = body(raw)
    body + last
  end

  def qualifier?(args)
    args.last.class == Hash
  end

  def prep_causes(args)
    args.map.with_index do |e, idx|
      [e, args[idx + 1]]
    end.chop.to_h
  end

  def body(args)
    args.delete_at(-1) if qualifier?(args)
    cause_map = prep_causes(args)
    cause_map.each_with_object("") do |(cause, effect), body|
      body << "For want of a #{cause} the #{effect} was lost.\n"
    end
  end

  def last_line(args)
    if qualifier?(args)
      "And all for the want of a #{args.last[:qualifier]} #{args.first}."
    else
      "And all for the want of a #{args.first}."
    end
  end

  def to_s
    self.proverb
  end
end