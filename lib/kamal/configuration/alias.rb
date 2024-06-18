class Kamal::Configuration::Alias
  include Kamal::Configuration::Validation

  delegate :argumentize, :optionize, to: Kamal::Utils

  attr_reader :name, :alias_config

  def initialize(name, config:)
    @name, @config, @alias_config = name.inquiry, config, config.raw_config["aliases"][name]

    validate! \
      alias_config,
      example: validation_yml["aliases"]["uname"],
      context: "aliases/#{name}",
      with: Kamal::Configuration::Validator::Alias
  end

  def command
    alias_config["command"]
  end

  def invocation
    parts = command.split(" ")
    parts.unshift("main") if parts.length == 1
    parts.join(":")
  end

  def options
    alias_config.fetch("options", {})
  end

  def arguments
    alias_config["arguments"]
  end
end
