my_boolean = true

if my_boolean
  trivial("yes!")
else
  non_trival("no!")
end

def trivial(message)
  puts message
end

def non_trival(message)
  puts "NT #{message}"
end
