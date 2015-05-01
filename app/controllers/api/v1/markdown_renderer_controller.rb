module Api
  module V1
    class MarkdownRendererController < ApplicationController
      def transform
        render json: { html: PagesController.rendor_mkd(params["markdown"]) }
      end
    end
  end
end

