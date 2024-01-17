class TwoBucket
  attr_reader :goal_bucket, :other_bucket, :goal,
              :fill_first

  def initialize(first_max, second_max, goal, fill_first, state_after_move = [])
    @fill_first = fill_first
    @goal = goal
    bucket1, bucket2 = create_buckets(first_max, second_max)
    # @state_after_move = state_after_move
    if fill_first == bucket1.name
      @start_bucket = bucket1
      @second_bucket = bucket2
    else
      @start_bucket = bucket2
      @second_bucket = bucket1
    end
    @pour_service = PourService.new(@start_bucket, @second_bucket)
  end

  def moves
    return unless @pour_service.can_fill?(@start_bucket)

    @pour_service.fill(@start_bucket)

    loop do
      break if goal_met?

      # Six choices:
      #  - fill 1
      # - fill 2
      # - empty 1
      # - empty 2
      # - 1 into 2
      # - 2 into 1
      if @pour_service.can_pour_start_into_second?
        @pour_service.pour_start_into_second
      elsif @pour_service.can_fill?(@start_bucket)
        @pour_service.fill(@start_bucket)
      elsif @pour_service.can_empty?(@start_bucket)
        @pour_service.empty(@start_bucket)
      elsif @pour_service.can_empty?(@second_bucket)
        @pour_service.empty(@second_bucket)
      elsif @pour_service.can_fill?(@second_bucket)
        @pour_service.fill(@second_bucket)
      elsif @pour_service.can_pour_second_into_start?
        @pour_service.pout_second_into_start
      end
    end

    set_final_buckets
    @pour_service.move_count
  end

  private

  def create_buckets(first_max, second_max)
    [
      Bucket.new("one", first_max),
      Bucket.new("two", second_max)
    ]
  end

  def goal_met?
    @start_bucket.current == goal || @second_bucket.current == goal
  end

  def set_final_buckets
    if @start_bucket.current == goal
      @goal_bucket = @start_bucket.name
      @other_bucket = @second_bucket.name
    else
      @goal_bucket = @second_bucket.name
      @other_bucket = @start_bucket.name
    end
  end
end

class PourService
  def initialize(bucket1, bucket2, state_after_move = [])
    @state_after_move = state_after_move
    @bucket1 = bucket1
    @bucket2 = bucket2
  end

  def can_fill?(bucket)
    return false unless bucket.can_fill?

    cloned_filled = bucket.cloned_fill
    new_bucket_pair = if bucket == @bucket1
                        [cloned_filled, @bucket2]
                      else
                        [@bucket1, cloned_filled]
                      end
    !(state_exists?(*new_bucket_pair) || start_empty_second_full?(*new_bucket_pair))
  end

  def can_empty?(bucket)
    return false unless bucket.can_empty?

    cloned_empty = bucket.cloned_empty
    new_bucket_pair = if bucket == @bucket1
                        [cloned_empty, @bucket2]
                      else
                        [@bucket1, cloned_empty]
                      end
    !(state_exists?(*new_bucket_pair) || start_empty_second_full?(*new_bucket_pair))
  end

  def empty(bucket)
    bucket.empty
    update_move_state
  end

  def fill(bucket)
    bucket.fill
    update_move_state
  end

  def can_pour_start_into_second?
    return false unless !@bucket1.empty? && !@bucket2.full?

    bucket2_after_pour, bucket1_after_pour = @bucket2.fill_with_bucket(@bucket1, true)

    !(state_exists?(bucket1_after_pour, bucket2_after_pour) ||
      start_empty_second_full?(bucket1_after_pour, bucket2_after_pour))
  end

  def can_pour_second_into_start?
    return false unless !@bucket2.empty && !@bucket1.full?

    bucket2_after_pour, bucket1_after_pour = @bucket1.fill_with_bucket(@bucket2, true)

    !(state_exists?(bucket1_after_pour, bucket2_after_pour) ||
      start_empty_second_full?(bucket1_after_pour, bucket2_after_pour))
  end

  def pour_start_into_second
    @bucket2.fill_with_bucket(@bucket1)
    update_move_state
  end

  def pour_second_into_start
    @bucket1.fill_with_bucket(@bucket2)
    update_move_state
  end

  def move_count
    @state_after_move.count
  end

  private

  def state_exists?(bucket1, bucket2)
    @state_after_move.find { |m| m[0] == bucket1.current && m[1] == bucket2.current }
  end

  def start_empty_second_full?(new_start_bucket, new_second_bucket)
    new_start_bucket.empty? && new_second_bucket.full?
  end

  def last_state
    @state_after_move.last
  end

  def update_move_state
    @state_after_move << [@bucket1.current, @bucket2.current]
  end
end

class Bucket
  attr_reader :current, :name, :max

  def initialize(name, max, current=0)
    @name = name
    @current = current
    @max = max
  end

  def fill(units = "max")
    if units == "max"
      @current = max
    else
      @current += units
    end
  end

  def can_fill?
    available_to_fill > 0
  end

  def empty(units = "all")
    if units == "all"
      @current = 0
    else
      @current -= units
    end
  end

  def can_empty?
    @current > 0
  end

  def available_to_fill
    max - current
  end

  def empty?
    current.zero?
  end

  def full?
    current == max
  end

  def fill_with_bucket(from_bucket, dry_run=false)
    return clone_and_fill(from_bucket) if dry_run

    if from_bucket.current <= available_to_fill
      fill(from_bucket.current)
      from_bucket.empty
    else
      adjusted_pour = from_bucket.current - available_to_fill
      fill
      from_bucket.empty(adjusted_pour)
    end
  end

  def clone_and_fill(from_bucket)
    cloned = clone
    cloned_from = from_bucket.clone
    cloned.fill_with_bucket(cloned_from)
    [cloned, cloned_from]
  end

  def cloned_fill
    cloned = clone
    cloned.fill
    cloned
  end

  def cloned_empty
    cloned = clone
    cloned.empty
    cloned
  end

  def clone
    self.class.new(name, max, current)
  end
end
