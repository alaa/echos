require "./lib/echos"

q = Echos::Transport.new
while true do
  q.consume
  sleep 0.2
end
