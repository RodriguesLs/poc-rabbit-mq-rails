class PublisherService
  attr_accessor :new_connection, :channel

  def initialize
    @connection = BaseService.new
    @connection.start
    @channel = @connection.create_channel
    puts 'Publisher channel created'
  end

  def declare_queue(queue_name = 'default')
    puts "A queue with name #{queue_name} declared"
    @channel.queue(queue_name)
  end

  def publish_message(routing_key, msg, persistent = false, correlation_id = 'a_secret_key')
    puts " Message sent #{msg}"
    @channel.default_exchange.publish(msg, routing_key: routing_key, persistent: persistent, correlation_id: correlation_id )
  end

  def close_connection
    puts 'Connections closed'
    @connection.close
  end
end
