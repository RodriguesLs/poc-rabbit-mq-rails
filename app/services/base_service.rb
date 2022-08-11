class BaseService
  attr_accessor :connection, :channel

  def initialize(automatically_recover = false)
    @connection = Bunny.new('amqp://rabbit:rabbit@localhost:5672', automatically_recover: automatically_recover)
  end

  def start
    @connection.start
  end

  def close
    @connection.close
  end

  def create_channel
    @channel = @connection.create_channel
  end
end
