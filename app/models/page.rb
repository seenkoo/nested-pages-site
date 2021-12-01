class Page < ApplicationRecord
  has_ancestry

  validates :name, format: {
    with: /\A[a-zA-Zа-яА-ЯёЁ0-9_]+\z/,
    message: 'should match /\A[a-zA-Zа-яА-ЯёЁ0-9_]+\z/'
  }
  validates :name, exclusion: {
    in: %w[add edit],
    message: '"%{value}" is a reserved word'
  }

  before_validation :generate_slug, if: :name_changed?

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = if parent.present?
      [parent.slug, name].join('/')
    else
      name
    end
  end
end
