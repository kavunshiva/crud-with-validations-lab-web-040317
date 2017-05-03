class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :artist_name, presence: true
  validates :artist_name, uniqueness: {scope: :release_year}
  validate :release_year_valid?

  def release_year_valid?
    if self.released
      if !!self.release_year
        if self.release_year <= Time.now.year
          return true
        else
          errors.add(:release_year, "release year cannot be in the future")
          return false
        end
      else
        errors.add(:release, "there must be a release year if the song is released")
        return false
      end
    else
      if !self.release_year
        return true
      else
        errors.add(:release, "there cannot be a release year if the song is not released")
        return false
      end
    end
  end
end
