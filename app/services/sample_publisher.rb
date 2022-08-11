class SamplePublisher
  def self.send_msg_to_consumer(message, queue_name)
    publisher = PublisherService.new
    queue = publisher.declare_queue(queue_name)
    payload = message
    payload = payload.to_json
    publisher.publish_message(queue.name, payload)
    publisher.close_connection
  end
end
