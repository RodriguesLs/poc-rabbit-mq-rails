class ConsumerService
  attr_accessor :new_connection, :channel

  
  def initialize
    @new_connection = BaseService.new
    @new_connection.start
    @channel = @new_connection.create_channel

    @channel.prefetch(1)
    puts 'Consumeer Channel Created'
  end

  def declare_queue(queue_name = 'default')
    puts "A queue with name #{queue_name} declared"
    @channel.queue(queue_name)
  end

  def consume_message(queue)
    puts 'Start consuming message'
    begin
      message = nil
      queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, payload|
        puts " [x] Received '#{payload}'"
        channel.ack(delivery_info.delivery_tag)
        message = payload
      end
      return message
    rescue => _
      close_connection
    end
    return false
  end

  def close_connection
    puts 'Connections closed'
    @new_connection.close
  end
end
