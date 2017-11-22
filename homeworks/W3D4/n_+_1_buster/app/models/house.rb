class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id,
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  # create an array of all the seeds within a given house

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    plants = self.plants.includes(:seeds)

    seeds = []
    plants.each do |plant|
      # only accessing seeds on each plant -> simply prefetch seeds
      seeds << plant.seeds
    end

    seeds
  end
end
