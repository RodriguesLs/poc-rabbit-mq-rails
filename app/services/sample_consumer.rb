class SampleConsumer
  def self.get_payload(queue_name)
    consumer = ConsumerService.new
    queue = consumer.declare_queue(queue_name)
    payload = consumer.consume_message(queue)
    puts "Payload received #{payload}"

    payload
  end
end
