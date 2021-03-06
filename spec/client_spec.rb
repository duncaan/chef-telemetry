require "spec_helper"

RSpec.describe Chef::Telemetry::OptOutClient do
  it "should do nothing" do
    expect(subject.fire("fire!")).to be nil
  end
end

RSpec.describe Chef::Telemetry::Client do

  let(:telemetry_endpoint) { "https://my.telemetry.endpoint" }
  let(:event) { {} }
  let(:http_mock) { double(HTTP, flush: true) }

  it "initializes the http client" do
    expect(HTTP).to receive(:persistent).with(telemetry_endpoint)
    Chef::Telemetry::Client.new(telemetry_endpoint)
  end

  it "sends an event" do
    expect(subject.http).to receive(:post).with("/events", hash_including(json: event)).and_return(http_mock)
    subject.fire(event)
  end
end
