class Recipe < ApplicationRecord
  def ingredients_list
    ingredients.split(", ")
  end

  def directions_list
    directions.split(", ")
  end

  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60
    result = ""
    result = result + "#{hours} hours " if hours > 0
    result = result + "#{minutes} minutes" if minutes > 0
    return result
  end

  def as_json
    {
      id: id,
      title: title,
      chef: chef,
      ingredients: ingredients_list,
      directions: directions_list,
      image: image,
      prep_time: prep_time,
      friendly_prep_time: friendly_prep_time,
      friendly_created_at: friendly_created_at
    }
  end
end
