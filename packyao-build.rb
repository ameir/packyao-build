require 'pp'

def generate_script
  require 'erb'
  require 'securerandom'
  filename = "run-#{SecureRandom.uuid}.sh"

  template = IO.read('run.sh.erb')
  message = ERB.new(template, 0, '%<>')
  File.write(filename, message.result(binding))
  filename
end

def generate_dockerfile(filename)
  template = IO.read('Dockerfile.erb')
  message = ERB.new(template, 0, '%<>')
  File.write('Dockerfile', message.result(binding))
end

filename = generate_script
generate_dockerfile(filename)

require 'docker'
puts 'Creating image...'
image = Docker::Image.build_from_dir('.')
puts 'Creating container...'
container = Docker::Container.create('Image' => image.id)
container.start
container.top
container.logs(stdout: true)
