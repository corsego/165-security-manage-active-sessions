module LoginsHelper
  def device_description(user_agent)
    device = DeviceDetector.new(user_agent)
    [device.name, device.os_name, device.device_type].join(' / ')
  end
end
