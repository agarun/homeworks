# == Schema Information
#
# Table name: steps
#
#  id          :integer          not null, primary key
#  description :string           not null
#  todo_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Step < ApplicationRecord

  belongs_to :todo

end
