# -*- coding: utf-8 -*-
class Page
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  include Mongoid::Slug

  field :page_slug, type: String
  field :title, type: String
  field :is_deleted, type: Mongoid::Boolean
  field :tags, type: Array, default: []

  has_many :versions, autosave: true

  validates :page_slug, uniqueness: true, format: { with: /\A[A-Za-z1-9_\-]+\z/ }
  validates_presence_of :title

  slug :page_slug

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
end
