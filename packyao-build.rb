require 'pp'
def generate_dockerfile
  require "erb"

  template = IO.read("Dockerfile.erb")
  message = ERB.new(template, 0, "%<>")
  File.write('Dockerfile', message.result)
end

generate_dockerfile
exit

require 'docker'
puts "Creating image..."
image = Docker::Image.build_from_dir('.')
pp image.json
puts "Creating container..."
container = Docker::Container.create('Image' => image.id)
pp container.json
container.start
