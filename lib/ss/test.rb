# frozen_string_literal: true

require 'ss/ui/test/version'

module Ss
  module Ui
    module Test
      class << self
        def project_root
          File.expand_path('../..', __dir__)
        end
      end
    end
  end
end
