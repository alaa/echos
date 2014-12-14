require "./lib/echos"

q = Echos::Bus.new(Echos::Queue::RabbitMQ)
while true do
  q.consume
  sleep 0.1
end
