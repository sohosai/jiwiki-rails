# -*- coding: utf-8 -*-
class Page < ActiveRecord::Base
  has_many :versions, autosave: true

  validates :page_slug, uniqueness: true, format: { with: /\A[^\/\?\s\+=]+\z/ }
  validates_presence_of :title

  # virtual attribute to handle pages#create: content of page's initial version
  attr_accessor :body

  acts_as_taggable

  def last_edited_at
    versions.last.created_at
  end

  def to_param
    self[:page_slug]
  end

  def tags=(tag)
    if tag.is_a? String
      tag_list.add(*Page.split_tags(tag))
    elsif !tag.empty?
      tag_list.add(*tag)
    end
  end

  def versions
    Version.where(page_id: id)
  end

  class << self
    def split_tags(str)
      str.split(/,|、/).map {|s| s.gsub(/^\p{blank}*/, '').gsub(/\p{blank}*$/, '') }.compact
    end

    def slug_to_markdown_link(slug)
      page = Page.find_by(page_slug: slug)
      # FIXME: use link_to helper method
      "[#{page.title}](/pages/#{slug})"
    rescue
      "<s>[link to #{slug}]</s>"
    end
  end
end
