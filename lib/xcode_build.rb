module XcodeBuild
  def self.run(args = "", output_buffer = STDOUT)
    IO.popen("xcodebuild #{args}", err: [:child, :out]) do |io|
      begin
        while line = io.readline
          begin
            output_buffer << line
          rescue StandardError => e
            puts "Error from output buffer: #{e.inspect}"
          end
        end
      rescue EOFError
      end
    end
  end
end

require_relative 'xcode_build/output_translator'
require_relative 'xcode_build/build_reporter'
