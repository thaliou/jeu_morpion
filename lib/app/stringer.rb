# Helper method pour pluraliser les mots en français
class String
  def pluralize(count)
    return self if count == 1
    return self + "s"
  end
end