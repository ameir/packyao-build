require 'docker'
require 'pp'

puts "Creating image..."
image = Docker::Image.build_from_dir('.')
pp image.json
puts "Creating container..."
container = Docker::Container.create('Image' => image.id)
pp container.json
container.start

