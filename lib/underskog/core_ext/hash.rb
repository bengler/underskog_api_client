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
  # @param user[Integer, String, Underskog::User] A Underskog user ID or object.
  # @return [Hash]
  def merge_user!(user, prefix=nil, suffix=nil)
    case user
    when Integer
      self[[prefix, "id", suffix].compact.join("_").to_sym] = user
    when String
      self[[prefix, "id", suffix].compact.join("_").to_sym] = URI.escape(user)
    when Underskog::User
      if user.id
        self[[prefix, "id", suffix].compact.join("_").to_sym] = user.id
      end
    end
    self
  end

  # Take a user and merge it into the hash with the correct key
  #
  # @param user[Integer, Underskog::Event] A Underskog event ID or object.
  # @return [Hash]
  def merge_event!(event, prefix=nil, suffix=nil)
    case event
    when Integer
      self[[prefix, "id", suffix].compact.join("_").to_sym] = event
    when Underskog::Event
      if event.id
        self[[prefix, "id", suffix].compact.join("_").to_sym] = event.id
      end
    end
    self
  end

end
