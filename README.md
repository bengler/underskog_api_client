Use as a global object:

require "underskog"
Underskog.access_token = "XXXXXXXXXXXXXXXXXXX"
Underskog.current_user

Use as a intance object:

require "underskog"
client_1 = Underskog::Client.new
client_1.access_token = "ZZZZZZZZZZZ"
client_1.current_user

client_2 = Underskog::Client.new
client_2.access_token = "YYYYYYYYYY"
client_2.current_user

