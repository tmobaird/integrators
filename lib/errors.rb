class FailedToFetchError < StandardError
  def initialize(response = nil, upstream = nil)
    @response = response
    @upstream = upstream
    message = parse_message
    super(message)
  end

  private

  def parse_message
    if @upstream
      "Failed to Fetch: #{@upstream.message}"
    else
      "Failed to Fetch: #{@response.code}\n#{@response.body}"
    end
  end
end

class FailedToOutputError < StandardError
  def initialize(upstream)
    @upstream = upstream
    message = parse_message
    super(message)
  end

  private

  def parse_message
    "Failed to Output: #{@upstream.message}\n#{@upstream.backtrace}"
  end
end

def raise_unless_success(response)
  raise FailedToFetchError.new(response) unless response.success?
end
