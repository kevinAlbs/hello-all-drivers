class CommandMonitor
  def started(event)
    puts ">> #{event.command_name} #{event.command}"
  end

  def succeeded(event)
    puts "<< #{event.command_name} #{event.reply}"
  end

  def failed(event); end
end

def setup_monitoring(client)
  return unless ENV["PRINT_MONGODB_COMMANDS"]
  client.subscribe(Mongo::Monitoring::COMMAND, CommandMonitor.new)
end
