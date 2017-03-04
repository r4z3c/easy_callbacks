module EasyCallbacks
  module Repositories

    class TargetClassesRepository < BaseRepository

      protected

      def find_block(target_class); Proc.new { |item| item.target_class.eql? target_class } end

      def model; Models::TargetClass end

    end

  end
end