module Docker
  def Container.find(id)
    all.find {|c| c.info['Names'].include?('/' + id)}
  end
end
