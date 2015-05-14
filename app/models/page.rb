# -*- coding: utf-8 -*-
class Page
  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :page_slug, type: String
  field :title, type: String
  field :is_deleted, type: Mongoid::Boolean
  field :tags, type: Array, default: []

  has_many :versions, autosave: true

  validates :page_slug, uniqueness: true, format: { with: /\A[^\/\?\s\+=]+\z/ }
  validates_presence_of :title

  # virtual attribute to handle pages#create: content of page's initial version
  attr_accessor :body

  def last_edited_at
    versions.last.created_at
  end

  def to_param
    self[:page_slug]
  end

  def tags=(tag)
    if tag.is_a? String
      super(Page.split_tags(tag))
    else
      super(tag)
    end
  end

  def self.split_tags(str)
    str.split(/,|、/).map {|s| s.gsub(/^\p{blank}*/, '').gsub(/\p{blank}*$/, '') }.compact
  end

  def self.slug_to_markdown_link(slug)
    page = Page.find_by(page_slug: slug)
    # FIXME: use link_to helper method
    "[#{page.title}](/pages/#{slug})"
  rescue
    "<s>[link to #{slug}]</s>"
  end
end
