require 'spec_helper'

module Echos
  describe Version do
    it 'responds to to_s' do
      expect(Echos::Version).to respond_to(:to_s)
    end
  end
end
