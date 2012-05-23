class Hash

  # Merges self with another hash, recursively
  #
  # @param hash [Hash] The hash to merge
  # @return [Hash]
  def deep_merge(hash)
    target = self.dup
    hash.keys.each do |key|
      if hash[key].is_a?(Hash) && self[key].is_a?(Hash)
        target[key] = target[key].deep_merge(hash[key])
        next
      end
      target[key] = hash[key]
    end
    target
  end

  # Take a user and merge it into the hash with the correct key
  #
  # @param user[Integer, Underskog::User] A Underskog user ID or object.
  # @return [Hash]
  def merge_user!(user, prefix=nil, suffix=nil)
    case user
    when Integer
      self[[prefix, "user_id", suffix].compact.join("_").to_sym] = user
    when Underskog::User
      if user.id
        self[[prefix, "user_id", suffix].compact.join("_").to_sym] = user.id
      end
    end
    self
  end

  # Take a multiple users and merge them into the hash with the correct keys
  #
  # @param users [Array<Integer, Underskog::User>, Set<Integer, Underskog::User>] An array of Underskog user IDs or objects.
  # @return [Hash]
  def merge_users!(*users)
    user_ids = []
    users.flatten.each do |user|
      case user
      when Integer
        user_ids << user
      when Underskog::User
        if user.id
          user_ids << user.id
        end
      end
    end
    self[:user_id] = user_ids.join(',') unless user_ids.empty?
    self
  end

end
