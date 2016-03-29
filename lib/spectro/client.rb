require 'spectro'
require 'thor'

module Spectro

  class Client < Thor

    desc 'compile', 'Parses the current project looking for unfulfilled specs and looks for suitable lambdas in the repos. It then updates the cache with them.'
    def compile
      Spectro::Compiler.compile
    end

    desc 'init', 'Initialize the current folder as an Spectro project, creating all the required files and folders.'
    option :f, type: :boolean
    def init
      Spectro::Compiler.init options
    end

    desc 'upload', 'Uploads the undefined specs to the Hivein order to let the comunnity work and discuss over them.'
    def upload
      Spectro::HTTPClient.upload_undefined_specs
    end

  end

end
