require 'rubygems'
require 'bundler/setup'
require 'lotus/view'
require 'lotus/assets/es6'
require 'lotus/emberjs'

Lotus::Assets.configure do
  public_directory __dir__ + '/../../../../tmp/bookshelf/public'
end

unless defined?(Web)
  module Web
    View   = Lotus::View.duplicate(self) do
      root __dir__ + '/../../../fixtures/bookshelf/apps/web/templates'
      layout :application

      prepare do
        include Web::Assets::Helpers
      end
    end

    Assets = Lotus::Assets.duplicate(self) do
      root             __dir__ + '/../../../fixtures/bookshelf/apps/web'
      public_directory __dir__ + '/../../../../tmp/bookshelf/public'
      manifest         'assets.json'
      prefix           '/assets'
      compile          true

      sources << [
        'assets',
        'vendor/assets/javascripts'
      ]
    end

    module Views
      class ApplicationLayout
        include Web::Layout
      end

      module Books
        class Show
          include Web::View
        end
      end

      module Users
        class Show
          include Web::View
        end
      end
    end
  end

  module Admin
    View   = Lotus::View.duplicate(self) do
      root __dir__ + '/../../../fixtures/bookshelf/apps/admin/templates'
      layout :application

      prepare do
        include Admin::Assets::Helpers
      end
    end

    Assets = Lotus::Assets.duplicate(self) do
      root             __dir__ + '/../../../fixtures/bookshelf/apps/admin'
      public_directory __dir__ + '/../../../../tmp/bookshelf/public'
      manifest         'assets.json'
      prefix           '/assets/admin'
      compile          true

      sources << [
        'assets'
      ]
    end

    module Views
      class ApplicationLayout
        include Admin::Layout
      end

      module Users
        class Index
          include Admin::View
        end
      end
    end
  end

  module Metrics
    View   = Lotus::View.duplicate(self) do
      root __dir__ + '/../../../fixtures/bookshelf/apps/metrics/templates'
      layout :application

      prepare do
        include Metrics::Assets::Helpers
      end
    end

    Assets = Lotus::Assets.duplicate(self) do
      root             __dir__ + '/../../../fixtures/bookshelf/apps/metrics'
      public_directory __dir__ + '/../../../../tmp/bookshelf/public'
      manifest         'assets.json'
      prefix           '/assets/metrics'
      compile          true

      sources << [
        'assets'
      ]
    end

    module Views
      class ApplicationLayout
        include Metrics::Layout
      end

      module Dashboard
        class Index
          include Metrics::View
        end
      end
    end
  end
end
