require 'spectro'
require 'spectro/spec/parser'
require 'yaml/store'

module Spectro

  # Spectro::Compiler is in charge of scan the projects and parse its files,
  # updating the Spectroi's index and dumping information about the missing
  # implementations (specs without an associated lambda)
  class Compiler

    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :compile, :init
    end

    # Filters the project files keeping those that make use of Spectro.
    # It then parses them, check for missing implementations
    # and creates an .spectro/undefined.yml with their specs.
    #
    # @return [Spectro::Compiler] self
    def compile
      if !Dir.exist?('.spectro')
        abort "\n" + "This folder has not been initialzed as an Spectro project. Please run ".white.on_red + " spectro init ".white.on_light_black + " before compiling.".white.on_red + "\n\n"
      end

      undefined_yaml = YAML::Store.new(".spectro/undefined.yml")
      undefined_yaml.transaction do
        targets().map do |path|
          missing_specs = missing_specs_from_file(path)

          next if missing_specs.empty?

          undefined_yaml[path] = missing_specs
        end
      end

      return self
    end

  # Init the current folder as an Spectro project, creating all the required files and folders
  # `.spectro` confg file
  # `.spectro/index.yml` which will hold the mappings between Files/Method names and defined lambdas
  # `.spectro/undefined.yml` which will hold the collection of spec definitions not yet fulfilled
  # `.spectro/cache` folder that will hold the source code of the retrieved lambdas
  #
  # @return [Spectro::Compiler] self
  def init options={}
    if File.exist?('.spectro/config') && !options[:f]
      abort "\n" + "Project already initialized. If you want to reset the curret setup you can run ".black.on_yellow + " spectro init -f ".white.on_light_black + "\n\n"
    end

    Dir.exist?('.spectro') || Dir.mkdir('.spectro')
    Dir.exist?('.spectro/cache') || Dir.mkdir('.spectro/cache')
    File.open('.spectro/config', 'w') do |file|
      file.write <<-CONFIG
#!/usr/bin/env ruby

Spectro.configure do |config|
# Sets a custom API Hostname if needed
# config.api_hostname = 'localhost:9292'
#
# Instead of failing in case of unfulfilled functions it will try to use the local specs to get a result
# config.enable_mocks!
end
      CONFIG
    end
    File.open('.spectro/index.yml', 'w') do |file|
    end
    File.open('.spectro/undefined.yml', 'w') do |file|
    end

    puts "\n" + "The project has been successfully initialized".black.on_blue + "\n\n"

    return self
  end

  private

    # Parse the specs on the given file path and return those
    # that have not been fulfilled or need to be updated.
    #
    # @param [String] path target file path
    # @return [<Spectro::Spec>] collection of specs not fulfilled or out of date
    def missing_specs_from_file(path)
      Spectro::Spec::Parser.parse(path).select do |spec|
        index_spec = Spectro::Database.index[path] && Spectro::Database.index[path][spec.signature.name]
        index_spec.nil? || index_spec['spec_md5'] != spec.md5
      end
    end

    # Filter project's rb files returning an Array of files
    # containinig specs to be parsed.
    #
    # @return [<String>] array of files to be parsed
    def targets
      return %x[ grep -Pzrl --include="*.rb" "^__END__.*\\n.*spec_for" . ].split("\n").collect do |path|
        path[2..-1]
      end
    end

  end

end
