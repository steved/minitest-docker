module Docker
  def Container.find(id)
    all.find {|c| c.info['Names'].include?('/' + id)}
  end

  Exec.prepend(Module.new {
    def start!(*)
      super.tap do |stdout, stderr, _|
        [*stdout, *stderr].each do |msg|
          msg.force_encoding('utf-8').scrub!
        end
      end
    end
  })
end
