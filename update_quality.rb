require 'award'

def update_quality(awards)
  awards.map do |award|
    award.update_quality
  end
end
