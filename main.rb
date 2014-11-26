require_relative "./lib/check"
require_relative "./lib/template"

check_disk = Check.new(name: :check_disk, command: "df -h")
check_mem = Check.new(name: :check_mem, command: "free -m")
check_load = Check.new(name: :check_load, command: "uptime")

disk_template = Template.new(:disk_template)
disk_template.add([check_disk, check_load, check_disk])

performance_template = Template.new(:performance_template)
performance_template.add([check_mem, check_load])

a = disk_template + performance_template
a.checks.each do |x|
  puts ">> #{x.name} \n"
  system(x.command)
end

