module EasyCallbacks

  ROOT = File.expand_path(File.join(File.dirname(__FILE__),'..'))

  class << self

    def load_easy_callbacks
      Dir[File.expand_path(File.join(ROOT,'lib','easy_callbacks','**/*.rb'))].each do |file|
        require file
      end
    end

  end

  load_easy_callbacks

end