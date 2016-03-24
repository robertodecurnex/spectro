require 'spectro'
require 'thor'

module Spectro

	class Client < Thor

		desc 'compile', 'Parses the current project looking for unfulfilled specs and looks for suitable lambdas in the repos. It then updates the cache with them.'
		def compile
			require 'spectro/compiler'
			Spectro::Compiler.compile
		end

		desc 'init', 'Initialize the current folder as an Spectro project, creating all the required files and folders.'
		option :f, type: :boolean
		def init
			require 'spectro/compiler'
			Spectro::Compiler.init options
		end

	end

end
