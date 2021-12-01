require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'should have a nonblank name matching /\A[a-zA-Zа-яА-ЯёЁ0-9_]+\z/' do
    page = Page.new

    invalid_names = [
      '',
      'with spaces',
      'd-a-s-h-e-d',
      's/l/a/s/h/e/d',
      'nöt_välîd'
    ]

    invalid_names.each do |name|
      page.name = name
      expect(page).to_not be_valid
    end

    valid_names = [
      *'a'..'z',
      *'A'..'Z',
      *'0'..'9',
      *'а'..'я',
      *'А'..'Я',
      'ё',
      'Ё',
      '_'
    ]
    valid_names.push(valid_names.join)

    valid_names.each do |name|
      page.name = name
      expect(page).to be_valid
    end
  end

  it 'generates formatted_body from body before save' do
    page = Page.new name: 'valid_name'
    page.body = "Текст **with bald** and \\\\italic\\\\ и\n" \
                "((Страница_1/2/and_three ссылкой на другую страницу))"
    page.save

    expect(page.formatted_body).to eq(
      "Текст <b>with bald</b> and <i>italic</i> и\n" \
      "<a href=\"/Страница_1/2/and_three\">ссылкой на другую страницу</a>")
  end
end
