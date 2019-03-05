require "dotenv"
Dotenv.load

require "busibe/version"
require "busibe/configuration"
require "busibe/client"

module AtlasSmsApi
  class AtlasSms
    extend Configuration
  end
end
