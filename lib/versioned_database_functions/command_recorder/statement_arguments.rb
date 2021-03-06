module VersionedDatabaseFunctions
  module CommandRecorder
    # @api private
    class StatementArguments
      def initialize(args)
        @args = args.freeze
      end

      def function_or_aggregate
        @args[0]
      end

      def version
        options[:version]
      end

      def revert_to_version
        options[:revert_to_version]
      end

      def arguments
        options[:arguments]
      end

      def returns
        options[:returns]
      end

      def invert_version
        StatementArguments.new([function_or_aggregate, options_for_revert])
      end

      def to_a
        @args.to_a
      end

      private

      def options
        @options ||= @args[1] || {}
      end

      def options_for_revert
        options.clone.tap do |revert_options|
          revert_options[:version] = revert_to_version
          revert_options.delete(:revert_to_version)
        end
      end
    end
  end
end
