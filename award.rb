class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  # Helpers
  def decrement_quality(value)
    if @quality - value < 0
      @quality = 0
    else
      @quality -= value
    end
  end

  def increment_quality(value=1)
    if @quality + value > 50
      @quality = 50
    else
      @quality += value
    end
  end

  def decrement_expires_in(value=1)
    @expires_in -= value
  end

  def after_expiration_date?
    expires_in < 0
  end

  def before_expiration_date?
    expires_in > 0
  end

  def on_expiration_date?
    expires_in.zero?
  end

  def zero_quality?
    @quality == 0
  end

  def within_upper_bound_expiration?
    @expires_in <= 10 && @expires_in > 5
  end

  def within_lower_bound_expiration?
    @expires_in <= 5 && @expires_in > 0
  end

  # Case specific updates
  def update_quality
    case name
    when 'Blue Star'
      update_blue_star_award_quality
      decrement_expires_in
    when 'Blue First'
      update_blue_first_award_quality
      decrement_expires_in
    when 'Blue Compare'
      update_blue_compare_award_quality
      decrement_expires_in
    when 'Blue Distinction Plus'
      update_blue_distinction_plus_award_quality
    else
      update_default_award_quality
      decrement_expires_in
    end
  end

  def update_blue_compare_award_quality
    return if zero_quality?

    if before_expiration_date?
      return increment_quality(2) if within_upper_bound_expiration?
      return increment_quality(3) if within_lower_bound_expiration?
      increment_quality(1)
    else
      @quality = 0
    end
  end

  def update_blue_distinction_plus_award_quality
    @quality == 80 ? @quality : @quality = 80
  end

  def update_blue_first_award_quality
    return if zero_quality?

    if before_expiration_date?
      increment_quality
    else
      increment_quality(2)
    end
  end

  def update_blue_star_award_quality
    return if zero_quality?

    if before_expiration_date?
      decrement_quality(2)
    else
      decrement_quality(4)
    end
  end

  def update_default_award_quality
    return if zero_quality?

    if on_expiration_date? || after_expiration_date?
      decrement_quality(2) 
    else
      decrement_quality(1)
    end
  end

end
